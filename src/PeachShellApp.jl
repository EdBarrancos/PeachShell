using DataStructures: Queue, Stack

export PeachShellApp
export command_prompt

abstract type PeachShellAppType <: PsApp end

struct PeachShellApp <: PeachShellAppType
    events::Queue{Event}
    history::Stack{Menu}
    systemwide_commands::Vector{Command}
end

PeachShellApp() = PeachShellApp(
    Queue{Event}(),
    push!(Stack{Menu}(), MainMenu()),
    Vector{Command}())

opening(app::PeachShellAppType) = log(app, "Welcome to PeachShellApp")
current_menu(app::PeachShellAppType)::Menu = first(app.history)
systemwide_commands(app::PeachShellAppType)::Vector{Command} = app.systemwide_commands
enter_menu(app::PeachShellAppType, menu::Menu) = begin
    push!(app.history, menu)
    enter(app, menu)
end
goto_previous_menu(app::PeachShellAppType) = begin
    pop!(app.history)
    if isempty(app.history)
        destroy(app)
    end

    enter(app, first(app.history))
end
hook_systemwide_command(app::PeachShellAppType, command::Command) = push!(
    app.systemwide_commands,
    command)

log(::PeachShellAppType, toLog...; terminator="\n") = print(reduce(*, map(string, toLog)) * terminator)
command_prompt(::PeachShellAppType)::String = "-> "
clear(::PeachShellAppType) = print("\033c")

findcommand(app::PeachShellAppType, input::AbstractString)::Union{Tuple{Command,Union{Vector,Missing}},Missing} =
    begin
        # Generic first then specific
        for command in app.systemwide_commands
            if iscommand(app, command, input)
                return (command, getargs(app, command, input))
            end
        end
        # Then search menu commands
        for command in getcommands(current_menu(app))
            if iscommand(app, command, input)
                return (command, getargs(app, command, input))
            end
        end
        return missing
    end

command_not_found(app::PeachShellAppType, input::AbstractString) = log(app, "Command \"", input, "\" not found")

runcommand(app::PeachShellAppType, input::AbstractString) = begin
    command = findcommand(app, input)
    if (ismissing(command))
        command_not_found(app, input)
        return
    end
    clear(app)
    evaluate(app, command[begin], command[end])
end

read_eval_loop(app::PeachShellAppType) = begin
    while true
        log(app, command_prompt(app), terminator="")
        commandInput = readline()
        runcommand(app, commandInput)
    end
end

boot(app::PeachShellAppType) = begin
    clear(app)
    opening(app)
    enter(app, current_menu(app))
    hook_systemwide_command(app, ExitCommand())
    hook_systemwide_command(app, BackCommand())
    hook_systemwide_command(app, MoveCommand())
    hook_systemwide_command(app, ChainCommand())
    hook_systemwide_command(app, HelpCommand())
end

destroy(app::PeachShellAppType) = begin
    log(app, "Be seing you...")
    exit()
end

start(app::PeachShellAppType) = begin
    boot(app)
    read_eval_loop(app)
end
