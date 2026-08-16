#!/usr/bin/env zsh

typeset -g P10K_COLOR_MUTED="{{colors.outline.dark.hex}}"           # was 240 — faint separators/gaps
typeset -g P10K_COLOR_OS_ICON="{{colors.background.dark.hex}}"   # was 232 — OS icon fg
typeset -g P10K_COLOR_DIR="{{colors.on_primary_container.dark.hex}}"        # was 254 — current dir text
typeset -g P10K_COLOR_DIR_SHORTENED="{{colors.outline_variant.dark.hex}}"   # was 250 — shortened dir segments
typeset -g P10K_COLOR_DIR_ANCHOR="{{colors.on_surface.dark.hex}}"           # was 255 — dir anchor (bold part)
typeset -g P10K_COLOR_BRIGHT="{{colors.on_surface.dark.hex}}"       # was 255 — generic bright text (timewarrior, go_version)
