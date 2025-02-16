export MainMenu

struct MainMenu <: Menu
    menus::Vector{Menu}
end

MainMenu() = MainMenu([])
nested(menu::MainMenu) = menu.menus
hook!(menu::MainMenu, toHook::Menu) = push!(menu.menus, toHook)
