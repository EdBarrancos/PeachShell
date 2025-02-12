include("../src/PeachShell.jl")
using .PeachShell
import .PeachShell: enter, log, commandPrompt

enter(app::PeachShellApp, ::MainMenu) = log(app, "Welcome the MyTestingPeachShellApp")
commandPrompt(app::PeachShellApp) = "----->"
app = PeachShellApp()
start(app)
