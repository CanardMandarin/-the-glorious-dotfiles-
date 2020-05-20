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
local build_widget = require('widget.build-widget')

local apps = require('configuration.apps')
local icons = require('theme.icons')

local return_button = function(s)

	local widget = wibox.widget {
		{
			id = 'icon',
			image = icons.menu,
			widget = wibox.widget.imagebox,
			resize = true
		},
		layout = wibox.layout.align.horizontal
	}

	local widget_button = wibox.widget {
		{
			widget,
			margins = dpi(10),
			widget = wibox.container.margin
		},
		widget = clickable_container
	}

	widget_button:buttons(
		gears.table.join(
			awful.button(
				{},
				1,
				nil,
				function()
					awful.spawn(apps.default.rofiappmenu, false)
				end
			)
		)
	)


	return widget_button
end

return function (s, enclose)
	if apps.theme == "gnawesome" then
		return return_button(s)
	end
	
	return build_widget(return_button(s), enclose)
end
