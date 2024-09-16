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
    menus::Vector{Menu}
end

PeachShellApp() = PeachShellApp(Queue{Event}(), Stack{Menu}(), Vector{Menu}())

currentwindow(app::PSApp)::Menu = first(app.history)
initializermenu(app::PSapp)::Menu = first(app.menus)
hookmenu(app::PSapp, menu::Menu) = push!(app.menus, menu)