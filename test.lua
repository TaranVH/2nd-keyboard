lmc_assign_keyboard("lol");
lmc_set_handler("lol", function(button, direction)
	print (button .. " + " .. direction);
end);
