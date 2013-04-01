;  libflash.inc - common flash definitions
;
;  Copyright (C) 2004-2010 Matthias Reichl <hias@horus.com>
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

; public functions:
; FINIT		
;   Init libflash - call at the very beginning of your code
; FENABLE
;   enable access to flash - call before detecting/reading/writing...
;   to the flash chip. Usually maps the flash chip to Atari memory
; FDISABLE
;   disable access to flash - call after reading/writing/...
;   to the flash chip. Usually un-maps the flash chip from Atari memory
; FADRZERO
;   sets flash address FLASHADR to 0
;
; FPRESENT
;   check for presence of flash(cart) returns Z=1 if present
;   note: flash must be in state "DISABLED", RAM in Atari must be present
; FDETECT
;   try to detect flash chip at FLASHADR. Sets FTYPE to detected flash chip type
; FSETCHP
;   Force flash chip to value in A. Use this instead of FDETECT to
;   configure RAM mode (TRAMxxx)
;
; FWBYTE
;  write X bytes from DATAADR,Y to FLASHADR,Y
; FWPAGE
;  write X pages from DATAADR to FLASHADR
; FRBYTE
;  copy X bytes from FLASHADR,Y to DATAADR,Y
; FRPAGE
;  copy X pages from FLASHADR to DATAADR
; FCBYTE
;  compare X bytes from FLASHADR,Y to DATAADR,Y
; FCPAGE
;  compare X pages from FLASHADR to DATAADR
;
; FCERAS
;   completely erase flash chip
; FPERASE
;   erase block of flash chip
; 
; public addresses/vectors
; FLASHADR
;   4-byte linear address to use for accessing the flash chip
; DATAADR
;   2-byte linear address pointing to data to transfer from/to flash
; FTYPE
;   current (detected) flash type. See below for values
; FSIZE
;   4-byte total size of flash chip (in bytes)
; FNUMBLK
;   1-byte number of flash blocks (0 = no blocks)
; FBLKSIZ
;   4-byte size of a flash block
; FBLKMSK
;   4-byte mask to calculate block starting address
; FERROR
;   error status of flash access routines.
;   0 = OK
;   1 = flash error (timeout)
;   2 = data error (verify failed)
;   $80 = address error, eg FWPAGE called on non page boundary
;
; FERRFD, FERRUD
;   flash (FERRFD) and user data (FERRUD) in case of a verify error


; zero-page vectors (only used internally)
FLASHVEC	= $E0 ; ,$E1: absolute flash address
DATAVEC		= $E2 ; ,$E3: data buffer vector
FLASHTMP	= $E4 ; ,$E5: temporary vector

; flash types
TAMD10	= 0	; AMD 29F010
TAMD10B	= 1	; AMD 29F010B
TAMD40B	= 2	; AMD 29F040B
TST10B	= 3	; ST 29F010B
TST40B	= 4	; ST 29F040B
TBM40	= 5	; BM 29F040
TAMD32B	= 6	; AMD 29F032B
TRAM128	= $30	; 128k RAM
TRAM512	= $31	; 512k RAM
TRAM1024= $32	; 1024k RAM
TNOFLSH	= $FF	; no flash

; error codes (in FERROR)
; no error - call to libflash is OK
EFLOK	= 0
; page address error - called FxPAGE on non-page boundary
EFLPAE	= $80
; flash timeout (error programming flash cell)
EFLFTO	= $81
; data verify error after programming flash cell or when
; using FCBYTE/FCPAGE
EFLDVE	= $82
; unsupported operation (i.e. erasing a RAM chip)
EFLUNS	= $83
