local awful = require("awful")
local gears = require("gears")

local function get_mute()
	awful.spawn.easy_async_with_shell("bash -c 'pactl get-source-mute @DEFAULT_SOURCE@' &", function(value)
		local boolen = value:match("yes")
		awesome.emit_signal("signal::micmute", boolen)
	end)
end

function update_value_of_mic()
	awful.spawn.easy_async_with_shell(
		"bash -c \"pactl get-source-volume @DEFAULT_SOURCE@ | grep -oP '\\b\\d+(?=%)' | head -n 1\" &",
		function(stdout)
			local mic_int = tonumber(stdout)
			awesome.emit_signal("signal::mic", mic_int)
		end
	)
end

gears.timer({
	call_now = true,
	autostart = true,
	callback = function()
		update_value_of_mic()
	end,
	single_shot = true,
})

gears.timer({
	timeout = 1,
	call_now = true,
	autostart = true,
	callback = function()
		get_mute()
	end,
})
