include("../src/PeachShell.jl")
using .PeachShell
import .PeachShell: enter, log, commandPrompt

opening(app::PeachShellApp) = log(app, "Welcome the MyTestingPeachShellApp")
commandPrompt(app::PeachShellApp) = "-----> "
app = PeachShellApp()
start(app)
