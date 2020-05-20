local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

local theme = { }

theme.font = 'SF Pro Text Regular' -- TODO replace font everywhere
theme.font_bold = 'SF Pro Text Bold'
theme.font_light = 'SF Pro Text UltraLight'

-- Colorscheme
theme.system_black_dark = '#3D4C5F'
theme.system_black_light = '#56687E'

theme.system_red_dark = '#EE4F84'
theme.system_red_light = '#F48FB1'

theme.system_green_dark = '#53E2AE'
theme.system_green_light = '#A1EFD3'

theme.system_yellow_dark = '#F1FF52'
theme.system_yellow_light = '#F1FA8C'

theme.system_blue_dark = '#6498EF'
theme.system_blue_light = '#92B6F4'

theme.system_magenta_dark = '#985EFF'
theme.system_magenta_light = '#BD99FF'

theme.system_cyan_dark = '#24D1E7'
theme.system_cyan_light = '#87DFEB'

theme.system_white_dark = '#E5E5E5'
theme.system_white_light = '#F8F8F2'

theme.accent = '#6498EF'
theme.background = '#00000066'
theme.transparent = '#00000000'

theme.border_radius = dpi(13)

-- Gaps
theme.useless_gap   = dpi(10)
-- This could be used to manually determine how far away from the
-- screen edge the bars / notifications should be.
theme.screen_margin = dpi(40)


local awesome_overrides = function(theme)

    -- Dock color
    theme.dock_bg = "00000000"

    theme.taglist_bg_empty = '#00000000'
    theme.taglist_bg_occupied =  '#00000000'
    theme.taglist_bg_urgent = "#E91E63" .. '99'
    theme.taglist_bg_focus = "#00000066"
    theme.taglist_spacing = dpi(0)

    theme.notification_position = 'top_right'
    theme.notification_spacing = 10
    theme.notification_margin = 0

    -- theme.bg_systray = theme.accent

end

return {
	theme = theme,
 	awesome_overrides = awesome_overrides
}
