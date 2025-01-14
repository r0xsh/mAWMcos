local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local function create_button(icon, action)
	return wibox.widget({
		{
			id = "iconbot",
			markup = _Utils.widget.colorizeText(" ", beautiful.lighter2),
			font = beautiful.icon .. " 14",
			widget = wibox.widget.textbox,
		},
		{
			id = "icon",
			markup = _Utils.widget.colorizeText(icon, beautiful.lighter2),
			font = beautiful.icon .. " 14",
			widget = wibox.widget.textbox,
		},
		layout = wibox.layout.stack,
		buttons = {
			awful.button({}, 1, action),
		},
	})
end

return function(c)
	local buttons = {
		close = create_button("󰅙 ", function() c:kill() end),
		minimize = create_button("󰍶 ", function()
			gears.timer.delayed_call(function()
				c.minimized = not c.minimized
			end)
		end),
		maximize = create_button("󰿣 ", function() c.maximized = not c.maximized end),
	}

	local function set_button_colors(focused)
		local icon_color = focused and {
			close = beautiful.red,
			minimize = beautiful.yellow,
			maximize = beautiful.green
		} or {
			close = beautiful.lighter2,
			minimize = beautiful.lighter2,
			maximize = beautiful.lighter2
		}

		for name, btn in pairs(buttons) do
			_Utils.widget.gc(btn, "icon"):set_markup(_Utils.widget.colorizeText(
				name == "close" and "󰅙 " or name == "minimize" and "󰍶 " or "󰿣 ", icon_color[name]))
			_Utils.widget.gc(btn, "iconbot"):set_markup(_Utils.widget.colorizeText(" ", icon_color[name]))
		end
	end

	local function setup_button_hover(button)
		button:connect_signal("mouse::enter", function()
			_Utils.widget.gc(button, "iconbot"):set_markup(_Utils.widget.colorizeText(" ", beautiful.darker))
		end)
		button:connect_signal("mouse::leave", function()
			set_button_colors(client.focus == c)
		end)
	end

	for _, button in pairs(buttons) do
		setup_button_hover(button)
	end

	c:connect_signal("focus", function() set_button_colors(true) end)
	c:connect_signal("unfocus", function() set_button_colors(false) end)

	local title = wibox.widget({
		markup = c.name,
		font = beautiful.sans .. " 11",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})
	c:connect_signal("property::name", function() title.markup = c.name end)

	local icon = wibox.widget({
		widget = wibox.widget.imagebox,
		image = _Utils.icon.getIcon(c, c.class, c.class),
		forced_width = 30,
		valign = "center",
		resize = true,
	})

	local click_timer = nil
	local function handle_click()
		if click_timer then
			click_timer:stop()
			click_timer = nil
			c.maximized = true
			c:raise()
		else
			client.focus = c
			c:raise()
			if c.maximized then
				c.maximized = false
			end
			awful.mouse.client.move(c)
			click_timer = gears.timer.start_new(0.3, function()
				click_timer = nil
				return false
			end)
		end
	end

	awful.titlebar(c, {
		size = 40,
		bg = beautiful.lighter,
	}):setup {
		{
			widget = wibox.container.margin,
			left = 20,
			{
				layout = wibox.layout.fixed.horizontal,
				buttons.close,
				buttons.minimize,
				buttons.maximize,
			},
		},
		{
			{
				title,
				top = 5,
				bottom = 5,
				left = 200,
				right = 200,
				widget = wibox.container.margin,
			},
			align = "center",
			valign = "center",
			widget = wibox.container.place,
			buttons = gears.table.join(
				awful.button({}, 1, handle_click),
				awful.button({}, 3, function()
					client.focus = c
					c:raise()
					awful.mouse.client.resize(c)
				end)
			)
		},
		{
			icon,
			widget = wibox.container.margin,
			right = 20,
		},
		layout = wibox.layout.align.horizontal,
	}
end
