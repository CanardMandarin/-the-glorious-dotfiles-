-------------------------------------------------
-- Rofi toggler widget for Awesome Window Manager
-- Shows the application list
-- Use rofi-git master branch
-------------------------------------------------

local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')

local dpi = require('beautiful').xresources.apply_dpi
local clickable_container = require('widget.clickable-container')

local apps = require('configuration.apps')
local icons = require('theme.icons')

return function(s)
	s.systray = wibox.widget.systray()

	s.systray.opacity = 1
	s.systray.visible = false

	return wibox.widget {
		{
			base_size = dpi(20),
			horizontal = true,
			screen = 'primary',
			widget = s.systray,
		},
		top = dpi(14),
		widget = wibox.container.margin
	}

end
