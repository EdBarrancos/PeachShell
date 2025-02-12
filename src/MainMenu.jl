export MainMenu

struct MainMenu <: Menu end;

enter(app::PsApp, ::MainMenu) = log(app, "Welcome to PsApp")
