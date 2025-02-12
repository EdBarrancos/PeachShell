export ExitCommand, BackCommand

struct ExitCommand <: Command end

isCommand(::PsApp, ::ExitCommand, input::AbstractString)::Bool = lowercase(input) == "exit"
getArgs(::PsApp, ::ExitCommand, ::AbstractString)::Vector{AbstractString} = []
evaluate(app::PsApp, ::ExitCommand, ::Vector{AbstractString}) = destroy(app)

struct BackCommand <: Command end
isCommand(::PsApp, ::BackCommand, input::AbstractString)::Bool = lowercase(input) == "back"
getArgs(::PsApp, ::BackCommand, ::AbstractString)::Vector{AbstractString} = []
evaluate(app::PsApp, ::BackCommand, ::Vector{AbstractString}) = goToPreviousMenu(app)
