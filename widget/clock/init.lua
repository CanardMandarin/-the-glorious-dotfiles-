
local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local naughty = require('naughty') 
local beautiful = require('beautiful') 

local watch = awful.widget.watch

local apps = require('configuration.apps')
local clickable_container = require('widget.clickable-container')

local build_widget = require('widget.build-widget')
local dpi = beautiful.xresources.apply_dpi


local return_button = function(s)


	s.clock_widget = wibox.widget {
		{
			wibox.widget.textclock(
				'<span font="' .. beautiful.font_bold .. ' 11">%l:%M %p</span>',
				1
			),
			margins = dpi(7),
			widget = wibox.container.margin
		},
		widget = clickable_container
	}


	s.clock_widget:connect_signal(
		'mouse::enter',
		function()
			local w = mouse.current_wibox
			if w then
				old_cursor, old_wibox = w.cursor, w
				w.cursor = 'hand1'
			end
		end
	)


	s.clock_widget:connect_signal(
		'mouse::leave',
		function()
			if old_wibox then
				old_wibox.cursor = old_cursor
				old_wibox = nil
			end
		end
	)

	s.clock_tooltip = awful.tooltip
	{
		objects = {s.clock_widget},
		mode = 'outside',
		delay_show = 1,
		preferred_positions = {'right', 'left', 'top', 'bottom'},
		preferred_alignments = {'middle'},
		margin_leftright = dpi(8),
		margin_topbottom = dpi(8),
		timer_function = function()
		
			local ordinal = nil

			local day = os.date('%d')
			local month = os.date('%B')

			local first_digit = string.sub(day, 0, 1) 
			local last_digit = string.sub(day, -1) 

			if first_digit == '0' then
			  day = last_digit
			end


			if last_digit == '1' and day ~= '11' then
			  ordinal = 'st'
			elseif last_digit == '2' and day ~= '12' then
			  ordinal = 'nd'
			elseif last_digit == '3' and day ~= '13' then
			  ordinal = 'rd'
			else
			  ordinal = 'th'
			end

			local date_str = 'Today is the ' ..
			'<b>' .. day .. ordinal .. 
			' of ' .. month .. '</b>.\n' ..
			'And it\'s fucking ' .. os.date('%A')

			return date_str

		end,
	}


	s.clock_widget:connect_signal(
		'button::press', 
		function(self, lx, ly, button)
			-- Hide the tooltip when you press the clock widget
			if s.clock_tooltip.visible and button == 1 then
				s.clock_tooltip.visible = false
			end
		end
	)


	return s.clock_widget

end

return function (s, enclose)
	return build_widget(return_button(s), enclose)
end
