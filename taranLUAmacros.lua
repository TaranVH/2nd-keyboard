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

-- define callback for whole device
lmc_set_handler('MACROS',function(button, direction)
  if (direction == 1) then return end  -- ignore down
  --if     (button == string.byte('C')) then lmc_spawn("calc")
  --elseif (button == string.byte('9')) then lmc_spawn("notepad", "C:\\test.txt")
  -- elseif (button == 9) then lmc_spawn("calc") --tab
  -- elseif (button == string.byte('0')) then lmc_spawn("notepad", "C:\\Users\\TaranVanHemert\\Documents\\testy.txt")
  -- elseif (button == string.byte('H')) then lmc_send_keys('Hello world')
  if (button == 45) then taran('insert')
  elseif (button == 36) then taran('home')
  elseif (button == 33) then taran('pageup')
  elseif (button == 46) then taran('delete')
  elseif (button == 35) then taran('end')
  elseif (button == 34) then taran('pagedown')

  elseif (button == 27) then taran('escape')

  elseif (button == 112) then taran('F1')
  elseif (button == 113) then taran('F2')
  elseif (button == 114) then taran('F3')
  elseif (button == 115) then taran('F4')
  elseif (button == 116) then taran('F5')
  elseif (button == 117) then taran('F6')
  elseif (button == 118) then taran('F7')
  elseif (button == 119) then taran('F8')
  elseif (button == 120) then taran('F9')
  elseif (button == 121) then taran('F10')
  elseif (button == 122) then taran('F11')
  elseif (button == 123) then taran('F12')

  elseif (button == 8) then taran('backspace')
  elseif (button == 220) then taran('backslash')
  elseif (button == 13) then taran('enter')
  elseif (button == 16) then taran('rShift')
  elseif (button == 17) then taran('rCtrl')

  elseif (button == 38) then taran('up')
  elseif (button == 37) then taran('left')
  elseif (button == 40) then taran('down')
  elseif (button == 39) then taran('right')

  elseif (button == 32) then taran('space')

  elseif (button == 186) then taran('semicolon')
  elseif (button == 222) then taran('singlequote')
  elseif (button == 190) then taran('period')
  elseif (button == 191) then taran('slash')
  elseif (button == 188) then taran('comma')

  elseif (button == 219) then taran('leftbracket')
  elseif (button == 221) then taran('rightbracket')

  elseif (button == 189) then taran('minus')
  elseif (button == 187) then taran('equals')

  elseif (button == 96) then taran('num0')
  elseif (button == 97) then taran('num1')
  elseif (button == 98) then taran('num2')
  elseif (button == 99) then taran('num3')
  elseif (button == 100) then taran('num4')
  elseif (button == 101) then taran('num5')
  elseif (button == 102) then taran('num6')
  elseif (button == 103) then taran('num7')
  elseif (button == 104) then taran('num8')
  elseif (button == 105) then taran('num9')
  elseif (button == 111) then taran('numDiv')
  elseif (button == 106) then taran('numMult')



  elseif (button == string.byte('Q')) then taran('q')
  elseif (button == string.byte('W')) then taran('w')
  elseif (button == string.byte('E')) then taran('e')
  elseif (button == string.byte('R')) then taran('r')
  elseif (button == string.byte('T')) then taran('t')
  elseif (button == string.byte('Y')) then taran('y')
  elseif (button == string.byte('U')) then taran('u')
  elseif (button == string.byte('I')) then taran('i')
  elseif (button == string.byte('O')) then taran('o')
  elseif (button == string.byte('P')) then taran('p')
  elseif (button == string.byte('A')) then taran('a')
  elseif (button == string.byte('S')) then taran('s')
  elseif (button == string.byte('D')) then taran('d')
  elseif (button == string.byte('F')) then taran('f')
  elseif (button == string.byte('G')) then taran('g')
  elseif (button == string.byte('H')) then taran('h')
  elseif (button == string.byte('J')) then taran('j')
  elseif (button == string.byte('K')) then taran('k')
  elseif (button == string.byte('L')) then taran('l')
  elseif (button == string.byte('Z')) then taran('z')
  elseif (button == string.byte('X')) then taran('x')
  elseif (button == string.byte('C')) then taran('c')
  elseif (button == string.byte('V')) then taran('v')
  elseif (button == string.byte('B')) then taran('b')
  elseif (button == string.byte('N')) then taran('n')
  elseif (button == string.byte('M')) then taran('m')

  elseif (button == string.byte('1')) then taran('1') --haven't programmed these ones in AHK yet...
  elseif (button == string.byte('2')) then taran('2')
  elseif (button == string.byte('3')) then taran('3')
  elseif (button == string.byte('4')) then taran('4')
  elseif (button == string.byte('5')) then taran('5')



  elseif (button == 255) then taran('printscreen')-- doesn't work. can't block these keys.



  else print('Not yet assigned: ' .. button)
  end
end)
