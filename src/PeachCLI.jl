using DataStructures

export Menu, Event, Command, PSapp, PeachShellApp,
    currentwindow, initializermenu

abstract type Menu end;
abstract type Event end;
abstract type Command end;
abstract type PSapp end;

struct PeachShellApp <: PSApp
    events::Queue{Event}
    history::Stack{Menu}
    menus::Vector{Menu} # Needed?
    permanentCommands::Vector{Command}
end

PeachShellApp() = PeachShellApp(
    Queue{Event}(), 
    Stack{Menu}(), 
    Vector{Menu}(), 
    Vector{Command}())

currentWindow(app::PSApp)::Menu = first(app.history)
initializerMenu(app::PSapp)::Menu = first(app.menus)
hookMenu(app::PSapp, menu::Menu) = push!(app.menus, menu)
hookPermanentCommand(app::PSapp, command::Command) = push!(
    app.permanentCommands,
    command)
