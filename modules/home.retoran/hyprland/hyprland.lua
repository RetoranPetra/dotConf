hl.config({
cursor = {
  no_warps=true,
},

debug = {
  disable_logs=false,
},

decoration = {
  blur = {
    size=2,
  },

  shadow = {
    enabled=false,
  },
  rounding=2,
},

dwindle = {
  preserve_split=true,
  smart_split=true,
},
animations = {
  enabled = true,
},
general = {
  border_size=1,
    --[[
    col = {
    active_border="rgba(33ccffee) rgba(00ff99ee) 45deg",
      inactive_border = "rgba(595959aa)",
    },
    --]]
  gaps_in=5,
  gaps_out=5,
  layout="dwindle",
},

input = {
  follow_mouse=1,
  kb_layout="gb",
  kb_options="caps:escape",
  numlock_by_default=true,
  repeat_rate=25,
  sensitivity=0,
},

misc = {
  disable_splash_rendering=true,
  mouse_move_enables_dpms=true,
  vrr=1,
},
})

local primaryMonitor = "DP-1"

local mainMod = "SUPER";
local function uwsmWrap(toExec)
  return "uwsm-app -- " .. toExec
end
local function uwsmHlDispatch(toExec)
  return hl.dsp.exec_cmd(uwsmWrap(toExec))
end

local function hyprGamemode()
  local game_mode = (hl.get_config("animations.enabled") == false)

  if game_mode then
    hl.exec_cmd("hyprctl reload")
    return
  end
  hl.config({
    general = {
      gaps_in = 0,
      gaps_out = 0,
      border_size = 0,
    },
    animations = {
      enabled = false
    },
    decoration = {
      shadow = { enabled = false},
      blur = {enabled = false},
      rounding = 0,
    },
  })
end

-- Navigation bindings
hl.bind(mainMod .. " + h", hl.dsp.focus({direction = "left"}))
hl.bind(mainMod .. " + j", hl.dsp.focus({direction = "down"}))
hl.bind(mainMod .. " + k", hl.dsp.focus({direction = "up"}))
hl.bind(mainMod .. " + l", hl.dsp.focus({direction = "right"}))

-- Workspace bindings
for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({workspace = i}))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({workspace = i, follow = false}))
  hl.bind(mainMod .. " + SHIFT + CONTROL + " .. key, hl.dsp.window.move({workspace = i, follow = false}))
end
-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({workspace = "e+1"}))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({workspace = "e-1"}))
-- Window resizing
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), {mouse = true})
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), {mouse = true})

-- Essential binds
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + Q", uwsmHlDispatch("alacritty"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("sleep 1 && loginctl terminate-user ''"))
hl.bind(mainMod .. " + SHIFT + Q", uwsmHlDispatch("alacritty --class floating")) -- Need to test or modify
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("rofi -show drun -run-command \"" .. uwsmWrap("{cmd}") .. "\""))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("rofi -show window"))

-- Execution binds
hl.bind(mainMod .. " + E", uwsmHlDispatch("xdg-open ~"))
hl.bind("CTRL + SHIFT + ESCAPE", uwsmHlDispatch("alacritty -- class floating -T btop -e btop"))
hl.bind("PRINT", hl.dsp.exec_cmd(screenshotSegment))
hl.bind("CTRL + PRINT", hl.dsp.exec_cmd(screenshotDisplay))

-- TODO: Make hyprgamemode a lua function instead.
hl.bind(mainMod .. " + N", hyprGamemode)

-- Media binds
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })

local playerCtlArgs = "--player=mpv,%any,chromium,firefox"
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl " .. playerCtlArgs .. " next"),       { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl " .. playerCtlArgs .. " previous"),   { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl " .. playerCtlArgs .. " play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl " .. playerCtlArgs .. " play-pause"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl " .. playerCtlArgs .. " play-pause"), {locked = true})

-- Monitor brightness (laptop specific generally)
--[[
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
--]]

-- Execute on startup
hl.on("hyprland.start", function ()
  hl.exec_cmd("/etc/nixos/modules/home.retoran/hyprland/scripts/forcePrimary.bash " .. primaryMonitor)
  hl.exec_cmd("xrandr --output " .. primaryMonitor .. " --primary")


  -- Startup apps (this doesn't work with UWSM)
  --[[
  uwsmHlDispatch("steam.desktop")
  uwsmHlDispatch("vesktop.desktop")
  hl.dsp.exec_cmd("firefox.desktop", {workspace = 1, follow = false})
  --]]
end)

hl.on("hyprland.start", hyprGamemode)

-- Window state binds
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen(1))

--[[
bind=SUPER, A, exec, grim -g "$(slurp)" - | /nix/store/sihhjsdmf6vsfw8nl94dp61g30dm86dg-tesseract-5.5.3/bin/tesseract - - -l jpn+eng | sed 's/ //g' | wl-copy
--]]


hl.monitor({
  output = "DP-1";
  mode = "2560x1440@180";
  position = "0x0";
  scale = 1;
})
hl.monitor({
  output = "DP-2";
  mode = "2560x1440@120";
  position = "-1440x0";
  scale = 1;
  transform = 1;
})
hl.monitor({
  output = "";
  mode = "preferred";
  position = "auto";
  scale = "auto";
})

for i = 1, 5 do
  hl.workspace_rule({
    workspace = tostring(i),
    monitor = primaryMonitor,
  })
end

--[[
windowrule=float on, match:class ^floating$
windowrule=float on, match:class ^thunar$
windowrule=float on, size 720 1280, match:class ^(w|W)aydroid.*
windowrule=size 720 1280, match:class ^(w|W)aydroid.*
windowrule=float on, center on, size 1000 700, match:class ^org.kde.polkit-kde-authentication-agent-1$
windowrule=float on, center on, size 1000 700, match:class ^krita$, match:title - Krita
windowrule=float on, center on, size 1000 700, match:class ^xarchiver$
windowrule=float on, size 1000 700, center on, match:title ^(Save As|Open Files)$
windowrule=float on, size 1000 700, center on, match:class ^xdg-desktop-portal-gtk$
windowrule=float on, size 1000 700, center on, match:class ^org.freedesktop.impl.portal.desktop.kde$
windowrule=float on, center on, size 1000 700, match:class ^(zenity|yad)$
windowrule=workspace 5, match:content game
windowrule=workspace 5 silent, match:class ^steam$
windowrule=workspace 6 silent, match:class ^(WebCord|VencordDesktop|vesktop)$
--]]
