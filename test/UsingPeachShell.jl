include("../src/PeachShell.jl")
using .PeachShell
import .PeachShell: opening, log, commandPrompt, enter, isName, getCommands, name
import .PeachShell: isCommand, getArgs, evaluate

opening(app::PeachShellApp) = log(app, "Welcome the MyTestingPeachShellApp")
commandPrompt(app::PeachShellApp) = "-----> "

app = PeachShellApp()

struct Hi <: Command end
isCommand(::PsApp, ::Hi, input::AbstractString)::Bool = lowercase(input) == "hi"
getArgs(::PsApp, ::Hi, ::AbstractString)::Vector{AbstractString} = []
evaluate(app::PsApp, ::Hi, ::Vector{AbstractString}) = log(app, "Hello Good Sir! Or Madam!")

struct MyMenu <: Menu
    commands::Vector{Command}
end
hook!(currentMenu(app), MyMenu([Hi()]))
enter(app::PsApp, ::MyMenu) = log(app, "Howdy stranger")
isName(::MyMenu, name::AbstractString) = name == "myMenu"
name(::MyMenu) = "myMenu"
getCommands(menu::MyMenu) = menu.commands

start(app)
