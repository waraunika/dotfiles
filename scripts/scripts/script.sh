#!/usr/bin/zsh

set -euo pipefail

DOTFILES_REPO="git@github.com:waraunika/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"
BUILD_DIR="$HOME/src"           # where source-built projects live permanently
STAMP_DIR="$BUILD_DIR/.stamps"

log()  { printf '\n\033[1;32m==> %s\033[0m\n' "$1"; }
warn() { printf '\033[1;33m!! %s\033[0m\n' "$1"; }
die()  { printf '\033[1;31mxx %s\033[0m\n' "$1"; exit 1; }

[[ $EUID -eq 0 ]] && die "Run this as your normal user, not root."
command -v pacman >/dev/null || die "This is not an Arch system."

mkdir -p "$BUILD_DIR"
mkdir -p "$STAMP_DIR"

########################################
# 0. Helper Function(s)
########################################
update_repo() {
	local dir="$1" name="$2" url="$3"

	if [[ -d $dir/.git ]]; then
		log "Updating $name"
		git -C "$dir" fetch --quiet origin
		git -C "$dir" merge --ff-only '@{u}' || die "Can't fastforward $name"
	else
		log "Cloning $name"
		git clone --depth=1 "$url" "$dir"
	fi
}

build_from_git() {
	local dir=$1 name=$2 url=$3 build_fn=$4
	local stamp="$STAMP_DIR/$name" head
	
	update_repo\
		"$dir"\
		"$name"\
		"$url"

	head=$(git -C "$dir" rev-parse HEAD)

	if [[ -f $stamp && "$(<"$stamp")" == "$head" ]]; then
		log "$name already built at ${head[1,8]}"
		return
	fi

	log "Building $name"
	( cd "$dir"; $build_fn )
	print -r -- "$head" > "$stamp"
}

########################################
# 1. Base system + AUR helper (yay)
########################################
log "Updating system and installing base-devel"
sudo pacman -Syu --needed --noconfirm base-devel git

if ! command -v yay >/dev/null; then
  log "Installing yay"
  git clone https://aur.archlinux.org/yay-bin.git "$BUILD_DIR/yay-bin"
  (cd "$BUILD_DIR/yay-bin" && makepkg -si --noconfirm)
else
  log "yay already installed, skipping"
fi

########################################
# 2. Native pacman packages
#    (excludes  waybar / neovim: built from source in step 5)
########################################
log "Installing native pacman packages"

NATIVE_PKGS=(
  7zip
	awww alsa-lib alsa-utils amd-ucode android-tools arch-install-scripts audacity
	baobab blueman bluez bluez-utils brightnessctl btop bridge-utils
	cava clang
	dnsmasq
	efibootmgr emacs eza edk2-ovmf
  fastfetch feh firefox fontconfig
	gcc gcc-fortran gdu git glfw gnome-disk-utility grim grub gst-plugin-pipewire gtkwave
	htop hyprland hypridle hyprlauncher hyprlock hyprpicker hyprsunset
	iverilog iproute2
	jq jupyter-notebook
	kitty lib32-nvidia-utils
	lib32-vulkan-icd-loader libmpdclient libreoffice-fresh libsigc++ libva libxcb
	linux linux-firmware linux-headers lvm2 libvirt
	make man-db mangohud markdown-oxide matugen mdformat mesa-utils mkinitcpio mpv mtpfs
	mypaint
  networkmanager ninja nodejs noto-fonts noto-fonts-cjk noto-fonts-emoji
  ncdu npm nvidia-open-dkms nvidia-prime nvidia-settings nvidia-utils nvtop nwg-look
	octave openbox openssh openssl
	pacman-contrib pavucontrol pcmanfm-qt photoflare php pipewire pipewire-alsa
  pipewire-jack pipewire-pulse pkgconf playerctl power-profiles-daemon powertop
	progress putty python-jupyter-client python-pandas python-pylatexenc python-pynvim
	qbittorrent qemu-full
	raylib ripgrep rofi
	screengrab slurp snapshot socat sof-firmware spdlog steam stow sudo swaync
	swtpm scrcpy
	tecla texlab texlive-basic texlive-bibtexextra texlive-binextra texlive-context
	texlive-fontsextra texlive-fontsrecommended texlive-fontutils texlive-formatsextra
  texlive-games texlive-humanities texlive-latex texlive-latexextra
  texlive-latexrecommended texlive-luatex texlive-mathscience
  texlive-metapost texlive-music texlive-pictures texlive-plaingeneric
  texlive-pstricks texlive-publishers texlive-xetex thunderbird
  tmux tree tree-sitter-cli ttf-jetbrains-mono ttf-jetbrains-mono-nerd typst
	unzip
	virt-manager v4l2loopback-dkms v4l-utils
  wf-recorder wireplumber wl-clipboard wofi wpa_supplicant wtype
  xdg-desktop-portal-hyprland
	yarn yazi yelp yt-dlp
	zed zip zoxide zram-generator zsh zstd biber
)
sudo pacman -S --needed --noconfirm "${NATIVE_PKGS[@]}"

########################################
# 3. AUR / foreign packages (via yay)
########################################
log "Installing AUR packages via yay"

AUR_PKGS=(
  ascii-image-converter-bin gtkterm helium-browser-bin jmtpfs
  libcava libtexprintf lmstudio-bin musescore-bin ncurses5-compat-libs
  python-jupytext sioyek-dev thorium-browser-bin
  ttf-times-new-roman vesktop-bin whatsie wlogout woeusb xampp
  spotify
)
for pkg in "${AUR_PKGS[@]}"; do
	log "Installing AUR package: $pkg"
	yay -S --needed "$pkg"
done

########################################
# 4. Hybrid graphics setup (AMD iGPU + Nvidia dGPU / PRIME)
########################################
log "Configuring hybrid graphics (PRIME render offload)"

# Ensure nvidia modules load early and KMS is enabled — standard requirement
# for Wayland compositors (Hyprland) on hybrid Nvidia setups.
MKINITCPIO_MODULES_LINE='MODULES=(amdgpu nvidia nvidia_modeset nvidia_uvm nvidia_drm)'
if ! grep -q "nvidia_drm" /etc/mkinitcpio.conf; then
  sudo sed -i "s/^MODULES=.*/${MKINITCPIO_MODULES_LINE}/" /etc/mkinitcpio.conf
  sudo mkinitcpio -P
else
  warn "mkinitcpio.conf already references nvidia modules, skipping edit"
fi

# nvidia-drm.modeset=1 is required for Wayland/Hyprland to use the dGPU correctly
GRUB_FILE="/etc/default/grub"
if ! grep -q "nvidia-drm.modeset=1" "$GRUB_FILE"; then
  sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"/GRUB_CMDLINE_LINUX_DEFAULT="\1 nvidia-drm.modeset=1"/' "$GRUB_FILE"
  sudo grub-mkconfig -o /boot/grub/grub.cfg
else
  warn "nvidia-drm.modeset=1 already present in grub config"
fi

log "Enabling NVIDIA suspend/resume services (recommended for laptops)"
sudo systemctl enable nvidia-suspend.service nvidia-resume.service nvidia-hibernate.service 2>/dev/null || \
  warn "Could not enable nvidia power services — check package provides them on your driver version"

cat <<'EOF'

NOTE on hybrid graphics usage:
  - Run GPU-heavy apps with PRIME offload:  prime-run <command>
    (nvidia-prime provides this; confirm with `prime-run glxinfo | grep vendor`)
  - Hyprland will run on the AMD iGPU by default; the Nvidia dGPU stays available
    for offload via prime-run / DRI_PRIME=1.
EOF

########################################
# 5. Battery charge limit service (ASUS TUF specific)
########################################
log "Installing battery charge-limit systemd service (80% cap)"

sudo tee /etc/systemd/system/battery.service > /dev/null <<'EOF'
[Unit]
Description=Set battery charge limit to 80%
After=suspend.target hibernate.target

[Service]
Type=oneshot
ExecStart=/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT1/charge_control_end_threshold'
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target suspend.target hibernate.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now battery.service

log "Installing phone camera service"

echo v4l2loopback |\
	sudo tee /etc/modules-load.d/v4l2loopback.conf >/dev/null
echo 'options v4l2loopback video_nr=10 exclusive_caps=1 card_label="Phone Cam"' |\
	sudo tee /etc/modprobe.d/v4l2loopback.conf >/dev/null
sudo tee /etc/systemd/user/phone-cam.service > /dev/null <<'EOF'
[Unit]
Description=Phone camera via scrcpy

[Service]
ExecStart=/usr/bin/scrcpy --video-source=camera --camera-id=0 --camera-size=1920x1080 --camera-fps=30 --no-audio --v4l2-sink=/dev/video10 --no-playback --no-window
Restart=no
EOF
systemctl --user daemon-reload
systemctl --user start phone-cam

########################################
# 6. Source builds: Waybar, Neovim
########################################
log "Installing build dependencies for source builds"

sudo pacman -S --needed --noconfirm \
  cairo cargo cmake curl \
	fmt \
	gettext glib2-devel gtk3 gtkmm3  gtk-layer-shell \
  hyprutils hyprlang hyprcursor hyprgraphics aquamarine \
	jsoncpp \
	luajit libinput libmpdclient libxkbcommon libxkbcommon-x11 libdrm \
	libpulse libnl libdbusmenu-gtk3 \
	meson msgpack-c musl \
	ninja \
	pango pixman pkgconf \
	scdoc spdlog \
  tomlplusplus tree-sitter \
	unibilium \
	wayland wayland-protocols wlroots0.20

build_waybar() {
	log "Checking for Waybar"
  meson setup build --reconfigure 2>/dev/null || meson setup build
	ninja -C build
	sudo ninja -C build install
}

build_neovim() {
	log "Checking for NeoVim"

	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
}

build_from_git\
	"$BUILD_DIR/Waybar"\
	Waybar\
	https://github.com/alexays/waybar\
	build_waybar
build_from_git\
	"$BUILD_DIR/neovim"\
	neovim\
	https://github.com/neovim/neovim\
	build_neovim

########################################
# 7. Dotfiles via stow
########################################
log "Working on dotfiles now!"

if [[ ! -d "$DOTFILES_DIR" ]]; then
	log "Cloning dotfiles"
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
	log "Pulling latest dotfiles"
	if ! (cd "$DOTFILES_DIR" && git pull --ff-only); then
		die "Failed to update dotfiles repository"
	fi
fi

log "Dotfiles repository is ready"
cd "$DOTFILES_DIR"

stow_setup() {
	# stow every top-level config dir except non-config/meta dirs
	STOW_SKIP=(.git node_modules readme.md keybinds.md)
	STOW_TARGETS=()
	for d in */; do
		d="${d%/}"
		skip=false
		for s in "${STOW_SKIP[@]}"; do
			[[ "$d" == "$s" ]] && skip=true && break
		done
		$skip || STOW_TARGETS+=("$d")
	done

	log "Stowing: ${STOW_TARGETS[*]}"

	(
		cd "$DOTFILES_DIR" &&
		if ! stow -v 2 "${STOW_TARGETS[@]}"; then
			die "Stow failed"
		fi
	)
}

zsh_setup() {
	log "Configuring Zsh"

	update_repo \
		"$BUILD_DIR/powerlevel10k" \
		"Powerlevel10k" \
		"https://github.com/romkatv/powerlevel10k.git"

	update_repo \
		"$BUILD_DIR/zsh-autocomplete" \
		"zsh-autocomplete" \
		"https://github.com/marlonrichert/zsh-autocomplete.git"

	update_repo \
		"$BUILD_DIR/zsh-syntax-highlighting" \
		"zsh-syntax-highlighting" \
		"https://github.com/zsh-users/zsh-syntax-highlighting.git"	

	log "Zsh configuration complete"
}

stow_setup
zsh_setup

########################################
# Done
########################################
log "Bootstrap complete"

