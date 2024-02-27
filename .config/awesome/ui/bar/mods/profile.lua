local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")
local Launcher = require("ui.launcher")

local profile = wibox.widget({
	widget = wibox.widget.imagebox,
	image = beautiful.profile,
	forced_height = 60,
	forced_width = 60,
	resize = true,
	buttons = {
		awful.button({}, 1, function()
			Launcher:toggle()
		end),
	},
})

return profile
