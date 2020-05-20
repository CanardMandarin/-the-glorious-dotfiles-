local filesystem = require('gears.filesystem')

local config_dir = filesystem.get_configuration_dir()
local bin_dir = config_dir .. 'binaries/'

return {
	theme = "gnawesome", -- Possible value linear, floppy, gnawesome
	
	dock = {
        enabled = true,
        position = 'bottom', -- Possible value:  bottom,right,left,top
		height = 60, -- Height of the dock in pixel
		margin = 5, -- TODO Not implemented yet

		-- Here you can add widget to your dock
		-- Each widget have to be on the 'widget' folder
		-- If you want to change the spacing between each widget you can add a number in the array this will override the spacing
		widgets = { { 'search-apps', 'separator', 'tag-list', 'xdg-folders', 7 }, { 'systray', 'tray-toggler', 'wifi', 'battery', 'clock', 'layout-box', 7 }, { 'xdg-folders.trash' } }
	},
	topbar = {
		enabled = true,
		position = 'top', -- Possible value: bottom,right,left,top
		height = 28, -- Height of the topbar in pixel
		margin = 5, -- TODO Not implemented yet
		widgets = { { 'task-list', 'add-button' }, { 'time' }, { 'end-session' } }
	},

	notification = {
		widgets = { { 'notif-center' , 7 }, { 'user-profile', 'calendar' , 7 } }
	},
	
	quick_setting = {
		widgets = { { 'brightness.brightness-slider' } }
		-- widgets = { { 'brightness.brightness-slider', 'volume.volume-slider', 'wifi.wifi-toggle', 'bluetooth.bluetooth-toggle', 'blue-light', 'window-effects.blur-toggle', 'window-effects.blur-strength-slider' } }
	},

    widgets = {
        bluetooth = { },
		weather = { },
		calendar = {
			start_sunday = false,
			long_weekdays = false,
		}

	},
	
	-- The default applications in keybindings and widgets
	default = {
		terminal 										= 'kitty',                                  -- Terminal Emulator
		text_editor 									= 'code',                                  -- GUI Text Editor
		web_browser 									= 'firefox',                                -- Web browser
		file_manager 									= 'dolphin',                                -- GUI File manager
		network_manager 								= 'nm-connection-editor',					-- Network manager
		bluetooth_manager 								= 'blueman-manager',						-- Bluetooth manager
		power_manager 									= 'xfce4-power-manager',					-- Power manager
		package_manager 								= 'yay',							-- GUI Package manager
		lock 											= 'awesome-client "_G.show_lockscreen()"',  -- Lockscreen
		quake 											= 'kitty --name QuakeTerminal',             -- Quake-like Terminal

		rofiappmenu 									= 'rofi -dpi ' .. screen.primary.dpi ..
														  ' -show drun -theme ' .. config_dir ..
														  '/configuration/rofi/appmenu/rofi.rasi'   -- Application Menu

		-- You can add more default applications here
	},
	
	-- List of apps to start once on start-up

	run_on_start_up = {

		'picom -b --experimental-backends --dbus --config ' .. 
		config_dir .. '/configuration/picom.conf',   												-- Compositor

	--	'mpd',                                                                                      -- Music Server
	--	'xfce4-power-manager',                                                                      -- Power manager
	--	'/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &' .. 
	--	' eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)',                 	-- Credential manager
		
		'xrdb $HOME/.Xresources',                                                                   -- Load X Colors
		'nm-applet',                                                                                -- NetworkManager Applet
	--	'pulseeffects --gapplication-service',                                                      -- Sound Equalizer
		
	--	'xidlehook --not-when-fullscreen --not-when-audio --timer 600 '..
	--	' "awesome-client \'_G.show_lockscreen()\'" ""'  											-- Auto lock timer

		-- You can add more start-up applications here
	},

	-- List of binaries that will execute a certain task

	bins = {
		full_screenshot = bin_dir .. 'snap full',              					                    -- Full Screenshot
		area_screenshot = bin_dir .. 'snap area',			                                        -- Area Selected Screenshot
		update_profile  = bin_dir .. 'profile-image' -- Update profile picture												-- Returns CapsLock Status
	}
}
