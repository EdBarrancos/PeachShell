export Menu, Command, PsApp
export currentWindow, hookSystemWideCommand, log, boot, start, readEvalLoop, findCommand, commandNotFound
export nested, enter

abstract type Menu end;
abstract type Event end;
abstract type Command end;
abstract type PsApp end;

opening(::PsApp) = error("Not Implemeneted")
currentWindow(::PsApp)::Menu = error("Not Implemented")
currentMenu(::PsApp)::Menu = error("Not Implemented")
hookSystemWideCommand(::PsApp, ::Command) = error("Not Implemented")
boot(::PsApp) = error("Not Implemented")
destroy(::PsApp) = error("Not Implemented")
start(::PsApp) = error("Not Implemented")
log(::PsApp, toLog...) = error("Not Implemented")
readEvalLoop(::PsApp) = error("Not Implemented")
findCommand(::PsApp, ::AbstractString)::Union{Tuple{Command,Vector{AbstractString}},Missing} = error("Not Implemented")
commandNotFound(::PsApp, ::AbstractString) = error("Not Implemented")

nested(::Menu)::Vector{Menu} = error("Not Implemented")
enter(::PsApp, ::Menu) = begin end

isCommand(::PsApp, ::Command, ::AbstractString)::Bool = error("Not Implemented")
getArgs(::PsApp, ::Command, ::AbstractString)::Vector{AbstractString} = error("Not Implemented")
evaluate(::PsApp, ::Command, ::Vector{AbstractString}) = error("Not Implemented")
