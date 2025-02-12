export Menu, Command, PsApp
export currentWindow, hookSystemWideCommand, log, commandPrompt, boot, start
export nested, enter

abstract type Menu end;
abstract type Event end;
abstract type Command end;
abstract type PsApp end;

currentWindow(::PsApp)::Menu = error("Not Implemented")
currentMenu(::PsApp)::Menu = error("Not Implemented")
hookSystemWideCommand(::PsApp, ::Command) = error("Not Implemented")
boot(::PsApp) = error("Not Implemented")
start(::PsApp) = error("Not Implemented")
log(::PsApp, toLog...) = error("Not Implemented")
commandPrompt(::PsApp)::String = ""

nested(::Menu)::Vector{Menu} = Vector{Menu}()
enter(::PsApp, ::Menu) = error("Not Implemented")
