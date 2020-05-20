local awful = require('awful')
local wibar = require('awful.wibar')
local wibox = require('wibox')
local beautiful = require('beautiful')

local gears = require('gears')
local icons = require('theme.icons')
local dpi = require('beautiful').xresources.apply_dpi

local build_widget = require('widget.build-widget')

local clickable_container = require('widget.clickable-container')

local add_button = wibox.widget {
    {
        {
            {
                {
                    image = icons.plus,
                    resize = true,
                    widget = wibox.widget.imagebox
                },
                margins = dpi(4),
                widget = wibox.container.margin
            },
            widget = clickable_container
        },
        bg = beautiful.transparent,
        shape = gears.shape.circle,
        widget = wibox.container.background
    },
    margins = dpi(4),
    widget = wibox.container.margin
}

add_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awful.spawn(
                    awful.screen.focused().selected_tag.defaultApp,
                    {
                        tag = mouse.screen.selected_tag,
                        placement = awful.placement.bottom_right
                    }
                )
            end
        )
    )
)

return function (s, enclose)
	return build_widget(add_button, enclose)
end
