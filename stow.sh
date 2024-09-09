#!/usr/bin/env bash

DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

# Create .config directory if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Function to stow config
stow_config() {
    local config="$1"
    local src="$DOTFILES_DIR/$config"
    
    # Create the config directory in dotfiles if it doesn't exist
    mkdir -p "$src/.config"
    
    # Move existing config to dotfiles if it exists and is not a symlink
    if [ -d "$CONFIG_DIR/$config" ] && [ ! -L "$CONFIG_DIR/$config" ]; then
        echo "Moving existing $config to dotfiles..."
        mv "$CONFIG_DIR/$config" "$src/.config/"
    fi
    
    echo "Stowing $config..."
    stow -d "$DOTFILES_DIR" -t "$HOME" -S "$config"
}

# Add your configs here
configs=(
    "avizo"
    "cava"
    "fish"
    "glib-2.0"
    "gtk-3.0"
    "hypr"
    "kitty"
    "lazygit"
    "mako"
    "mpv"
    "nvim"
    "nwg-displays"
    "omf"
    "pavucontrol.ini"
    "pulse"
    "QtProject.conf"
    "rofi"
    "Thunar"
    "waybar"
    "wlogout"
    "xfce4"
)

# Stow each config
for config in "${configs[@]}"; do
    stow_config "$config"
done

# Handle individual files
for file in "pavucontrol.ini" "QtProject.conf"; do
    if [ -f "$CONFIG_DIR/$file" ] && [ ! -L "$CONFIG_DIR/$file" ]; then
        mkdir -p "$DOTFILES_DIR/$file/.config"
        mv "$CONFIG_DIR/$file" "$DOTFILES_DIR/$file/.config/"
        stow -d "$DOTFILES_DIR" -t "$HOME" -S "$file"
    fi
done

echo "Dotfiles setup complete!"
