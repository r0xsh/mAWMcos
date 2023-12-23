local switcher           = require("modules.awesome-switcher")
local gears              = require("gears")
local gfs                = require("gears.filesystem")
local themes_path        = gfs.get_configuration_dir() .. "themes/"

local theme              = {}

theme.font               = "Rubik 9"
theme.sans               = "Rubik"
theme.icon_font          = "Material Design Icons"
theme.useless_gap        = 10

-- colors --
theme.background         = "#0c0e0f"
theme.background_dark    = "#0a0b0c"
theme.background_alt     = "#141617"
theme.background_urgent  = "#161819"
theme.background_urgent1 = "#1f2122"
theme.foreground         = "#edeff0"

theme.red                = "#df5b61"
theme.green              = "#78b892"
theme.blue               = "#6791c9"
theme.yellow             = "#ecd28b"
theme.orange             = "#e89982"
theme.violet             = "#c49ec4"
theme.accent             = "#a9b1d6"


theme.wallpaper                                      = "~/.walls/forest.jpg"
theme.profile                                        = "~/.config/awesome/themes/assets/sownteedev.png"
theme.songdefpicture                                 = "~/.config/awesome/themes/assets/defsong.jpg"

-- Awesome Switcher --
switcher.settings.preview_box                        = true
switcher.settings.preview_box_bg                     = "#00000030"
switcher.settings.preview_box_border                 = "#00000030"
switcher.settings.preview_box_fps                    = 60
switcher.settings.preview_box_delay                  = 0
switcher.settings.preview_box_title_font             = { "Manrope" }
switcher.settings.preview_box_title_font_size_factor = 1
switcher.settings.preview_box_title_color            = { 255, 255, 255, 1 }

switcher.settings.client_opacity                     = true
switcher.settings.client_opacity_value               = 0.5
switcher.settings.client_opacity_value_in_focus      = 0.5
switcher.settings.client_opacity_value_selected      = 1

switcher.settings.cycle_raise_client                 = true

-- borders --
theme.border_width                                   = 0
theme.border_color_normal                            = theme.background_urgent
theme.border_color_active                            = theme.accent

-- default vars --
theme.bg_normal                                      = theme.background
theme.fg_normal                                      = theme.foreground

-- tasklist --
theme.tasklist_bg_normal                             = theme.background
theme.tasklist_bg_focus                              = theme.background_alt
theme.tasklist_bg_minimize                           = theme.background_urgent

-- taglist --
theme.taglist_bg                                     = theme.background .. "00"
theme.taglist_bg_focus                               = theme.accent
theme.taglist_fg_focus                               = theme.foreground
theme.taglist_bg_urgent                              = theme.red
theme.taglist_fg_urgent                              = theme.foreground
theme.taglist_bg_occupied                            = theme.green .. '70'
theme.taglist_fg_occupied                            = theme.foreground
theme.taglist_bg_empty                               = theme.foreground .. '33'
theme.taglist_fg_empty                               = theme.foreground
theme.taglist_disable_icon                           = true

-- Tray --
theme.bg_systray                                     = theme.background_alt
theme.systray_icon_spacing                           = 10

-- tooltips --
theme.tooltip_bg                                     = theme.background
theme.tooltip_fg                                     = theme.foreground
theme.tooltip_border_width                           = theme.border_width

-- Titlebar --
theme.titlebar_bg_normal                             = theme.background
theme.titlebar_bg_focus                              = theme.background
theme.titlebar_bg_urgent                             = theme.background

theme.layout_floating                                = gears.color.recolor_image(themes_path .. "assets/floating.png",
	theme.foreground)
theme.layout_tile                                    = gears.color.recolor_image(themes_path .. "assets/tile.png",
	theme.foreground)

return theme
