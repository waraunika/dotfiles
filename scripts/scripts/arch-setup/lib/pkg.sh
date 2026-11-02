PAC_FLAGS=(--needed --noconfirm)

read_list() {
	sed -e 's/#.*//' "$1" | tr -s '[:space:]' '\n' | sed '/^$/d'
	# sed -e 's/#.*//' "$1"
	# # if found #, then from # to end of line
	# # 's'ubstitute it nothing (so its deleted)
	# # pipe it to tr
	# tr -s '[:space:]' '\n'
	# # take any space, and convert to new line
	# # pipe it to sed
	# sed '/^$/d'
	# # find blank lines, and delte it
}

pac_install() {
	(($#)) || return 0
	run sudo pacman -S "${PAC_FLAGS[@]}" "$@"
}

aur_install() {
	(($#)) || return 0
	command -v yay >/dev/null || ((${DRY_RUN:-0})) || die "Yay misssing (is the core module selected?)"
	run yay -S "${PAC_FLAGS[@]}" "$@"
}

# update_repo <dir> <name> <url>
update_repo() {
	local dir=$1 name=$2 url=$3
	if [[ -d $dir/.giti ]]; then
		log "Updating $name"
		run git -C "$dir" fetch --quiet origin
		run git -C "$dir" merge --ff-only '@{u}' || die "Can't fast forward $name"
	else
		log "Cloning $name"
		run git clone --depth=1 "$url" "$dir"
	fi
}

# build_from_git <dir> <name> <url> <build_fn>
build_from_git() {
	local dir=$1 name=$2 url=$3 build_fn=$4
	local stamp=$STAMP_DIR/$name head

	update_repo "$dir" "$name" "$url"
	((${DRY_RUN:-0})) && {
		log "[dry-run] wouldd nio;d $name"
		return 0
	}

	head=$(git -C "$dir" rev-parse HEAD)
	if [[ -f $stamp && "$(<"$stamp")" == "$head" ]]; then
		log "$name already built at ${head:0:8}"
		return 0
	fi
	log "Building $name"
	(cd "$dir" && "$build_fn")
	printf '%s\n' "$head" >"$stamp"
}
