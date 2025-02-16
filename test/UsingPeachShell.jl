include("../src/PeachShell.jl")
using .PeachShell
import .PeachShell: opening, log, commandPrompt, enter, isName

opening(app::PeachShellApp) = log(app, "Welcome the MyTestingPeachShellApp")
commandPrompt(app::PeachShellApp) = "-----> "

app = PeachShellApp()

struct MyMenu <: Menu end
hook!(currentMenu(app), MyMenu())
enter(app::PsApp, ::MyMenu) = log(app, "Howdy stranger")
isName(::MyMenu, name::AbstractString) = name == "myMenu"

start(app)
