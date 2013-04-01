;  cartsio-mega4096.inc - definitions for 4MB Mega cart
;
;  Copyright (c) 2013 by Matthias Reichl <hias@horus.com>
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

; common macros
	.MACRO CARTBNKX ; set bank from X register
	STX $D500
	.ENDM

	.MACRO CARTBNKI ; parameter: bank nummer (immediate)
	LDX #%1
	CARTBNKX
	.ENDM

	.MACRO CARTOFF	; disable cartridge
	CARTBNKI $FF
	.ENDM

	.MACRO CARTBASE	; set base ROM bank for cartsio
	CARTBNKI CSROMBK
	.ENDM

	.MACRO CARTBNK ; parameter: bank nummer (address)
	LDX %1
	CARTBNKX
	.ENDM

; convert relative linear address (lo/mid/hi) into
; absolute address (lo/hi) plus bank number

	.MACRO CONVBANK ; parameters: address
	LDA %1+1
	PHA	; save mid byte

; for 16 k banks shift bits 7 and 6 into bank register
	ASL %1+1
	ROL %1+2
	ASL %1+1
	ROL %1+2

	PLA
	AND #$3F	; mask out bits 7 and 6
	ORA #$80	; set base address $80
	STA %1+1
	.ENDM

; bank and address of diskwriter code
CDWBANK = $FE
CDWADDR = $8000

; ROM bank number of cartsio entry
CSROMBK = $FE

