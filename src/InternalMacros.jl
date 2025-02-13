macro interface(functionCall)
    if typeof(functionCall) != Expr
        error("Invalid syntax for interface. Example: @interface currentMenu(::PsApp)::Menu")
    end

    if (functionCall.head != :call &&
        (hasproperty(functionCall.args[begin], :head) &&
         functionCall.args[begin].head != :call))
        error("Invalid syntax for interface. Example: @interface currentMenu(::PsApp)::Menu")
    end

    return esc(quote
        $(functionCall) = error("Not Implemented")
    end)
end
