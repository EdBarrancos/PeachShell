include("../src/PeachShell.jl")
using .PeachShell
import .PeachShell: enter, log

enter(app::PeachShellApp, ::MainMenu) = log(app, "Welcome the MyTestingPeachShellApp")

app = PeachShellApp()
start(app)
