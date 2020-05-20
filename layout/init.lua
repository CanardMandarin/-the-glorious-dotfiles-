local awful = require('awful')

local apps = require('configuration.apps')

-- Create a wibox panel for each screen and add it
screen.connect_signal("request::desktop_decoration", function(s)

	local dock = require('layout.' .. apps.theme .. '.dock')
	local topbar = require('layout.' .. apps.theme .. '.topbar')
	local right_panel = require('layout.' .. apps.theme .. '.notification.floating-panel')

	s.panels = { topbar(s, false), dock(s) } -- Order matter here for shadow

	s.right_panel = right_panel(s)
	s.right_panel_show_again = false

	table.insert(s.panels, s.right_panel )
end)

-- Hide bars when app go fullscreen
function updateBarsVisibility()
	for s in screen do
		focused = awful.screen.focused()
		if s.selected_tag then
			local fullscreen = s.selected_tag.fullscreenMode
			for _, panel in ipairs(s.panels) do
				if panel then
					panel:set_visibility(not fullscreen)
				end
			end
		end
	end
end

tag.connect_signal(
	'property::selected',
	function(t)
		updateBarsVisibility()
	end
)

client.connect_signal(
	'property::fullscreen',
	function(c)
		if c.first_tag then
			c.first_tag.fullscreenMode = c.fullscreen
		end
		updateBarsVisibility()
	end
)

client.connect_signal(
	'unmanage',
	function(c)
		if c.fullscreen then
			c.screen.selected_tag.fullscreenMode = false
			updateBarsVisibility()
		end
	end
)
