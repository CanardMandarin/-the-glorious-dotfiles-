local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')

local apps = require('configuration.apps')

local dpi = beautiful.xresources.apply_dpi

panel_visible = false

local right_panel = function(s)

	-- Set right panel geometry
	local panel_width = dpi(700)
	local panel_height = s.geometry.height - dpi(38)
	local panel_margins = dpi(5)

	local separator = wibox.widget {
		orientation = 'horizontal',
		opacity = 0.0,
		forced_height = 15,
		widget = wibox.widget.separator,
	}

	-- Array containing all the loaded widgets
	s.notification_widgets = { layout = wibox.layout.fixed.horizontal }

	-- Loaded every widget in dock.wigets => apps.lua
	for _, widget_groups in ipairs(apps.notification.widgets) do
		local temp = { layout = wibox.layout.fixed.vertical }
		
		for _, widget in ipairs(widget_groups) do
			if type(widget) == "number" then
				temp['spacing'] = dpi(widget)
			else 
				table.insert(temp, require('widget.' .. widget)(s, false))
			end

		end

		table.insert(s.notification_widgets, temp)
	end
	

	local panel = awful.popup {
		widget = {
			{
				{
					expand = 'none',
					layout = wibox.layout.fixed.vertical,
					{
						layout = wibox.layout.align.horizontal,
						expand = 'none',
						nil,
						require('layout.gnawesome.notification.panel-mode-switcher'),
						nil
					},
					separator,
					{
						layout = wibox.layout.stack,
						{
							id = 'pane_id',
							visible = true,
							layout = wibox.layout.fixed.vertical,
							{
								layout = wibox.layout.flex.horizontal,
								spacing = dpi(7),
								table.unpack(s.notification_widgets),
							},
						},
						{
							id = 'settings_id',
							visible = false,
							require('layout.gnawesome.notification.settings')(s),
							layout = wibox.layout.fixed.vertical
						}
					},
				},
				margins = dpi(16),
				widget = wibox.container.margin
			},
			--bg = beautiful.background,
			shape = function(cr, w, h)
				gears.shape.rounded_rect(cr, w, h, beautiful.groups_radius)
			end,
			widget = wibox.container.background
		},
		screen = s,
		type = 'dock',
		visible = false,
		ontop = true,
		width = panel_width,
		maximum_height = panel_height,
		maximum_width = panel_width,
		height = s.geometry.height,
		shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, beautiful.groups_radius)
		end,
	}

	awful.placement.centered(panel, {margins = {
		-- right = panel_margins,
		top = s.geometry.y + dpi(65)
		}, parent = s
	})

	panel.opened = false

	s.backdrop_rdb = wibox
	{
		ontop = true,
		screen = s,
		bg = beautiful.transparent,
		type = 'utility',
		x = s.geometry.x,
		y = s.geometry.y,
		width = s.geometry.width,
		height = s.geometry.height
	}

	panel:struts
	{
		right = 0
	}
	
	function panel:set_visibility(visible)
		local focused = awful.screen.focused()

		if not visible and focused.right_panel.visible then
			focused.right_panel:toggle()
			focused.right_panel_show_again = true
		elseif fullscreen and not focused.right_panel.visible and focused.right_panel_show_again then
			focused.right_panel:toggle()
			focused.right_panel_show_again = false
		end
	end

	open_panel = function()
		local focused = awful.screen.focused()
		panel_visible = true

		focused.backdrop_rdb.visible = true
		focused.right_panel.visible = true

		panel:emit_signal('opened')
	end

	close_panel = function()
		local focused = awful.screen.focused()
		panel_visible = false

		focused.right_panel.visible = false
		focused.backdrop_rdb.visible = false
		
		panel:emit_signal('closed')
	end

	-- Hide this panel when app dashboard is called.
	function panel:HideDashboard()
		close_panel()
	end

	function panel:toggle()
		self.opened = not self.opened
		if self.opened then
			open_panel()
		else
			close_panel()
		end
	end

	function panel:switch_pane(mode)
		if mode == 'today_mode' then
			-- Update Content
			panel.widget:get_children_by_id('settings_id')[1].visible = false
			panel.widget:get_children_by_id('pane_id')[1].visible = true
		elseif mode == 'settings_mode' then
			-- Update Content
			panel.widget:get_children_by_id('pane_id')[1].visible = false
			panel.widget:get_children_by_id('settings_id')[1].visible = true
		end
	end

	s.backdrop_rdb:buttons(
		awful.util.table.join(
			awful.button(
				{},
				1,
				nil,
				function()
					panel:toggle()
				end
			)
		)
	)

	return panel
end

return right_panel
