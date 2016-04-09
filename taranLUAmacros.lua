function file_exist(name) -- a simple fonction to test if a file exist
	local file=io.open(name,"r");
	if (file ~= nil) then
		io.close(file);
		return true;
	else
		return false;
	end;
end;

function sendToAHK(key, button)
	print("you pressed the key ID: " .. button)
	print("It was assigned string: " .. key);
	if (use_command) then --if you prefer to passes the keypress though command line arguments the send_keypress in the options file should be the command you want to execute
		os.execute(send_keypress .. key);
	else -- else send_keypress should be an ABSOLUTE path to the file containing the keypress
		local file = io.open(send_keypress, "w");
		file:write(key);
		file:flush();
		file:close();
		lmc_send_keys('{F24}');
	end;
end;

function get_script_path() --this is bad ... really BAD ... but i can't find another way to get the path of the current script :(
	local path = lmc_get_window_title():gsub("LuaMacros ", ""):gsub("- ", "");
	path = string.match(path, "(.-)([^\\/]-%.?([^%.\\/]*))$");
	return (path);
end;

function assign_keyboard(n)
	if (nb_macros_kb == 1) then
		str = "MACROS";
	else
		str = "MACROS" .. n;
	end;
	if (keyboards[n]) then
		lmc_device_set_name(str, keyboards[n]);
	else
		lmc_assign_keyboard(str);
	end;
	local mod_key = "";
	lmc_set_handler(str, function(button, direction)
		print(button .. ' + '..  direction);
		if (direction == 1 and toggle_modifiers and modifiers[button]) then
			mod_key = modifiers[button];
		elseif (direction == 0 and toggle_modifiers and modifiers[button]) then
			mod_key = "";
		elseif (direction == 0 and differ_pause_prtscr and difference[button]) then
			local key = difference[button];
			if (mod_key ~= "") then
				sendToAHK(mod_key .. "+" .. key, button);
			else
				sendToAHK(key, button);
			end;
		elseif (direction == 0 and ((not layout_file) or layout[button]) and ((not toggle_modifiers) or (not modifiers[button])) and ((not differ_pause_prtscr) or button ~= 255)) then
			local key = button;
			if (layout_file) then
				key = layout[button];
			end;
			if (mod_key ~= "") then
				sendToAHK(mod_key .. "+" .. key, button);
			else
				sendToAHK(key, button);
			end;
			if (toggle_specials_keys_repeat and special[button]) then
				special[button]();
			end;
		end;
	end);
end;

modifiers = {
	[16]	= "16",
	[17]	= "17",
	[18]	= "18"
};
difference = {
	[19]	= "19",
	[44]	= "44"
};
special = {
	[20]	= function() lmc_send_keys("{CAPSLOCK}") end,
	[144]	= function() lmc_send_keys("{NUMLOCK}") end, -- this does not work i don't know why :'(
	[145]	= function() lmc_send_keys("{SCROLLLOCK}") end
};

local path = get_script_path();
if (not file_exist(path .. "options.opt")) then
	local file = io.open(path .. "options.opt", "a");
	file:write("send_keypress = \"" .. path:gsub("\\", "\\\\") .. "keypressed.txt\";\n");
	file:write("use_command = false;\n");
	file:write("layout_file = \"QWERTY_US.lyt\";\n");
	file:write("toggle_modifiers = false;\n");
	file:write("differ_pause_prtscr = false;\n");
	file:write("toggle_specials_keys_repeat = false;\n");
	file:write("nb_macros_kb = 1;\n");
	file:write("minimize = false;\n")
	file:write("keyboards = {\n};")
	file:flush();
	file:close();
end;
dofile (path .. "options.opt");
if (layout_file and file_exist(path .. "layouts\\" .. layout_file)) then
	dofile(path .. "layouts\\" .. layout_file);
else
	layout_file = false;
end;
if (minimize) then
	lmc.minimizeToTray = true;
	lmc_minimize();
end;
local i = 0;
while (i < nb_macros_kb) do
	i = i + 1;
	assign_keyboard(i);
end;
lmc_print_devices();
