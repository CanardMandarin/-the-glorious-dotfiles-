local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')

local apps = require('configuration.apps')

local icons = require('theme.icons')
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
	local dock_y = (s.geometry.y + s.geometry.height) - dock_height

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
				table.insert(temp, require('widget.' .. widget)(s, false, dock_orientation))
			end

		end

		table.insert(dock_widgets, temp)
	end	

	local panel = wibox { }

	if dock_config.position	== 'bottom' then

		panel = wibox {
			screen = s,
			type = 'dock',
			ontop = true,
			bg = beautiful.background,
			fg = beautiful.fg_normal,
			width = s.geometry.width,
			height = dock_height,
			x = s.geometry.x,
			y = (s.geometry.y + s.geometry.height) - dock_height
		}

		panel:struts(
			{
				bottom = dock_height
			}
		)
	end

	if dock_config.position	== 'left' then

		panel = wibox {
			screen = s,
			type = 'dock',
			ontop = true,
			bg = beautiful.background,
			fg = beautiful.fg_normal,
			height = s.geometry.height,
			width = dock_height,
			x = s.geometry.x,
			y = s.geometry.y,
		}

		panel:struts(
			{
				left = dock_height
			}
		)

	end

	if dock_config.position	== 'right' then

		panel = wibox {
			screen = s,
			type = 'dock',
			ontop = true,
			bg = beautiful.background,
			fg = beautiful.fg_normal,
			height = s.geometry.height,
			width = dock_height,
			x = s.geometry.width - dock_height,
			y = s.geometry.y,
		}

		panel:struts(
			{
				right = dock_height
			}
		)

	end

	if dock_config.position	== 'top' then

		panel = wibox {
			screen = s,
			type = 'dock',
			ontop = true,
			bg = beautiful.background,
			fg = beautiful.fg_normal,
			width = s.geometry.width,
			height = dock_height,
			x = s.geometry.x,
			y = s.geometry.y
		}

		panel:struts(
			{
				top = dock_height
			}
		)

	end

	panel:setup {
		layout = wibox.layout.align[dock_orientation_inverse],
		nil,
		{
			id = 'panel_content',
			bg = beautiful.transparent,
			widget = wibox.container.background,
			visible = false,
			forced_width = dpi(350),
			{
				layout = wibox.layout.stack
			}
		},
		wibox.widget {
			id = 'action_bar',
			layout = wibox.layout.align[dock_orientation],
			forced_width = action_bar_width,
			{
				table.unpack(dock_widgets),
				layout = wibox.layout.fixed[dock_orientation],
			},
			nil,
		}
		-- require('layout.left-panel.action-bar')(s, panel, action_bar_width)
	}


	-- local panel =
	-- 	wibox {
	-- 	screen = s,
	-- 	width = action_bar_width,
	-- 	type = 'dock',
	-- 	height = s.geometry.height,
	-- 	x = s.geometry.x,
	-- 	y = s.geometry.y,
	-- 	ontop = true,
	-- 	bg = beautiful.background,
	-- 	fg = beautiful.fg_normal
	-- }

	-- panel:struts(
	-- 	{
	-- 		left = action_bar_width
	-- 	}
	-- )


	-- panel:setup {
	-- 	layout = wibox.layout.align.horizontal,
	-- 	nil,
	-- 	{
	-- 		id = 'panel_content',
	-- 		bg = beautiful.transparent,
	-- 		widget = wibox.container.background,
	-- 		visible = false,
	-- 		forced_width = panel_content_width,
	-- 		{
	-- 			layout = wibox.layout.stack
	-- 		}
	-- 	},
	-- 	wibox.widget {
	-- 		id = 'action_bar',
	-- 		layout = wibox.layout.align.vertical,
	-- 		forced_width = action_bar_width,
	-- 		{
	-- 			table.unpack(dock_widgets),
	-- 			layout = wibox.layout.fixed.vertical,
	-- 		},
	-- 		nil,
	-- 	}
	-- 	-- require('layout.left-panel.action-bar')(s, panel, action_bar_width)
	-- }

	function panel:set_visibility(is_visible)
		panel.visible = is_visible
	end
    
	return panel
end


return dock_panel


