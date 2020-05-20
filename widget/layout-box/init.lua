local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')

local dpi = require('beautiful').xresources.apply_dpi
local clickable_container = require('widget.clickable-container')

local build_widget = require('widget.build-widget')

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

return function (s, enclose)
	return build_widget(layout_box(s), enclose)
end
