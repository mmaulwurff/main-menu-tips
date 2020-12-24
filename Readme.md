# Main Menu Tips

GZDoom script library.

This thing displays randomly selected string from a hardcoded list in the main menu.
May come in handy if someone desires to add tips/notes/etc in their mod.

## Features

- compatibility with IWADs and mods
- automatic line breaking (text takes 3/4 of screen width max)
- code can be tuned so text is displayed in other menus
- CVar to toggle on/off (tp_show_notes)

## Known Issues

I wonder if it's possible to bypass tt_MenuInjector hack. It's used to run ZScript code before the level is started.
Event handlers, even StaticEventHandler, are registered on level start.

## How to use

- change tp_ prefix to your own;
- include .zs file in your zscript lump;
- add Injector OptionMenu at the end of menudef;
- add a cvar to cvarinfo.

## License

GPLv3.
