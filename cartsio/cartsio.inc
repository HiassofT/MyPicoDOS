;  cartsiocode.inc - definitions for highspeed SIO code
;
;  Copyright (c) 2010 by Matthias Reichl <hias@horus.com>
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

	DDEVIC  = $0300
	DUNIT   = $0301
	DCOMND  = $0302
	DSTATS  = $0303
	CRITIC	= $42


; zero-page addresses:
	DENSFLG = $30	; density flag for disk image: 0 = SD 1 = DD
	DENSFL2	= $31	; density flag for current sector

	CSDST = $32	; ,$33: destination buffer vector
	BUFLEN = $34	; ,$35: buffer length

	CSSRC	= $38	; ,$39 source address lo/hi
	CSSRCB	= $3A	; source address hi2 / bank number


; address/bank of CARTSIO code
	CSIOROM = $A000	; cartsio entry address
	CSROMBK = 0	; ROM bank number of cartsio entry

; alternate cartsio entry, set A to slot number
	CSIOROMA= $A003

; alternate cartsio entry, set Y to slot number
	CSIOROMY= $A006

; drive table in ROM (stored in same bank as cartsio code)
; the drive table has 8 entries (D1:..D8:) with 16 bytes each
	CARTTAB	= $BF00	; drive table base address

; offsets in drive table
	CTOACTI	= 0	; slot active: 0=yes, $ff=no
	CTODENS	= 1	; density: 0=sd, 1=dd
	CTOSPL	= 2	; starting offset (in pages) lo
	CTOSPH	= 3	; starting offset (in pages) hi
	CTOSECL	= 4	; number of sectors (lo)
	CTOSECH	= 5	; number of sectors (hi)
	; bytes 6 and 7 are unused

; "sector 0" of each image contains internal data:
	COFSTAT	= 0		; 4 bytes "GetStatus" data
	COFPERC	= 4		; 12 bytes "Percom block"
	COFNAME	= 16		; 32 bytes image name (terminated with EOL)
	CLNNAME	= 32		; length of name (32)

; 16byte signature in ROM (contains "HiassofT" plus 8-byte serial number)
	CARTSIG	= $BFE0	; drive table base address

; common macros
	.MACRO CARTBNKX ; set bank from X register
	STX $D500
	.ENDM

	.MACRO CARTBNKI ; parameter: bank nummer (immediate)
	LDX #%1
	CARTBNKX
	.ENDM

	.MACRO CARTOFF	; disable cartridge
	LDX #$FF
	CARTBNKX
	.ENDM

	.MACRO CARTBASE	; set base ROM bank for cartsio
	LDX #CSROMBK
	CARTBNKX
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

; for 16 k banks shift bits 7 and 6 into address register
	ASL %1+1
	ROL %1+2
	ASL %1+1
	ROL %1+2

	PLA
	AND #$3F	; mask out bits 7 and 6
	ORA #$80	; set base address $80
	STA %1+1
	.ENDM



