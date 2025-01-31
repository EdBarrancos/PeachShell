export Menu, Command, PsApp
export currentWindow, initializerMenu, hookSystemWideCommand, log, boot, start

abstract type Menu end;
abstract type Event end;
abstract type Command end;
abstract type PsApp end;

currentWindow(::PsApp)::Menu = error("Not Implemented")
initializerMenu(::PsApp)::Menu = error("Not Implemented")
hookMenu(::PsApp, ::Menu) = error("Not Implemented")
hookSystemWideCommand(::PsApp, ::Command) = error("Not Implemented")
boot(::PsApp) = error("Not Implemented")
start(::PsApp) = error("Not Implemented")

log(::PsApp, toLog...) = error("Not Implemented")
