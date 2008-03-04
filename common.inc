;  common - MyPicDos common includes
;
;  Copyright (C) 1992-2004 Matthias Reichl <hias@horus.com>
;
;  This program is free software; you can redistribute it and/or modify
;  it under the terms of the GNU General Public License as published by
;  the Free Software Foundation; either version 2 of the License, or
;  (at your option) any later version.
;
;  This program is distributed in the hope that it will be useful,
;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;  GNU General Public License for more details.
;
;  You should have received a copy of the GNU General Public License
;  along with this program; if not, write to the Free Software
;  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

DBUF	= $0304
DBYT	= $0308
DSEC	= $030A

SOUNDR	= $41

; address of .bin file loader

LDBINAD	= $80
LDBINLO	= $0700

; memory layout of MyPicoDos:
; $0400 - $047F : clear memory
; $0700 - $07FF : sector buffer
; $0800 - $xxxx : common routine GETBYTE
; $xxxx - $yyyy : COM or BAS loader routine
; $yyyy - $zzzz : (optional) high speed SIO code

CLRMEM	= $0400
BUF	= $0700
RREADST	= $0800

; some common macros

	.MACRO STW ; ADR,WERT
	.IF %0 <> 2
	.ERROR "STW: need two parameters"
	.ELSE
	LDA #<(%2)
	STA %1
	LDA #>(%2)
	STA %1+1
	.ENDIF
	.ENDM

;	copy a maximum of 768 bytes
	.MACRO COP768 ; DEST, SRC, LEN
	.IF %0 <> 3
	.ERROR "COP768: need three parameters"
	.ELSE
	.IF (%3) <= 256
	LDY #0
	LDX #<(%3)
CLP1	LDA %2,Y
	STA %1,Y
	INY
	DEX
	BNE CLP1
	.ELSE ; LEN > 256
	LDY #0
CLP2	LDA %2,Y
	STA %1,Y
	.IF (%3) > 512
	LDA %2+$100,Y
	STA %1+$100,Y
	.ENDIF
	INY
	BNE CLP2

	LDX #<(%3)
	.IF (%3) > 512
CLP3	LDA %2+$200,Y
	STA %1+$200,Y
	.ELSE
	LDA %2+$100,Y
	STA %1+$100,Y
	.ENDIF
	INY
	DEX
	BNE CLP3
	.ENDIF
	.ENDIF
	.ENDM

; memory locations used by GETBYT / RREAD

BYTES	= $43 ;      number of bytes in the current sector
ADR	= $44 ; ,45  current loading address
BLEN	= $46 ; ,47  length of com-block
