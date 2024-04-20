local awful = require("awful")
local beautiful = require("beautiful")
local helpers = require("helpers")
local wibox = require("wibox")

local buttons = require(... .. ".mods.buttons")
local sliders = require(... .. ".mods.slider")
local footer = require(... .. ".mods.footer")
local bottom = require(... .. ".mods.bottom")
require(... .. ".mods.music")

awful.screen.connect_for_each_screen(function(s)
	local control = wibox({
		screen = s,
		width = beautiful.width / 4,
		height = (beautiful.height / 3) * 1.41,
		ontop = true,
		visible = false,
	})

	control:setup({
		{
			{
				footer,
				sliders,
				buttons,
				bottom,
				layout = wibox.layout.fixed.vertical,
				spacing = 25,
			},
			widget = wibox.container.margin,
			margins = 15,
		},
		widget = wibox.container.background,
		bg = beautiful.background,
		shape = helpers.rrect(5),
		shape_border_width = beautiful.border_width_custom,
		shape_border_color = beautiful.border_color,
	})

	helpers.placeWidget(control, "bottom_right", 0, 2, 0, 2)
	awesome.connect_signal("toggle::control", function()
		control.visible = not control.visible
	end)
	awesome.connect_signal("close::control", function()
		control.visible = false
	end)
end)
