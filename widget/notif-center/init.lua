local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi

local build_widget = require('widget.build-widget')

local notif_header = wibox.widget {
	text   = 'Notification Center',
	font   = 'SF Pro Text Bold 16',
	align  = 'left',
	valign = 'bottom',
	widget = wibox.widget.textbox
}

local return_widget =  wibox.widget {
	expand = 'none',
	layout = wibox.layout.fixed.vertical,
	spacing = dpi(10),
	{
		expand = 'none',
		layout = wibox.layout.align.horizontal,
		notif_header,
		nil,
		{
			layout = wibox.layout.fixed.horizontal,
			spacing = dpi(5),
			require('widget.notif-center.dont-disturb'),
			require('widget.notif-center.clear-all')
		},
	},
	require('widget.notif-center.build-notifbox')
}

return function (s, enclose)
	return build_widget(return_widget, enclose)
end
