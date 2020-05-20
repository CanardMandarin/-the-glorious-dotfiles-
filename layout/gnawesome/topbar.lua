local awful = require('awful')
local wibar = require('awful.wibar')
local wibox = require('wibox')
local beautiful = require('beautiful')

local gears = require('gears')

local apps = require('configuration.apps')

local icons = require('theme.icons')
local dpi = beautiful.xresources.apply_dpi

local clickable_container = require('widget.clickable-container')

local topar_panel = function(s)

    local topbar_config = apps.topbar

	if not topbar_config.enabled then
        return nil
	end

	local topbar_height = dpi(topbar_config.height)
	local topbar_margin = dpi(topbar_config.margin)

	-- Array containing all the loaded widgets
	s.topbar_widgets = { layout = wibox.layout.fixed.horizontal }

	-- Loaded every widget in dock.wigets => apps.lua
	for _, widget_groups in ipairs(topbar_config.widgets) do
		local temp = { layout = wibox.layout.fixed.horizontal }
		
		for _, widget in ipairs(widget_groups) do
			if type(widget) == "number" then
				temp['spacing'] = dpi(widget)
			else 
				table.insert(temp, require('widget.' .. widget)(s, false))
			end

		end

		table.insert(s.topbar_widgets, temp)
	end

		
	local panel = wibar
	{
		widget = {
			layout = wibox.layout.align.horizontal,
			expand = 'none',
			table.unpack(s.topbar_widgets),
		},
		ontop = true,
		screen = s,
		type = 'dock',
		height = topbar_height,
		width = s.geometry.width,
		position = topbar_config.position,
		stretch = false,
		bg = beautiful.background,
		fg = beautiful.fg_normal
	}
	
	panel:struts
	{
		top = topbar_height
	}

	panel:connect_signal(
		'mouse::enter',
		function() 
			local w = mouse.current_wibox
			if w then
				w.cursor = 'left_ptr'
			end
		end
	)
	
	function panel:set_visibility(is_visible)
		panel.visible = is_visible
	end
	
	return panel
end

return topar_panel
