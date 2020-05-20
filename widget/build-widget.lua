local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')

local apps = require('configuration.apps')

local dpi = beautiful.xresources.apply_dpi
local clickable_container = require('widget.clickable-container')

-- Wrapper function, should be use before returning your widget
-- enclose: if you want to enclose your widget in a square (usefull if you to place it in the dock)
return function(widget, enclose, layout)

    if not enclose then
        return widget
    end

    if apps.theme == "linear" then
        return wibox.widget {
            {
                widget,
                border_width = dpi(1),
                border_color = '#ffffff30',
                bg = beautiful.transparent,
                shape = function(cr, w, h)
                    gears.shape.rounded_rect(cr, w, h, dpi(12))
                end,
                widget = wibox.container.background
            },
            top = dpi(10),
            bottom =dpi(10),
            widget = wibox.container.margin
        }
    end
    
    return wibox.widget {
        {
            widget,
            bg = beautiful.groups_title_bg,
            shape = function(cr, w, h)
                gears.shape.rounded_rect(cr, w, h, dpi(6))
            end,
            widget = wibox.container.background
        },
        top = dpi(10),
        bottom = dpi(10),
        widget = wibox.container.margin
    }
end
