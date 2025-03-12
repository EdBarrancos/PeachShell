export ExitCommand, BackCommand, MoveCommand, ChainCommand, HelpCommand

struct ExitCommand <: Command end
iscommand(::PsApp, ::ExitCommand, input::AbstractString)::Bool = lowercase(input) == "exit"
getargs(::PsApp, ::ExitCommand, ::AbstractString)::Missing = missing
evaluate(app::PsApp, ::ExitCommand, ::Missing) = destroy(app)
help(::PsApp, ::ExitCommand) = "exit :- Exit application"

struct BackCommand <: Command end
iscommand(::PsApp, ::BackCommand, input::AbstractString)::Bool = lowercase(input) == "back"
getargs(::PsApp, ::BackCommand, ::AbstractString)::Missing = missing
evaluate(app::PsApp, ::BackCommand, ::Missing) = goto_previous_menu(app)
help(::PsApp, ::BackCommand) = "back :- Go to previou menu"

struct MoveCommand <: Command end
iscommand(app::PsApp, ::MoveCommand, input::AbstractString)::Bool = any(
    menu -> isname(menu, input),
    nested(current_menu(app)))
getargs(::PsApp, ::MoveCommand, input::AbstractString)::Vector{AbstractString} = [input]
evaluate(app::PsApp, ::MoveCommand, input::Vector{AbstractString}) = begin
    menu = first(filter(menu -> isname(menu, input[begin]), nested(current_menu(app))))
    enter_menu(app, menu)
end
help(app::PsApp, ::MoveCommand) = begin
    menus = nested(current_menu(app))
    if length(menus) == 0
        return nothing
    end
    result = "<menu_name> :- Go to menu\n"
    for menu in nested(current_menu(app))
        result *= "\t - " * (ismissing(name(menu)) ? string(typeof(menu)) : name(menu))
    end
    return result
end

struct ChainCommand <: Command end
iscommand(::PsApp, ::ChainCommand, input::AbstractString)::Bool = contains(input, '.')
getargs(::PsApp, ::ChainCommand, input::AbstractString)::Vector{AbstractString} = split(input, '.')
evaluate(app::PsApp, ::ChainCommand, input::Vector{AbstractString}) = begin
    for command in input
        runcommand(app, command)
    end
end
help(::PsApp, ::ChainCommand) = "<command>.<command>"

struct HelpCommand <: Command end
iscommand(::PsApp, ::HelpCommand, input::AbstractString)::Bool = lowercase(input) == "help"
getargs(::PsApp, ::HelpCommand, input::AbstractString)::Missing = missing
evaluate(app::PsApp, ::HelpCommand, input::Missing) = begin
    for command in systemwide_commands(app)
        helpCommand = help(app, command)
        if isnothing(helpCommand)
            continue
        end
        log(app, " - " * (ismissing(helpCommand) ? string(typeof(command)) : helpCommand))
    end
    for command in getcommands(current_menu(app))
        helpCommand = help(app, command)
        if isnothing(helpCommand)
            continue
        end
        log(app, " - " * (ismissing(helpCommand) ? string(typeof(command)) : helpCommand))
    end
end
help(::PsApp, ::HelpCommand) = nothing
