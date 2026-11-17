# dotfiles

Personal rice: Hyprland (Lua config) + sway + waybar + foot + fuzzel + nvim (LazyVim) + zsh/starship, built around a
single grayscale palette (`#111111` background, `#f2f2f2` text, muted gray/amber/teal/sage
accents — no stray hues) and a topographic contour wallpaper.

## Layout

```
hypr/       Hyprland Lua config (hyprland.lua), hyprlock.conf, xdph.conf, scripts
noctalia/   noctalia shell config.toml + Monochrome palette (Hyprland session)
sway/       sway config + scripts
waybar/     waybar config.jsonc + style.css + scripts
foot/       foot terminal config
fuzzel/     fuzzel launcher config
mako/       mako notification daemon config
swaylock/   swaylock config
environment.d/  session env (cursor theme)
zsh/        zshrc
starship/   starship prompt config
nvim/       LazyVim colorscheme ("monochrome")
firefox/    Firefox Color palette (values only, see below)
wallpaper/  topowall-generated wallpaper
```

## Install

The Hyprland config launches [noctalia](https://noctalia.dev) (Arch package: bar,
notifications, launcher, lock, polkit, wallpaper); its config is the `noctalia/` dir here. waybar/mako/fuzzel configs
are kept for the sway session.


Symlink (or copy) each piece into place:

```sh
ln -sf ~/Utils/dotfiles/hypr/hyprland.lua           ~/.config/hypr/hyprland.lua
ln -sf ~/Utils/dotfiles/hypr/hyprlock.conf          ~/.config/hypr/hyprlock.conf
ln -sf ~/Utils/dotfiles/hypr/xdph.conf             ~/.config/hypr/xdph.conf
ln -sf ~/Utils/dotfiles/hypr/scripts                ~/.config/hypr/scripts
ln -sfn ~/Utils/dotfiles/noctalia                   ~/.config/noctalia
ln -sf ~/Utils/dotfiles/wallpaper/wallpaper_1440p.png ~/.config/hypr/wallpaper_1440p.png
ln -sf ~/Utils/dotfiles/sway/config              ~/.config/sway/config
ln -sf ~/Utils/dotfiles/sway/scripts              ~/.config/sway/scripts
ln -sf ~/Utils/dotfiles/waybar/config.jsonc       ~/.config/waybar/config.jsonc
ln -sf ~/Utils/dotfiles/waybar/style.css          ~/.config/waybar/style.css
ln -sf ~/Utils/dotfiles/waybar/scripts            ~/.config/waybar/scripts
ln -sf ~/Utils/dotfiles/foot/foot.ini             ~/.config/foot/foot.ini
ln -sf ~/Utils/dotfiles/fuzzel/fuzzel.ini         ~/.config/fuzzel/fuzzel.ini
ln -sf ~/Utils/dotfiles/mako/config               ~/.config/mako/config
ln -sf ~/Utils/dotfiles/swaylock/config           ~/.config/swaylock/config
ln -sf ~/Utils/dotfiles/environment.d/cursor.conf ~/.config/environment.d/cursor.conf
ln -sf ~/Utils/dotfiles/zsh/zshrc                 ~/.zshrc
ln -sf ~/Utils/dotfiles/starship/starship.toml    ~/.config/starship.toml
ln -sf ~/Utils/dotfiles/wallpaper/wallpaper_1440p.png ~/.config/sway/wallpaper_1440p.png
```

Wallpaper was generated with [topowall](https://github.com/) (18 km wide, centered on
`37.738,-119.575`, 50 m contour interval, `graphite` theme with background `#111111` and the
brightest line color toned down to `#787878`).

### nvim (LazyVim)

Drop the colorscheme file into nvim's `colors/` runtime directory:

```sh
mkdir -p ~/.config/nvim/colors
ln -sf ~/Utils/dotfiles/nvim/monochrome.lua ~/.config/nvim/colors/monochrome.lua
```

Then tell LazyVim to use it — drop this into `~/.config/nvim/lua/plugins/`:

```sh
ln -sf ~/Utils/dotfiles/nvim/colorscheme.lua ~/.config/nvim/lua/plugins/colorscheme.lua
ln -sf ~/Utils/dotfiles/nvim/discord.lua     ~/.config/nvim/lua/plugins/discord.lua   # cord.nvim rich presence
```

(That second file just sets `opts.colorscheme = "monochrome"` on the `LazyVim/LazyVim` plugin
spec — it's what actually makes LazyVim load the theme above instead of its default.)

Note: `colors/monochrome.lua` is intentionally minimal — core UI + syntax groups only, no
per-plugin overrides (snacks, which-key, noice, mini.icons, etc). Chasing full transparency and
per-plugin highlight groups turned out to cause more inconsistencies than it was worth; anything
not explicitly set just falls back to plugin/nvim defaults.

### Firefox

The [Firefox Color](https://addons.mozilla.org/firefox/addon/firefox-color/) extension doesn't
take a file — punch these in by hand (or see `firefox/colors.md` for the reasoning):

| Field | Hex |
|---|---|
| Toolbar Color | `#111111` |
| Toolbar Icons and Text | `#f2f2f2` |
| Background Color | `#1a1a1a` |
| Background Tab Text Color | `#8a8a8a` |
| Search Bar Color | `#222222` |
| Search Text | `#f2f2f2` |
| Tab Highlight Color | `#787878` |
| Popup Background | `#1a1a1a` |
| Popup Text | `#f2f2f2` |

## Notes

- `foot.ini` sets `alpha=0.65` for terminal transparency; waybar capsules use the same
  `#111111` at 65% opacity so both read as the same "glass" material.
- Waybar's `custom/micmute` module expects `wpctl`/`pactl` (PipeWire/WirePlumber).
- `sway/config` hardcodes 3-monitor output positions (`DP-1`, `DP-2`, `HDMI-A-2`) — adjust to
  match your own `swaymsg -t get_outputs`.
