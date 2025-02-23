export ExitCommand, BackCommand, MoveCommand, ChainCommand

struct ExitCommand <: Command end
isCommand(::PsApp, ::ExitCommand, input::AbstractString)::Bool = lowercase(input) == "exit"
getArgs(::PsApp, ::ExitCommand, ::AbstractString)::Vector{AbstractString} = []
evaluate(app::PsApp, ::ExitCommand, ::Vector{AbstractString}) = destroy(app)

struct BackCommand <: Command end
isCommand(::PsApp, ::BackCommand, input::AbstractString)::Bool = lowercase(input) == "back"
getArgs(::PsApp, ::BackCommand, ::AbstractString)::Vector{AbstractString} = []
evaluate(app::PsApp, ::BackCommand, ::Vector{AbstractString}) = goToPreviousMenu(app)

struct MoveCommand <: Command end
isCommand(app::PsApp, ::MoveCommand, input::AbstractString)::Bool = any(
    menu -> isName(menu, input),
    nested(currentMenu(app)))
getArgs(::PsApp, ::MoveCommand, input::AbstractString) = [input]
evaluate(app::PsApp, ::MoveCommand, input::Vector{AbstractString}) = begin
    menu = first(filter(menu -> isName(menu, input[begin]), nested(currentMenu(app))))
    enterMenu(app, menu)
end

struct ChainCommand <: Command end
isCommand(::PsApp, ::ChainCommand, input::AbstractString)::Bool = contains(input, '.')
getArgs(::PsApp, ::ChainCommand, input::AbstractString) = split(input, '.')
evaluate(app::PsApp, ::ChainCommand, input::Vector{AbstractString}) = begin
    for command in input
        runCommand(app, command)
    end
end

