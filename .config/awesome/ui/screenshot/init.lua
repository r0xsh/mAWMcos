local wibox = require("wibox")
local helpers = require("helpers")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local animation = require("modules.animation")
local screenshot = require("ui.screenshot.mods")

local createButton = function(icon, name, fn, col)
	return wibox.widget({
		{
			{
				{
					{
						{
							font = beautiful.icon .. " 25",
							markup = icon,
							align = "center",
							widget = wibox.widget.textbox,
						},
						layout = wibox.container.margin,
						top = 10,
						left = 10,
					},
					{
						{
							font = beautiful.sans .. " 15",
							markup = name,
							align = "center",
							widget = wibox.widget.textbox,
						},
						layout = wibox.container.margin,
						bottom = 10,
					},
					layout = wibox.layout.fixed.vertical,
					spacing = 20,
				},
				widget = wibox.container.margin,
				margins = 15,
			},
			forced_width = 130,
			bg = beautiful.background,
			widget = wibox.container.background,
		},
		{
			forced_height = 5,
			forced_width = 130,
			bg = col,
			widget = wibox.container.background,
		},
		layout = wibox.layout.fixed.vertical,
		buttons = awful.button({}, 1, function()
			fn()
		end),
	})
end

awful.screen.connect_for_each_screen(function(s)
	local scrotter = wibox({
		width = 450,
		height = 240,
		shape = helpers.rrect(8),
		bg = beautiful.darker,
		ontop = true,
		visible = false,
	})
	local slide = animation:new({
		duration = 1,
		pos = 0 - scrotter.height,
		easing = animation.easing.inOutExpo,
		update = function(_, pos)
			scrotter.y = s.geometry.y + pos
		end,
	})

	local slide_end = gears.timer({
		single_shot = true,
		timeout = 1,
		callback = function()
			scrotter.visible = false
		end,
	})

	local close = function()
		slide_end:again()
		slide:set(0 - scrotter.height)
	end

	local fullscreen = createButton(" ", "Fullscreen", function()
		close()
		screenshot.full({ notify = true })
	end, beautiful.green)

	local selection = createButton(" ", "Selection", function()
		close()
		screenshot.area({ notify = true })
	end, beautiful.yellow)

	local window = createButton(" ", "Window", function()
		close()
		screenshot.window({ notify = true })
	end, beautiful.red)

	scrotter:setup({
		{
			{
				{
					{
						font = beautiful.sans .. " Bold 15",
						markup = "Screenshotter",
						align = "start",
						widget = wibox.widget.textbox,
					},
					widget = wibox.container.margin,
					margins = 15,
				},
				widget = wibox.container.background,
				bg = beautiful.lighter,
			},
			{
				fullscreen,
				selection,
				window,
				spacing = 15,
				layout = wibox.layout.fixed.horizontal,
			},
			spacing = 15,
			layout = wibox.layout.fixed.vertical,
		},
		widget = wibox.container.margin,
		margins = 15,
	})

	awesome.connect_signal("toggle::screenshot", function()
		if scrotter.visible then
			slide_end:again()
			slide:set(0 - scrotter.height)
		elseif not scrotter.visible then
			slide:set(beautiful.height / 2 - scrotter.height / 2)
			scrotter.visible = true
		end
		awful.placement.centered(scrotter)
	end)
	awesome.connect_signal("close::screenshot", function()
		close()
	end)
end)