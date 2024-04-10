local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")

local notipower = wibox.widget({
	{
		{
			{
				{
					image = gears.filesystem.get_configuration_dir() .. "/themes/assets/bell.png",
					resize = true,
					forced_height = 25,
					forced_width = 25,
					valign = "center",
					widget = wibox.widget.imagebox,
					buttons = {
						awful.button({}, 1, function()
							awesome.emit_signal("toggle::notify")
						end),
					},
				},
				{
					image = gears.filesystem.get_configuration_dir() .. "/themes/assets/buttons/power.png",
					resize = true,
					forced_height = 20,
					forced_width = 20,
					valign = "center",
					widget = wibox.widget.imagebox,
					buttons = {
						awful.button({}, 1, function()
							awesome.emit_signal("toggle::exit")
						end),
					},
				},
				spacing = 20,
				layout = wibox.layout.fixed.horizontal,
			},
			widget = wibox.container.margin,
			left = 20,
			right = 20,
		},
		widget = wibox.container.background,
		shape = helpers.rrect(5),
		bg = beautiful.background,
	},
	widget = wibox.container.margin,
	top = 5,
	bottom = 5,
})

return notipower
