export ExitCommand

struct ExitCommand <: Command end;

isCommand(::PsApp, ::ExitCommand, input::AbstractString)::Bool = input == "exit"
getArgs(::PsApp, ::ExitCommand, ::AbstractString)::Vector{AbstractString} = []
evaluate(app::PsApp, ::ExitCommand, ::Vector{AbstractString}) = destroy(app)
