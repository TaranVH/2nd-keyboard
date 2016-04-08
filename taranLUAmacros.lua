function file_exist(name)
   local file=io.open(name,"r");
   if (file ~= nil) then
      io.close(file);
      return true;
   else
       return false;
   end;
end;

function sendToAHK(key)
      print('It was assigned string: ' .. key);
      local file = io.open(file_path, "w");
      file:write (key);
      file:flush ();
      file:close ();
      lmc_send_keys('{F24}');
end;

function get_script_path()
         local path = lmc_get_window_title():gsub("LuaMacros ", ""):gsub("- ", "");
         path = string.match(path, "(.-)([^\\/]-%.?([^%.\\/]*))$");
         return (path);
end;

modifiers = {
        [16]  = "16",
	[17]  = "17",
        [18]  = "18"
};
difference = {
	[19]  = "19",
	[44]  = "44"
};

local path = get_script_path();
if (not file_exist(path .. "options.opt")) then
    local file = io.open(path .. "options.opt", "a");
    file:write ("file_path = \"" .. path:gsub("\\", "\\\\") .. "keypressed.txt\";\n");
    file:write ("layout_file = \"TARAN.lyt\";\n");
    file:write ("toggle_modifiers = false;\n");
    file:write ("differ_pause_prtscr = false;\n");
    file:write ("toggle_specials_keys_repeat = false;\n");
    file:write ("special = {\n    [20]  = function () lmc_send_keys(\"{CAPSLOCK}\") end,\n    [144] = function () lmc_send_keys(\"{NUMLOCK}\") end,\n    [145] = function () lmc_send_keys(\"{SCROLLLOCK}\") end\n};\n")
    file:write ("nb_macros_kb = 1;\n");
    file:flush ();
    file:close ();
end;
dofile (path .. "options.opt");
if (layout_file and file_exist(path .. "layouts\\" .. layout_file)) then
   dofile (path .. "layouts\\" .. layout_file);
else
   layout_file = false;
end;
lmc_assign_keyboard("MACROS");
mod_key = "";
diff_key = "";
lmc_set_handler("MACROS", function(button, direction)
        print(button .. ' + '..  direction);
        if (direction == 1 and toggle_modifiers and modifiers[button]) then
            mod_key = modifiers[button];
        elseif (direction == 0 and toggle_modifiers and modifiers[button]) then
             mod_key = "";
        elseif (direction == 0 and differ_pause_prtscr and difference[button]) then
             button = difference[button];
             if (mod_key ~= "") then
                sendToAHK(mod_key .. "+" .. button);
             else
                 sendToAHK(button);
             end;
        elseif (direction == 0 and ((not layout_file) or layout[button]) and ((not toggle_modifiers) or (not modifiers[button])) and ((not differ_pause_prtscr) or button ~= 255)) then
             local key = button;
             if (layout_file) then
                key = layout[button];
             end;
             if (mod_key ~= "") then
                sendToAHK(mod_key .. "+" .. key);
             else
                 sendToAHK(key);
             end;
             if (toggle_specials_keys_repeat and special[button]) then
                 special[button]();
             end;
        end;
end);
