# dotfiles — project notes

This repo is a personal rice for a 3-monitor Arch Linux + sway setup, built incrementally over
one long theming session. It's grayscale-first: one background/foreground palette shared across
every tool, with only a couple of restrained accent hues let in where they earn their keep
(syntax highlighting, file-type icons).

## The palette

Everything traces back to these values. When touching any config here, reuse them rather than
introducing new colors.

| Role | Hex | Used in |
|---|---|---|
| Background | `#111111` | wallpaper fill, foot bg, waybar capsule base, fuzzel bg, nvim `Normal` |
| Background (alt) | `#1a1a1a` | floats/popups, fuzzel background alpha base |
| Background (highlight) | `#242424` | nvim `CursorLine` |
| Background (visual) | `#2e2e2e` | nvim `Visual`, waybar outline (`#2e2e2e`) |
| Foreground (bright) | `#f2f2f2` / `#ffffff` | terminal fg, nvim bright text, waybar values |
| Foreground (dim) | `#cccccc` → `#999999` → `#666666` → `#4a4a4a` | graduated dim text/icons across nvim, waybar, zsh prompt separators |
| Accent: keywords | `#c9a26d` (warm amber) | nvim syntax (control flow) |
| Accent: strings | `#84a9ae` (muted teal) | nvim syntax |
| Accent: functions | `#9cbf8a` (soft sage) | nvim syntax |

Wallpaper contour lines: background `#111111`, regular lines `#5c5c5c`, index lines toned down
to `#787878` (the graphite theme's default `#949494` read as too bright/"outstanding" against
the rest of the palette).

Waybar capsules deliberately match foot's own terminal transparency exactly — same hex,
same alpha (`rgba(17,17,17,0.65)` idle → `0.85`/hover) — so the bar and terminal read as the
same "glass" material rather than two different UI languages. Capsule outlines (`#2e2e2e`,
1px) reuse sway's own inactive-window border color/width for consistency with the WM chrome.

## Per-tool notes (read before changing things)

**waybar** (`waybar/`): segmented-capsule style — every module is its own pill instead of one
flat bar-wide block. Icons are dim (`#8a8a8a`), values are bright (`#f2f2f2`), set via Pango
markup directly in `config.jsonc`'s `format` strings (waybar renders these as markup).
`#workspaces` and `#tray` are excluded from the shared hover-darken rule because their children
(workspace buttons, tray icons) are separate GTK3 widgets that don't bubble `:hover` up to the
parent — GTK3's CSS engine has no `:has()` equivalent, so "parent reacts to child hover" isn't
achievable there; each workspace button gets its own hover treatment instead. Workspace dot
brightness is a deliberately spread 4-step ladder (empty → populated-but-closed →
visible-on-another-monitor → focused) — keep meaningful gaps between them, a previous version
had populated/empty only 16 units apart and was unreadable.

**foot** (`foot/foot.ini`): `alpha=0.65`, `blur=yes`. Blur is a no-op on this system —
sway's wlroots build (`libwlroots-0.20.so`) doesn't implement `ext-background-effect-v1` yet —
but it's left enabled so it activates automatically if/when that lands upstream. ANSI palette
is fully regraded to grayscale (`regular0-7`/`bright0-7`), which is why `~/.zshrc` explicitly
overrides `ZSH_HIGHLIGHT_STYLES` for `zsh-syntax-highlighting` — that plugin's default `arg0`
style is `fg=green`, which maps to a dark gray in this palette and made typed commands
unreadable until overridden to white/bold.

**fuzzel** (`fuzzel/fuzzel.ini`): several colors (`prompt`, `input`, `placeholder`, `message`,
`counter`) must be set explicitly — if left unset they silently fall back to fuzzel's built-in
Solarized defaults (blue/orange), which will look inconsistent against everything else even
though the rest of the file looks monochrome. `prompt="❯   "` is quoted specifically to keep
its trailing spaces; unquoted trailing spaces get trimmed by fuzzel's ini parser.

**nvim** (`nvim/monochrome.lua`): intentionally minimal. An earlier version tried to cover every
LazyVim plugin's own highlight groups (snacks.nvim, which-key.nvim, noice.nvim, mini.icons) to
force full transparency and strip stray underlines everywhere. That turned into whack-a-mole —
plugins re-apply their own default highlights on the `ColorScheme` autocmd via
`nvim_set_hl(0, group, {link=..., default=true})`, which only backs off if the group *already*
resolves to a non-empty table, so `{bg="NONE"}` alone (no other attribute) was frequently
silently overridden by the plugin's own default a moment later. Diagnosed by querying
`vim.api.nvim_get_hl(0, {name=...})` directly in a live session rather than guessing from
screenshots. Current file deliberately only sets core UI + syntax groups and leaves every
plugin's own highlights at their defaults — far more predictable, at the cost of those popups
not perfectly matching the rest of the theme.

**mako** (`mako/config`): currently just `max-visible=0` (unlimited stacked notifications) —
not yet themed to match the palette.

**hypr** (`hypr/`): Hyprland 0.57+ with the **Lua** config (`hyprland.lua`, `hyprctl dispatch`
takes Lua expressions). Bar/notifications/launcher/lock/polkit come from myshell (separate repo,
started via `qs -c myshell`, panels bound through its IPC); mako/waybar/polkit-gnome execs are
commented out. `misc.allow_session_lock_restore = true` is required for the QS lock screen.
`hyprlock.conf` is the fallback lock, themed with the palette above. Started from a tty with the
`hy` alias in `zshrc`, which sets the session vars xdg-desktop-portal needs.

**sway** (`sway/config`): `client.unfocused` border color (`#444444`) and `default_border pixel
1` are the reference values waybar's capsule outlines were matched against.

## Wallpaper

Generated with `topowall`: 18 km wide, centered on `37.738,-119.575`, auto zoom, 50 m contour
interval, `graphite` theme with `background=#111111` and the bright line tier dropped from its
default `#949494` to `#787878`. Regenerate with the same center/width if you want a different
area — the theme file is not stored here, only the final PNG (`wallpaper/wallpaper_1440p.png`).

## What's deliberately not themed yet

Volume/date/quick-settings popups triggerable from waybar clicks — discussed using
SwayNotificationCenter (swaync) for a combined calendar+volume+toggles panel, or
pavucontrol/pwvucontrol + a small calendar popup as a lighter alternative. Not implemented.
