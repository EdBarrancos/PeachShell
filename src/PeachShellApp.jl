using DataStructures: Queue, Stack

export PeachShellApp
export commandPrompt

abstract type PeachShellAppType <: PsApp end

struct PeachShellApp <: PeachShellAppType
    events::Queue{Event}
    history::Stack{Menu}
    systemWideCommands::Vector{Command}
end

PeachShellApp() = PeachShellApp(
    Queue{Event}(),
    push!(Stack{Menu}(), MainMenu()),
    Vector{Command}())

opening(app::PeachShellAppType) = log(app, "Welcome to PeachShellApp")
currentWindow(app::PeachShellAppType)::Menu = first(app.history)
currentMenu(app::PeachShellAppType)::Menu = first(app.history)
hookSystemWideCommand(app::PeachShellAppType, command::Command) = push!(
    app.systemWideCommands,
    command)

log(::PeachShellAppType, toLog...; terminator="\n") = print(reduce(*, map(string, toLog)) * terminator)
commandPrompt(::PeachShellAppType)::String = "-> "

findCommand(app::PeachShellAppType, input::AbstractString)::Union{Tuple{Command,Vector{AbstractString}},Missing} =
    begin
        return missing
    end

commandNotFound(app::PeachShellAppType, input::AbstractString) = log(app, "Command \"", input, "\" not found")

readEvalLoop(app::PeachShellAppType) = begin
    while true
        log(app, commandPrompt(app), terminator="")
        commandInput = readline()
        command = findCommand(app, commandInput)
        if (ismissing(command))
            commandNotFound(app, commandInput)
            continue
        end
    end
end

boot(app::PeachShellAppType) = begin
    opening(app)
    enter(app, currentMenu(app))
    push!(app.systemWideCommands, ExitCommand())
end

start(app::PeachShellAppType) = begin
    boot(app)
    readEvalLoop(app)
end
