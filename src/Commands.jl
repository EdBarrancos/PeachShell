export ExitCommand, BackCommand, MoveCommand, ChainCommand, HelpCommand

struct ExitCommand <: Command end
isCommand(::PsApp, ::ExitCommand, input::AbstractString)::Bool = lowercase(input) == "exit"
getArgs(::PsApp, ::ExitCommand, ::AbstractString)::Missing = missing
evaluate(app::PsApp, ::ExitCommand, ::Missing) = destroy(app)
help(::PsApp, ::ExitCommand) = "exit :- Exit application"

struct BackCommand <: Command end
isCommand(::PsApp, ::BackCommand, input::AbstractString)::Bool = lowercase(input) == "back"
getArgs(::PsApp, ::BackCommand, ::AbstractString)::Missing = missing
evaluate(app::PsApp, ::BackCommand, ::Missing) = goToPreviousMenu(app)
help(::PsApp, ::BackCommand) = "back :- Go to previou menu"

struct MoveCommand <: Command end
isCommand(app::PsApp, ::MoveCommand, input::AbstractString)::Bool = any(
    menu -> isName(menu, input),
    nested(currentMenu(app)))
getArgs(::PsApp, ::MoveCommand, input::AbstractString)::Vector{AbstractString} = [input]
evaluate(app::PsApp, ::MoveCommand, input::Vector{AbstractString}) = begin
    menu = first(filter(menu -> isName(menu, input[begin]), nested(currentMenu(app))))
    enterMenu(app, menu)
end
help(app::PsApp, ::MoveCommand) = begin
    menus = nested(currentMenu(app))
    if length(menus) == 0
        return nothing
    end
    result = "<menu_name> :- Go to menu\n"
    for menu in nested(currentMenu(app))
        result *= "\t - " * (ismissing(name(menu)) ? string(typeof(menu)) : name(menu))
    end
    return result
end

struct ChainCommand <: Command end
isCommand(::PsApp, ::ChainCommand, input::AbstractString)::Bool = contains(input, '.')
getArgs(::PsApp, ::ChainCommand, input::AbstractString)::Vector{AbstractString} = split(input, '.')
evaluate(app::PsApp, ::ChainCommand, input::Vector{AbstractString}) = begin
    for command in input
        runCommand(app, command)
    end
end
help(::PsApp, ::ChainCommand) = "<command>.<command>"

struct HelpCommand <: Command end
isCommand(::PsApp, ::HelpCommand, input::AbstractString)::Bool = lowercase(input) == "help"
getArgs(::PsApp, ::HelpCommand, input::AbstractString)::Missing = missing
evaluate(app::PsApp, ::HelpCommand, input::Missing) = begin
    for command in systemWideCommands(app)
        helpCommand = help(app, command)
        if isnothing(helpCommand)
            continue
        end
        log(app, " - " * (ismissing(helpCommand) ? string(typeof(command)) : helpCommand))
    end
    for command in getCommands(currentMenu(app))
        helpCommand = help(app, command)
        if isnothing(helpCommand)
            continue
        end
        log(app, " - " * (ismissing(helpCommand) ? string(typeof(command)) : helpCommand))
    end
end
help(::PsApp, ::HelpCommand) = nothing

