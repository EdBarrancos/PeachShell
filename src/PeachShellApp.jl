using DataStructures: Queue, Stack

export PeachShellApp

struct PeachShellApp <: PsApp
    events::Queue{Event}
    history::Stack{Menu}
    currentMenu::Menu
    systemWideCommands::Vector{Command}
end

PeachShellApp() = PeachShellApp(
    Queue{Event}(),
    Stack{Menu}(),
    MainMenu(),
    Vector{Command}())

currentWindow(app::PeachShellApp)::Menu = first(app.history)
currentMenu(app::PeachShellApp)::Menu = app.currentMenu
hookSystemWideCommand(app::PeachShellApp, command::Command) = push!(
    app.systemWideCommands,
    command)

log(::PeachShellApp, toLog...) = println(reduce(*, map(string, toLog)))

boot(app::PeachShellApp) = begin
    enter(app, app.currentMenu)
end

start(app::PeachShellApp) = begin
    boot(app)
end
