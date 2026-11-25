local apps = require("config.app_icons")

-- Apps missing from the upstream mappings
apps["Adobe Bridge 2024"] = ":adobe_bridge:"
apps["Calibre"] = ":book:"
apps["Soulver 3"] = ":calculator:"
apps["Secrets"] = ":one_password:"
apps["Яндекс Музыка"] = ":yandex_music:"
apps["default"] = ":default:"

local text = {
	nerdfont = {
		plus = "",
		loading = "",
		apple = "",
		gear = "",
		cpu = "",
		clipboard = "󰅇",
		switch = {
			on = "󱨥",
			off = "󱨦",
		},
		clock = {
			_1 = "󱐿",
			_2 = "󱑀",
			_3 = "󱑁",
			_4 = "󱑂",
			_5 = "󱑃",
			_6 = "󱑄",
			_7 = "󱑅",
			_8 = "󱑆",
			_9 = "󱑇",
			_10 = "󱑈",
			_11 = "󱑉",
			_12 = "󱑊",
		},
		volume = {
			headphones = "",
			earbuds = "󱡏",
			_100 = "",
			_66 = "",
			_33 = "",
			_10 = "",
			_0 = "",
		},
		battery = {
			_100 = "",
			_75 = "",
			_50 = "",
			_25 = "",
			_0 = "",
			charging = "",
		},
		wifi = {
			upload = "",
			download = "",
			connected = "󰖩",
			disconnected = "󰖪",
			router = "󰑩",
		},
		media = {
			play = "",
			back = "",
			forward = "",
			pause = "",
		},
		spaces = {
			active = "",
			inactive = "",
		},
		slider = {
			knob = "",
		},
	},
}

return {
	text = text.nerdfont,
	apps = apps,
}
