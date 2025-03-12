include("../src/PeachShell.jl")
using .PeachShell
import .PeachShell: opening, log, command_prompt, enter, isname, getcommands, name
import .PeachShell: iscommand, getargs, evaluate

opening(app::PeachShellApp) = log(app, "Welcome the MyTestingPeachShellApp")
command_prompt(app::PeachShellApp) = "-----> "

app = PeachShellApp()

struct Hi <: Command end
iscommand(::PsApp, ::Hi, input::AbstractString)::Bool = lowercase(input) == "hi"
getargs(::PsApp, ::Hi, ::AbstractString)::Vector{AbstractString} = []
evaluate(app::PsApp, ::Hi, ::Vector{AbstractString}) = log(app, "Hello Good Sir! Or Madam!")

struct MyMenu <: Menu
    commands::Vector{Command}
end
hook!(current_menu(app), MyMenu([Hi()]))
enter(app::PsApp, ::MyMenu) = log(app, "Howdy stranger")
isname(::MyMenu, name::AbstractString) = name == "myMenu"
name(::MyMenu) = "myMenu"
getcommands(menu::MyMenu) = menu.commands

start(app)
