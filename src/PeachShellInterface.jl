export PsApp
export currentMenu
export log, enterMenu, destroy, hookSystemWideCommand, runCommand
export findCommand, commandNotFound
export boot, start, readEvalLoop

export Menu
export nested, enter, hook!, isName, getCommands

export Command
export isCommand, getArgs, evaluate

abstract type Menu end;
abstract type Event end;
abstract type Command end;
abstract type PsApp end;

include("InternalMacros.jl")

@interface opening(::PsApp)
@interface currentMenu(::PsApp)::Menu
@interface enterMenu(::PsApp, ::Menu)
@interface goToPreviousMenu(::PsApp)
@interface hookSystemWideCommand(::PsApp, ::Command)
@interface boot(::PsApp)
@interface destroy(::PsApp)
@interface start(::PsApp)
@interface log(::PsApp, toLog...)
@interface readEvalLoop(::PsApp)
@interface findCommand(::PsApp, ::AbstractString)::Union{Tuple{Command,Vector{AbstractString}},Missing}
@interface commandNotFound(::PsApp, ::AbstractString)
@interface runCommand(::PsApp, ::AbstractString)

nested(::Menu)::Vector{Menu} = []
enter(::PsApp, ::Menu) = begin end
@interface hook!(::Menu, ::Menu)
@interface isName(::Menu, ::AbstractString)
getCommands(::Menu)::Vector{Command} = []

@interface isCommand(::PsApp, ::Command, ::AbstractString)::Bool
@interface getArgs(::PsApp, ::Command, ::AbstractString)::Vector{AbstractString}
@interface evaluate(::PsApp, ::Command, ::Vector{AbstractString})
