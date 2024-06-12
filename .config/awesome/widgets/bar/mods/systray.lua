local awful = require("awful")
local beautiful = require("beautiful")
local helpers = require("helpers")
local wibox = require("wibox")

local togglertext = wibox.widget({
	font = beautiful.icon .. " 18",
	text = "󰅁",
	buttons = {
		awful.button({}, 1, function()
			awesome.emit_signal("systray::toggle")
		end),
	},
	widget = wibox.widget.textbox,
})

local systray = wibox.widget({
	{
		{
			base_size = 25,
			widget = wibox.widget.systray,
		},
		widget = wibox.container.place,
		valign = "center",
	},
	visible = false,
	widget = wibox.container.margin,
	margins = 10,
})

awesome.connect_signal("systray::toggle", function()
	if systray.visible then
		systray.visible = false
		togglertext.text = "󰅁"
	else
		systray.visible = true
		togglertext.text = "󰅂"
	end
end)

local widget = wibox.widget({
	{
		{
			systray,
			togglertext,
			layout = wibox.layout.fixed.horizontal,
		},
		shape = helpers.rrect(5),
		bg = beautiful.lighter,
		widget = wibox.container.background,
		shape_border_width = beautiful.border_width_custom,
		shape_border_color = beautiful.border_color,
	},
	widget = wibox.container.margin,
	top = 10,
	bottom = 10,
})

return widget