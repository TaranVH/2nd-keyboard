-- assign logical name to macro keyboard
lmc_assign_keyboard('MACROS');

taran = function (key)
	--lmc_send_keys('{F24}')
	print(key)
	local file = io.open("C:\\Users\\TaranVanHemert\\Documents\\keypressed.txt", "w")
	print("we are inside the text file")
	--io.input(file)
	file:write(key)
	file:flush()
	--print(file:read())
	file:close()
	lmc_send_keys('{F24}')
end

local config = {
	[45]  = "insert",
	[36]  = "home",
	[33]  = "pageup",
	[46]  = "delete",
	[35]  = "end",
	[34]  = "pagedown",
	[27]  = "escape",
	[112] = "F1",
	[113] = "F2",
	[114] = "F3",
	[115] = "F4",
	[116] = "F5",
	[117] = "F6",
	[118] = "F7",
	[119] = "F8",
	[120] = "F9",
	[121] = "F10",
	[122] = "F11",
	[123] = "F12",
	[8]   = "backspace",
	[220] = "backslash",
	[13]  = "enter",
	[16]  = "rShift",
	[17]  = "rCtrl",
	[38]  = "up",
	[37]  = "left",
	[40]  = "down",
	[39]  = "right",
	[32]  = "space",
	[186] = "semicolon",
	[222] = "singlequote",
	[190] = "period",
	[191] = "slash",
	[188] = "comma",
	[219] = "leftbracket",
	[221] = "rightbracket",
	[189] = "minus",
	[187] = "equals",
	[96]  = "num0",
	[97]  = "num1",
	[98]  = "num2",
	[99]  = "num3",
	[100] = "num4",
	[101] = "num5",
	[102] = "num6",
	[103] = "num7",
	[104] = "num8",
	[105] = "num9",
	[111] = "numDiv",
	[106] = "numMult",
	
	[string.byte('Q')] = "q",
	[string.byte('W')] = "w",
	[string.byte('E')] = "e",
	[string.byte('R')] = "r",
	[string.byte('T')] = "t",
	[string.byte('Y')] = "y",
	[string.byte('U')] = "u",
	[string.byte('I')] = "i",
	[string.byte('O')] = "o",
	[string.byte('P')] = "p",
	[string.byte('A')] = "a",
	[string.byte('S')] = "s",
	[string.byte('D')] = "d",
	[string.byte('F')] = "f",
	[string.byte('G')] = "g",
	[string.byte('H')] = "h",
	[string.byte('J')] = "j",
	[string.byte('K')] = "k",
	[string.byte('L')] = "l",
	[string.byte('Z')] = "z",
	[string.byte('X')] = "x",
	[string.byte('C')] = "c",
	[string.byte('V')] = "v",
	[string.byte('B')] = "b",
	[string.byte('N')] = "n",
	[string.byte('M')] = "m",
	
	
	[string.byte('1')] = "1",
	[string.byte('2')] = "2",
	[string.byte('3')] = "3",
	[string.byte('4')] = "4",
	[string.byte('5')] = "5",
	
	
	[255] = "printscreen"
}

-- define callback for whole device
lmc_set_handler('MACROS', function(button, direction)
	if (direction == 1) then return end  -- ignore down
	--if     (button == string.byte('C')) then lmc_spawn("calc")
	--elseif (button == string.byte('9')) then lmc_spawn("notepad", "C:\\test.txt")
	-- elseif (button == 9) then lmc_spawn("calc") --tab
	-- elseif (button == string.byte('0')) then lmc_spawn("notepad", "C:\\Users\\TaranVanHemert\\Documents\\testy.txt")
	-- elseif (button == string.byte('H')) then lmc_send_keys('Hello world')

	if type(config[button]) == "string" then
		taran(config[button])
	else
		print('Not yet assigned: ' .. button)
	end
end)
