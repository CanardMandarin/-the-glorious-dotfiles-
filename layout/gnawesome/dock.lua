local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')

local apps = require('configuration.apps')

local dpi = beautiful.xresources.apply_dpi
local clickable_container = require('widget.clickable-container')

local build_widget = require('widget.build-widget')

local dock_panel = function(s)
    local dock_config = apps.dock

	if not dock_config.enabled then
        return nil
	end
	
	local dock_height = dpi(dock_config.height)
	local dock_margin = dpi(dock_config.margin)

	local dock_orientation = 'horizontal'
	local dock_orientation_inverse = 'vertical'

	if dock_config.position	== 'left' or dock_config.position == 'right' then
		dock_orientation = 'vertical'
		dock_orientation_inverse = 'horizontal'
	end

	-- Array containing all the loaded widgets
	local dock_widgets = { layout = wibox.layout.fixed[dock_orientation] }

	-- Loaded every widget in dock.wigets => apps.lua
	for _, widget_groups in ipairs(dock_config.widgets) do
		local temp = { layout = wibox.layout.fixed[dock_orientation] }
		
		for _, widget in ipairs(widget_groups) do
			if type(widget) == "number" then
				temp['spacing'] = dpi(widget)
			else 
				table.insert(temp, require('widget.' .. widget)(s, true, dock_orientation))
			end

		end

		table.insert(dock_widgets, temp)
	end

	if dock_config.position	== 'bottom' then

		local shape = function(cr, w, h)
			gears.shape.partially_rounded_rect(cr, w, h, true, true, false, false, beautiful.groups_radius)
		end

		local panel = awful.popup {
			widget = {
				{
					layout = wibox.layout.fixed[dock_orientation],
					table.unpack(dock_widgets)
				},
				bg = beautiful.dock_bg,
				shape = shape,
				widget = wibox.container.background
			},
			type = 'dock',
			screen = s,
			ontop = true,
			visible = true,
			height = dock_height,
			maximum_height = dock_height,
			placement = dock_config.position,
			shape = shape
		}

		panel:struts
		{
			bottom = dock_height
		}

		function panel:set_visibility(is_visible)
			panel.visible = is_visible
		end

		return panel
	end

	if dock_config.position	== 'top' then

		local shape = function(cr, w, h)
			gears.shape.partially_rounded_rect(cr, w, h, false, false, true, true, beautiful.groups_radius)
		end

		local panel = awful.popup {
			widget = {
				{
					layout = wibox.layout.fixed[dock_orientation],
					table.unpack(dock_widgets)
				},
				bg = beautiful.dock_bg,
				shape = shape,
				widget = wibox.container.background
			},
			type = 'dock',
			screen = s,
			ontop = true,
			visible = true,
			height = dock_height,
			maximum_height = dock_height,
			placement = dock_config.position,
			shape = shape
		}

		panel:struts
		{
			bottom = dock_height
		}

		function panel:set_visibility(is_visible)
			panel.visible = is_visible
		end

		return panel
	end

	if dock_config.position	== 'left' then

		local shape = function(cr, w, h)
			gears.shape.partially_rounded_rect(cr, w, h, false, true, true, false, beautiful.groups_radius)
		end

		local panel = awful.popup {
			widget = {
				{
					layout = wibox.layout.fixed[dock_orientation],
					table.unpack(dock_widgets)
				},
				bg = beautiful.dock_bg,
				shape = shape,
				widget = wibox.container.background
			},
			type = 'dock',
			screen = s,
			ontop = true,
			visible = true,
			height = s.geometry.height,
			width = dock_height,
			maximum_width = dock_height,
			placement = dock_config.position,
			shape = gears.shape.rectangle,
			shape = shape
		}

		panel:struts(
			{
				left = dock_height
			}
		)

		function panel:set_visibility(is_visible)
			panel.visible = is_visible
		end

		return panel
	end

	if dock_config.position	== 'right' then

		local shape = function(cr, w, h)
			gears.shape.partially_rounded_rect(cr, w, h, true, false, false, true, beautiful.groups_radius)
		end

		local panel = awful.popup {
			widget = {
				{
					layout = wibox.layout.fixed[dock_orientation],
					table.unpack(dock_widgets)
				},
				bg = beautiful.dock_bg,
				shape = shape,
				widget = wibox.container.background
			},
			type = 'dock',
			screen = s,
			ontop = true,
			visible = true,
			height = s.geometry.height,
			width = dock_height,
			maximum_width = dock_height,
			placement = dock_config.position,
			shape = shape
		}

		panel:struts(
			{
				right = dock_height
			}
		)

		function panel:set_visibility(is_visible)
			panel.visible = is_visible
		end

		return panel
    
	end

end


return dock_panel