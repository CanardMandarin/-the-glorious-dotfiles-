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

	-- Array containing all the loaded widgets
	local dock_widgets = { layout = wibox.layout.fixed.horizontal }

	-- Loaded every widget in dock.wigets => apps.lua
	for _, widget_groups in ipairs(dock_config.widgets) do
		local temp = { layout = wibox.layout.fixed.horizontal }
		
		for _, widget in ipairs(widget_groups) do
			if type(widget) == "number" then
				temp['spacing'] = dpi(widget)
			else 
				table.insert(temp, require('widget.' .. widget)(s, true, wibox.layout.fixed.horizontal))
			end

		end

		table.insert(dock_widgets, temp)
	end

	local panel = wibox
	{
		ontop = true,
		screen = s,
		type = 'dock',
		height = dpi(dock_height),
		width = dpi(s.geometry.width),
		x = s.geometry.x,
		y = dock_y,
		bg = beautiful.background,
		fg = beautiful.fg_normal
	}
	

	panel:struts
	{
		bottom = dock_height
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


	s.add_button = wibox.widget {
		{
			{
				{
					{
						image = icons.plus,
						resize = true,
						widget = wibox.widget.imagebox
					},
					margins = dpi(7),
					widget = wibox.container.margin
				},
				widget = clickable_container
			},
			bg = beautiful.transparent,
			shape = gears.shape.circle,
			widget = wibox.container.background
		},
		margins = dpi(10),
		widget = wibox.container.margin
	}

	s.add_button:buttons(
		gears.table.join(
			awful.button(
				{},
				1,
				nil,
				function()
					awful.spawn(
						awful.screen.focused().selected_tag.default_app,
						{
							tag = mouse.screen.selected_tag,
							placement = awful.placement.bottom_right
						}
					)
				end
			)
		)
	)


	local layout_box = function(s)
		local layoutbox = wibox.widget {
			{
				awful.widget.layoutbox(s),
				margins = dpi(7),
				widget = wibox.container.margin
			},
			widget = clickable_container
		}
		layoutbox:buttons(
			awful.util.table.join(
				awful.button(
					{},
					1,
					function()
						awful.layout.inc(1)
					end
				),
				awful.button(
					{},
					3,
					function()
						awful.layout.inc(-1)
					end
				),
				awful.button(
					{},
					4,
					function()
						awful.layout.inc(1)
					end
				),
				awful.button(
					{},
					5,
					function()
						awful.layout.inc(-1)
					end
				)
			)
		)
		return layoutbox
	end


	panel : setup {
		{
			layout = wibox.layout.align.horizontal,
			table.unpack(dock_widgets)
		},
		left = dpi(5),
		right = dpi(5),
		widget = wibox.container.margin
	}


	function panel:set_visibility(is_visible)
		panel.visible = is_visible
	end
    
	return panel
end


return dock_panel


