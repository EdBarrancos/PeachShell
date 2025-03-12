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
currentMenu(app::PeachShellAppType)::Menu = first(app.history)
systemWideCommands(app::PeachShellAppType)::Vector{Command} = app.systemWideCommands
enterMenu(app::PeachShellAppType, menu::Menu) = begin
    push!(app.history, menu)
    enter(app, menu)
end
goToPreviousMenu(app::PeachShellAppType) = begin
    pop!(app.history)
    if isempty(app.history)
        destroy(app)
    end

    enter(app, first(app.history))
end
hookSystemWideCommand(app::PeachShellAppType, command::Command) = push!(
    app.systemWideCommands,
    command)

log(::PeachShellAppType, toLog...; terminator="\n") = print(reduce(*, map(string, toLog)) * terminator)
commandPrompt(::PeachShellAppType)::String = "-> "
clear(::PeachShellAppType) = print("\033c")

findCommand(app::PeachShellAppType, input::AbstractString)::Union{Tuple{Command,Union{Vector,Missing}},Missing} =
    begin
        # Generic first then specific
        for command in app.systemWideCommands
            if isCommand(app, command, input)
                return (command, getArgs(app, command, input))
            end
        end
        # Then search menu commands
        for command in getCommands(currentMenu(app))
            if isCommand(app, command, input)
                return (command, getArgs(app, command, input))
            end
        end
        return missing
    end

commandNotFound(app::PeachShellAppType, input::AbstractString) = log(app, "Command \"", input, "\" not found")

runCommand(app::PeachShellAppType, input::AbstractString) = begin
    command = findCommand(app, input)
    if (ismissing(command))
        commandNotFound(app, input)
        return
    end
    clear(app)
    evaluate(app, command[begin], command[end])
end

readEvalLoop(app::PeachShellAppType) = begin
    while true
        log(app, commandPrompt(app), terminator="")
        commandInput = readline()
        runCommand(app, commandInput)
    end
end

boot(app::PeachShellAppType) = begin
    clear(app)
    opening(app)
    enter(app, currentMenu(app))
    hookSystemWideCommand(app, ExitCommand())
    hookSystemWideCommand(app, BackCommand())
    hookSystemWideCommand(app, MoveCommand())
    hookSystemWideCommand(app, ChainCommand())
    hookSystemWideCommand(app, HelpCommand())
end

destroy(app::PeachShellAppType) = begin
    log(app, "Be seing you...")
    exit()
end

start(app::PeachShellAppType) = begin
    boot(app)
    readEvalLoop(app)
end
