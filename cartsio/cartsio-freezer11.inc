;  cartsio-freezer11.inc - definitions for Turbo Freezer 2011 CartEmu
;
;  Copyright (c) 2011 by Matthias Reichl <hias@horus.com>
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
	STX $D590
	.ENDM

	.MACRO CARTBNKI ; parameter: bank number (immediate)
	LDX #%1
	CARTBNKX
	.ENDM

	.MACRO CARTOFF	; disable cartridge
	LDX #0
	STX $D591
	.ENDM

	.MACRO CARTBASE	; set base ROM bank for cartsio
	CARTBNKI CSROMBK
	.ENDM

	.MACRO CARTBNK ; parameter: bank number (address)
	LDX %1
	CARTBNKX
	.ENDM

; convert relative linear address (lo/mid/hi) into
; absolute address (lo/hi) plus bank number

	.MACRO CONVBANK ; parameters: address
	LDA %1+1
	PHA	; save mid byte

; for 8k banks shift bits 7, 6 and 5 into bank register
	ASL %1+1
	ROL %1+2
	ASL %1+1
	ROL %1+2
	ASL %1+1
	ROL %1+2

	PLA
	AND #$1F	; mask out bits 7, 6 and 5
	ORA #$A0	; set base address $A0
	STA %1+1
	.ENDM

; bank and address of diskwriter code
CDWBANK	= 1
CDWADDR	= $A000
