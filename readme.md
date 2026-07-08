Let there be Documentation:

# Table of Contents
1. [Hyprland](#hyprland)
	A. [Window Manager](#main-window-manager)
	B. [Hypridle](#hypridle)
	C. [Hyprlock](#hyprlock)
	B. [Hyprsunset](#hyprsunset)

# Hyprland
## Main Window Manager
The main window manager I use is [Hyprland](https://wiki.hypr.land/Configuring/Start/). And based on the version I'm using currently: 0.55.4. Here's some description of the lua based configs, and there will be a separate [keybinds file](./keybinds.md)

**Main Directory**: `./hypr/.config/hypr/`

**List of Directories**:
1. Autostart:
		- 1 file: `autostart.lua`
		- Has processes that I want to be running when I enter hyprland.
		- Has: `waybar`, `swaync`, `awww-daemon`, `hyprlauncher`, `hyprsunset`, `hypridle`
2. Binds:
		- 9 files.
		- 8 of them source `variables.lua` to store default variables.
		- `application.lua`
				- file for default binds for applications
		- diwndle.lua
				- file for dwindle layout.
		- master.lua
				- file for master layout.
		- scripts.lua
				- file for binding my scripts with bindings
		- tools.lua
				- file for binding certain tools that I use
				- can be merged with `application.lua` but its more intuitive for me this way
		- unused.lua
				- I've generated a bunch of unused bindings, that I can just cut paste so that I can keep track of all that are left
		- **variables.lua**
				- maybe the binding file for my bindings that keeps everything together
				- declare keys or apps or tools as variables.
				- variables that are currently set:
						- apps: terminal, file managers, menus, browser, editor
						- mod keys: mainMod, priMod, secMod, scriptMod
3. Environment
		- 3 files
		- env.lua
			- environment variables,
			- basic setup for nvidia graphics card (laptop gpu)
			- will add later for gaming
		- permission.lua
				- when certain apps need permission, directly allow them.
				- i've only added grim as an example for remembering in future, isn't really necessary
		- window-rules.lua
				- major configuration file for window rules.
				- i use it to set floating windows when needed.
				- currently floats:
						- rofi
						- swaync-control-center
						- dolphin's copy progress
						- Picture in Picture for firefox
						- GNU Octave (GUI)'s graph output
						- GTKWave loading screen
				- other: spawn discord in 2nd workspace
4. I/O
		- keyboard.lua: for basic keyboard config (none really)
		- monitor.lua: for basic internal display and external
		- touchpad_mouse.lua: for basic configuration of mouse and touchpad (gestures)
5. Layout
		- layout.lua: configuration for layouting, sets default layout as scrolling
		- misc.lua: leftover from default hyprland config
6. Looks
		- animation.lua:
				- houses two things primarily: curves for animation and dedicating animation to certain motions.
		- decoration.lua:
				- settings related to: shadow, blur, opacity, rounding, border
		- general.lua:
				- sets gap, border size, border color
7. Scripts
		- audio_detect.sh:
				- works partially, left to debug, for hypridle
		- dpms-if-no-audio:
				- works partially, left to debug, for hypridle
		- record-soundful.sh:
				- requires: `wf-recorder` and `slurp`
				- screen records with sound on.
		- record-soundless.sh:
				- requires: `wf-recorder` and `slurp`.
				- screen records without sound.
		- rest-reminder: 
				- script to notify to take rests
		- video-playing.sh:
				- script to lock screen if not playing audio (from `audio_detect.sh`)
		- wallpaper.sh:
				- will actually start working on this when i make automated theme switcher
8. `./.luarc.json`, `./vscode`
		
## Hypridle

## Hyprlock
## Hyprsunset

# Kitty
# Matugen
# Neovim
# Tmux

# Vim
# Waybar
# Zathura

# Zsh


Install stow

then inside dotfiles directory, just enter like:

```stow hypr```

and all hypr related config will be generated in the right place.
