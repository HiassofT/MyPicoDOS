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

; offset in drive table
	TABOFS = $30

; density flag for disk image: 0 = SD 1 = DD
	DENSFLG = $31

; temporary buffer vector
	ZBUFR = $32 ; + $33

; buffer length
	BUFLEN = $34 ; + $35


; $36/$37 are kept free to avoid troubles with TurboDOS

; SIO ZP locations $38 - $3C are used for temporary storage

; for get status :
	ZPTMP  = $38

; for read sector:
	CADR	= $38	; ,$39 address lo/hi
	CADRB	= $3A	; address hi2 / bank number

; density flag for current sector
	DENSFL2	= $3B


; flag if GETBYTE should return after receiving a single byte
; 0 means no (we are in read loop), $80 means yes
	GETFLG = $3C

;       CRETRY = $29C
;       DRETRY = $2BD
;       STACKP = $318

	CRITIC = $42


; address of drive table in cartridge
; format of table:
; 8 bytes per entry
;
; byte 0: 0=sd, 1=dd, $FF=no drive
; byte 1: starting offset (in pages) lo
; byte 2: starting offset (in pages) hi
; byte 3: number of sectors (lo)
; byte 4: number of sectors (hi)

	CARTTAB	= $BF00

	CARTBDR = CARTTAB
	CARTBOL = CARTTAB+1
	CARTBOH = CARTTAB+2
	CARTBSL = CARTTAB+3
	CARTBSH = CARTTAB+4

; cartridge bank number where CARTAB is stored
	TABBANK = 0

