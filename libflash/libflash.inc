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

