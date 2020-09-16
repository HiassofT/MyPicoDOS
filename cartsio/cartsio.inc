;  cartsio.inc - definitions for cartsio code
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

; start address of ROM code
	CARTSTRT=$A000

; address/bank of CARTSIO code
	CSIOROM = CARTSTRT	; cartsio entry address

; alternate cartsio entry, set A to slot number
	CSIOROMA= $A003

; alternate cartsio entry, set Y to slot number
	CSIOROMY= $A006

; base page with configuration data (stored in same bank as cartsio code)
	CCONFPG = $BF00

; offset to drive table in ROM
; the drive table has 8 entries (D1:..D8:) with 8 bytes each
	CARTTABO = 0

	CARTTAB = CCONFPG + CARTTABO

; offset to autostart flag:
; if != 0 start MyPicoDos automatically if images
; are available (disable this feature with "select")
	CAUTOFO	= $DF

	CAUTOF = CCONFPG + CAUTOFO

; offset to 16byte signature in ROM (contains "HiassofT" plus 8-byte serial number)
	CARTSIGO = $E0

	CARTSIG = CCONFPG + CARTSIGO


; size and number of entries in drive table
	CTENUM	= 8	; number of entries in drive table
	CTESIZE	= 8	; size of each entry (8 bytes)
	CTTSIZE	= [CTENUM*CTESIZE]	; total size of drive table

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

; address of highspeed SIO code in ROM
	CHISIO	= $BB00

.include "cartsio-inc-target.inc"

