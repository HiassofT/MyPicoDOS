@ECHO OFF
ECHO
ECHO           MyPicoDos 4.04
ECHO      (c) 1992-2007 by HiassofT
ECHO
ECHO  1  Initializer (no remote console)
ECHO  2  Initializer (remote console)
ECHO  3  Initializer (barebone)
ECHO  4  COM version (highspeed auto)
ECHO  5  COM version (highspeed off)
ECHO
ECHO  0  exit to basic/DOS
ECHO
ASK FOR 01234
IF ANSWER = 1
  LOAD D1:MYINIT.COM QUIT
ENDIF
IF ANSWER = 2
  LOAD D1:MYINITR.COM QUIT
ENDIF
IF ANSWER = 3
  LOAD D1:MYINITB.COM QUIT
ENDIF
IF ANSWER = 4
  LOAD D1:MYPDOSR.COM QUIT
ENDIF
IF ANSWER = 5
  LOAD D1:MYPDOSRN.COM QUIT
ENDIF
EXIT
