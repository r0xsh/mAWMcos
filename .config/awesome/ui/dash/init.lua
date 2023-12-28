local awful = require("awful")
local beautiful = require("beautiful")
local helpers = require("helpers")
local wibox = require("wibox")

local profile = require("ui.dash.mods.profile")
local pomo = require("ui.dash.mods.pomo")
local quote = require("ui.dash.mods.quote")

local song = require("ui.dash.mods.song")
local todo = require("ui.dash.mods.todo")

local time = require("ui.dash.mods.time")
local nf = require("ui.dash.mods.nf")
local weather = require("ui.dash.mods.weather")

awful.screen.connect_for_each_screen(function(s)
	local dash = wibox({
		shape = helpers.rrect(5),
		screen = s,
		width = 1000,
		height = 600,
		bg = beautiful.background_dark,
		ontop = true,
		visible = false,
	})

	dash:setup {
		{
			{
				profile,
				pomo,
				quote,
				layout = wibox.layout.align.vertical,
			},
			{
				nil,
				todo,
				song,
				layout = wibox.layout.align.vertical,
			},
			{
				time,
				nf,
				weather,
				spacing = 15,
				layout = wibox.layout.fixed.vertical,
			},
			spacing = 15,
			layout = wibox.layout.flex.horizontal,
		},
		widget = wibox.container.margin,
		margins = 15,
	}
	awful.placement.centered(dash, { honor_workarea = true, margins = 20 })
	awesome.connect_signal("toggle::dash", function()
		dash.visible = not dash.visible
	end)
	awesome.connect_signal("close::dash", function()
		dash.visible = false
	end)
end)
