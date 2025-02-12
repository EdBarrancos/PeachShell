using DataStructures: Queue, Stack

export PeachShellApp
export commandPrompt

abstract type PeachShellAppType <: PsApp end

struct PeachShellApp <: PeachShellAppType
    events::Queue{Event}
    history::Stack{Menu}
    currentMenu::Menu
    systemWideCommands::Vector{Command}
end

PeachShellApp() = PeachShellApp(
    Queue{Event}(),
    push!(Stack{Menu}(), MainMenu()),
    MainMenu(),
    Vector{Command}())

currentWindow(app::PeachShellAppType)::Menu = first(app.history)
currentMenu(app::PeachShellAppType)::Menu = app.currentMenu
hookSystemWideCommand(app::PeachShellAppType, command::Command) = push!(
    app.systemWideCommands,
    command)

log(::PeachShellAppType, toLog...) = println(reduce(*, map(string, toLog)))
commandPrompt(::PeachShellAppType)::String = "-> "

boot(app::PeachShellAppType) = begin
    enter(app, app.currentMenu)
end

findCommand(app::PeachShellAppType, input::AbstractString)::Union{Tuple{Command,Vector{AbstractString}},Missing} =
    begin
        return missing
    end

commandNotFound(app::PeachShellAppType, input::AbstractString) = log(app, "Command \"", input, "\" not found")

readEvalLoop(app::PeachShellAppType) = begin
    while true
        print(commandPrompt(app))
        commandInput = readline()
        command = findCommand(app, commandInput)
        if (ismissing(command))
            commandNotFound(app, commandInput)
        end
    end
end

start(app::PeachShellAppType) = begin
    boot(app)
    readEvalLoop(app)
end
