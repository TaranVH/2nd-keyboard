-- get luamacros here: http://www.hidmacros.eu/
-- plug in your 2nd keyboard, load this script into LUAmacros, and press the triangle PLAY button.

local config_file = "config.txt"

-- Attempt to map the keyboard config file if it exists
local config = io.open(config_file, "r")
if(config ~= nil) then
  local device_string = config:read()
  if(device_string ~= nil and device_string ~= '') then
    lmc_device_set_name('MACROS', device_string)
  end
  config:close()
end

lmc_assign_keyboard('MACROS')

if(config == nil) then
  print("To assign this keyboard automatically, copy a unique portion of the string from the line labelled MACROS (such as the VID_XXXX or PID_XXXX value) and save it to "..config_file..":")
  lmc_print_devices()
end 

sendToAHK = function (key)
      print('It was assigned string:    ' .. key)
      local file = io.open("C:\\Users\\TaranVanHemert\\Documents\\keypressed.txt", "w") -- writing this string to a text file on disk is probably NOT the best method. Feel free to program something better!
      --print("we are inside the text file")
      file:write(key)
      file:flush()
      file:close()
      lmc_send_keys('{F24}')  -- using the F24 key to trigger AutoHotKey is probably NOT the best method. Feel free to program something better!
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

	[106] = "numMult",
        [107] = "numDelete",
        -- 108 is unknown...?
	[109] = "numMult",
        [110] = "numDelete",
	[111] = "numDiv",
        [144] = "numLock", --probably it is best to avoid this key. I keep numlock ON, or it has unexpected effects

        [192] = "`",  --this is the tilde key just before the number row
        [9]   = "tab",
        [20]  = "capslock",
        [18]  = "alt",


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

        [string.byte('0')] = "0",
	[string.byte('1')] = "1",
	[string.byte('2')] = "2",
	[string.byte('3')] = "3",
	[string.byte('4')] = "4",
	[string.byte('5')] = "5",
        [string.byte('6')] = "6",
        [string.byte('7')] = "7",
        [string.byte('8')] = "8",
        [string.byte('9')] = "9",

	--[255] = "printscreen" --these keys do not work
}

-- define callback for whole device
lmc_set_handler('MACROS', function(button, direction)
	if (direction == 1) then return end  -- ignore down -- I believe this also has the effect of neutralizing the modifier keys, unfortunately. Not optimal.

	if type(config[button]) == "string" then
                print(' ')
                print('Your key ID number is:   ' .. button)
		sendToAHK(config[button])
	else
                print(' ')
                print('Not yet assigned: ' .. button)
	end
end)
