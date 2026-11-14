local mainMod = "SUPER"
local terminal = "foot"
local shell = "qs -c myshell ipc call " -- myshell IPC prefix
local hyprDir = os.getenv("HOME") .. "/.config/hypr"

hl.monitor({
	output = "eDP-1",
	mode = "2560x1600@120",
	position = "auto",
	scale = 1,
	vrr = 1,
	-- Panel (AUO 0xE495) EDID: 10 bpc, DCI-P3-ish primaries, BT2020 + SMPTE ST2084 (PQ),
	-- ~507 nits max/frame-avg, 0.39 nits min.
	bitdepth = 10,
	cm = "edid", -- SDR desktop uses the panel's real (P3) primaries instead of clamping to sRGB
	supports_hdr = 1,
	supports_wide_color = 1,
	max_luminance = 500,
	max_avg_luminance = 500,
	min_luminance = 0.4,
})

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

for i = 1, 5 do
	hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1", default = (i == 1) })
end

hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("QT_QPA_PLATFORM", "wayland")

hl.on("hyprland.start", function()
	-- hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd(
		"dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP=Hyprland XDG_SESSION_TYPE=wayland XDG_RUNTIME_DIR MOZ_ENABLE_WAYLAND=1 ELECTRON_OZONE_PLATFORM_HINT=auto QT_QPA_PLATFORM=wayland XCURSOR_THEME=Adwaita XCURSOR_SIZE=24"
	)
	hl.exec_cmd("hyprctl setcursor Adwaita 24")
	hl.exec_cmd("swaybg -i " .. hyprDir .. "/wallpaper_1440p.png -m fill")
	-- hl.exec_cmd("mako")
	-- hl.exec_cmd("waybar")
	hl.exec_cmd(hyprDir .. "/scripts/primarymonitorset.sh")
	hl.exec_cmd("qs -c myshell")
	hl.exec_cmd("wl-paste --watch cliphist store") -- clipboard history (needs cliphist)
end)

hl.config({
	general = {
		gaps_in = 6,
		gaps_out = 12,

		border_size = 1,

		col = {
			active_border = "rgba(ffffffff)",
			inactive_border = "rgba(444444ff)",
		},

		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 16,
		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},
		blur = {
			enabled = true,
			size = 8,
			passes = 2,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
	},

	render = {
		cm_enabled = true,
		cm_auto_hdr = 2, -- switch to HDR (using EDID primaries) when a fullscreen app sends HDR content
		send_content_type = true,
	},

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		allow_session_lock_restore = true,
	},
})

hl.layer_rule({
	name = "myshell-blur",
	match = { namespace = "^myshell-.*" },
	blur = true,
	blur_popups = true,
	ignore_alpha = 0.2,
})

hl.animation({ leaf = "global", enabled = true, speed = 4, bezier = "default" })

hl.config({
	input = {
		kb_layout = "us,ru,ua",
		kb_options = "grp:win_space_toggle",

		follow_mouse = 1,

		accel_profile = "flat",
		sensitivity = 0,

		touchpad = {
			tap_to_click = true,
			natural_scroll = true,
			disable_while_typing = false,
		},
	},
})

hl.device({
	name = "asue1211:00-04f3:3211-touchpad",
	accel_profile = "adaptive",
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
-- myshell panels (qs -c myshell ipc show lists everything)
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(shell .. "panels toggle launcher"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(shell .. "panels toggle clipboard"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(shell .. "panels toggle dashboard"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(shell .. "panels toggle notifications"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(shell .. "panels toggle battery"))

hl.bind(mainMod .. " + escape", hl.dsp.exec_cmd(shell .. "panels toggle session"))
hl.bind(mainMod .. " + BackSpace", hl.dsp.exec_cmd(shell .. "lock lock"))

local dirs = { H = "left", J = "down", K = "up", L = "right" }
for key, dir in pairs(dirs) do
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = dir }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = dir }))
end

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
	hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("Return", hl.dsp.submap("reset"))
	hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region -z --clipboard-only --silent"))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + SHIFT + C", hl.dsp.reload_config())

for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
