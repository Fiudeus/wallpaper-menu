# Wallpaper Menu

A simple Bash utility for selecting and applying wallpapers on GNOME with YAD and pywal.

The script scans a wallpaper directory, displays available images in a graphical menu, applies the selected image as the GNOME wallpaper, and updates the color scheme using pywal.

## Requirements

* Bash
* GNOME
* YAD
* pywal

On Arch Linux, install the dependencies with:

```bash
sudo pacman -S yad python-pywal
```

## Installation

Clone the repository:

```bash
git clone https://github.com/Fiudeus/wallpaper-menu.git
cd wallpaper-menu
```

Make the script executable:

```bash
chmod +x wallpaper-menu.sh
```

Install it to `~/bin`:

```bash
mkdir -p ~/bin
cp wallpaper-menu.sh ~/bin/wallpaper-menu
```

Make sure `~/bin` is included in your `$PATH`.

The script can now be launched with:

```bash
wallpaper-menu
```

By default, wallpapers are searched for in:

```text
~/Pictures/Wallpapers
```

Supported formats:

* `.jpg`
* `.jpeg`
* `.png`

## GNOME Keyboard Shortcut

You can bind the script to a custom GNOME keyboard shortcut.

The following commands add a `Ctrl + Shift + /` shortcut without removing existing custom shortcuts:

```bash
KEYBINDING="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/wallpaper-menu/"
SCHEMA="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEYBINDING}"

CURRENT_BINDINGS=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

if [[ "$CURRENT_BINDINGS" != *"$KEYBINDING"* ]]; then
    if [[ "$CURRENT_BINDINGS" == "@as []" ]]; then
        NEW_BINDINGS="['${KEYBINDING}']"
    else
        NEW_BINDINGS="${CURRENT_BINDINGS%]}"
        NEW_BINDINGS="${NEW_BINDINGS}, '${KEYBINDING}']"
    fi

    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
        "$NEW_BINDINGS"
fi

gsettings set "$SCHEMA" name "Change wallpaper"
gsettings set "$SCHEMA" command "$HOME/bin/wallpaper-menu"
gsettings set "$SCHEMA" binding "<Control><Shift>slash"
```

After that, pressing `Ctrl + Shift + /` will open the wallpaper selection menu.
