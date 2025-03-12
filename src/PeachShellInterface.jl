export PsApp
export current_menu, systemwide_commands
export log, enter_menu, destroy, hook_systemwide_command, runcommand
export findcommand, command_not_found
export boot, start, read_eval_loop

export Menu
export nested, enter, hook!, isname, getcommands, name

export Command
export iscommand, getargs, evaluate, help

abstract type Menu end;
abstract type Event end;
abstract type Command end;
abstract type PsApp end;

include("InternalMacros.jl")

@interface opening(::PsApp)
@interface current_menu(::PsApp)::Menu
@interface enter_menu(::PsApp, ::Menu)
@interface goto_previous_menu(::PsApp)
@interface hook_systemwide_command(::PsApp, ::Command)
@interface systemwide_commands(::PsApp)::Vector{Command}
@interface boot(::PsApp)
@interface destroy(::PsApp)
@interface start(::PsApp)
@interface log(::PsApp, toLog...)
@interface read_eval_loop(::PsApp)
@interface findcommand(::PsApp, ::AbstractString)::Union{Tuple{Command,Vector{AbstractString}},Missing}
@interface command_not_found(::PsApp, ::AbstractString)
@interface runcommand(::PsApp, ::AbstractString)

nested(::Menu)::Vector{Menu} = []
enter(::PsApp, ::Menu) = begin end
@interface hook!(::Menu, ::Menu)
@interface isname(::Menu, ::AbstractString)
getcommands(::Menu)::Vector{Command} = []
name(::Menu)::Union{AbstractString,Missing} = missing

@interface iscommand(::PsApp, ::Command, ::AbstractString)::Bool
@interface getargs(::PsApp, ::Command, ::AbstractString)::Union{Missing,Vector}
@interface evaluate(::PsApp, ::Command, ::Union{Missing,Vector})
help(::PsApp, ::Command)::Union{AbstractString,Missing,Nothing} = missing
