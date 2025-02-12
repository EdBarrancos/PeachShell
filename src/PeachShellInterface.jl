export Menu, Command, PsApp
export currentWindow, hookSystemWideCommand, log, boot, start, readEvalLoop, findCommand, commandNotFound
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
readEvalLoop(::PsApp) = error("Not Implemented")
findCommand(::PsApp, ::AbstractString)::Union{Tuple{Command,Vector{AbstractString}},Missing} = error("Not Implemented")
commandNotFound(::PsApp, ::AbstractString) = begin end

nested(::Menu)::Vector{Menu} = Vector{Menu}()
enter(::PsApp, ::Menu) = error("Not Implemented")
