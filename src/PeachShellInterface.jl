export PsApp
export currentMenu
export log, findCommand, commandNotFound, hookSystemWideCommand
export boot, start, readEvalLoop, destroy

export Menu
export nested, enter

export Command
export isCommand, getArgs, evaluate

abstract type Menu end;
abstract type Event end;
abstract type Command end;
abstract type PsApp end;

include("InternalMacros.jl")

@interface opening(::PsApp)
@interface currentMenu(::PsApp)::Menu
@interface goToPreviousMenu(::PsApp)
@interface hookSystemWideCommand(::PsApp, ::Command)
@interface boot(::PsApp)
@interface destroy(::PsApp)
@interface start(::PsApp)
@interface log(::PsApp, toLog...)
@interface readEvalLoop(::PsApp)
@interface findCommand(::PsApp, ::AbstractString)::Union{Tuple{Command,Vector{AbstractString}},Missing}
@interface commandNotFound(::PsApp, ::AbstractString)

@interface nested(::Menu)::Vector{Menu}
enter(::PsApp, ::Menu) = begin end

@interface isCommand(::PsApp, ::Command, ::AbstractString)::Bool
@interface getArgs(::PsApp, ::Command, ::AbstractString)::Vector{AbstractString}
@interface evaluate(::PsApp, ::Command, ::Vector{AbstractString})
