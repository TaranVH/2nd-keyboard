
#NoEnv
SendMode Input


#IfWinActive ahk_exe winword.exe

;alt i m -- new comment
;alt r d d -- delete comment

;;PREVIOUS COMMENT
F1::
send {RAlt down}
sleep 1
send {RAlt up}
sleep 1
send r
sleep 1
send v
sleep 1
return

;;NEXT COMMENT
F2::
send {RAlt down}
sleep 1
send {RAlt up}
sleep 1
send r
sleep 1
send n
sleep 1
return


;;DELETE COMMENT
F3::
send {RAlt down}
sleep 1
send {RAlt up}
sleep 1
send r
sleep 1
send d
sleep 1
send d
sleep 1
return

;;NEW COMMENT
F4::
send {RAlt down}
sleep 1
send {RAlt up}
sleep 1
send i
sleep 1
send m
sleep 1
return
