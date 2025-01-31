using DataStructures

include("PeachShellInterface.jl")

export PeachShellApp

struct PeachShellApp <: PsApp
    events::Queue{Event}
    history::Stack{Menu}
    menus::Vector{Menu} # Needed?
    systemWideCommands::Vector{Command}
end

PeachShellApp() = PeachShellApp(
    Queue{Event}(),
    Stack{Menu}(),
    Vector{Menu}(),
    Vector{Command}())

currentWindow(app::PeachShellApp)::Menu = first(app.history)
initializerMenu(app::PeachShellApp)::Menu = first(app.menus)
hookMenu(app::PeachShellApp, menu::Menu) = push!(app.menus, menu)
hookSystemWideCommand(app::PeachShellApp, command::Command) = push!(
    app.systemWideCommands,
    command)

log(::PeachShellApp, toLog...) = println(reduce(*, map(string, toLog)))

boot(app::PeachShellApp) = begin
    log(app, "Booting...")
    log(app, "...Booted")
end

start(app::PeachShellApp) = begin
    boot(app)
end
