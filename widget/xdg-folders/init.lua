local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')

local dpi = require('beautiful').xresources.apply_dpi
local build_widget = require('widget.build-widget')
local apps = require('configuration.apps')

local return_button = function(s, orientation)
	layout = wibox.layout.align.horizontal
	layout2 = wibox.layout.fixed.horizontal

	if orientation == 'vertical' then
		layout = wibox.layout.align.vertical
		layout2 = wibox.layout.fixed.vertical
	end

	return wibox.widget {
		layout = layout,
		{
			require("widget.xdg-folders.home"),
			require("widget.xdg-folders.documents"),
			require("widget.xdg-folders.downloads"),
			-- require("widget.xdg-folders.pictures"),
			-- require("widget.xdg-folders.videos"),
			layout = layout2
		},
	}
end

return function (s, enclose, orientation)
	if apps.theme == "gnawesome" then
		return return_button(s, orientation)
	end
	
	return build_widget(return_button(s, orientation), enclose)
end
