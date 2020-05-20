local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')

local build_widget = require('widget.build-widget')

local clickable_container = require('widget.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi

local HOME = os.getenv('HOME')

local recorder_table = require('widget.screen-recorder.screen-recorder-ui')

require('widget.screen-recorder.screen-recorder-ui-backend')
 
local screen_rec_toggle_button = recorder_table.screen_rec_toggle_button


local return_button = function(s)

	return screen_rec_toggle_button

end

return function (s, enclose)
	return build_widget(return_button(s), enclose)
end
