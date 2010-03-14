;  arith - 32bit arithmetics macros
;
;  Copyright (C) 2010 Matthias Reichl <hias@horus.com>
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

; add 2 32bit values dest = arg1 + arg2
	.MACRO MADD32 ; dest, src1, src2
	.IF %0 <> 3
	.ERROR "MADD32 needs 3 parameters"
	.ELSE
	CLC
	LDA %2
	ADC %3
	STA %1
	LDA %2+1
	ADC %3+1
	STA %1+1
	LDA %2+2
	ADC %3+2
	STA %1+2
	LDA %2+3
	ADC %3+3
	STA %1+3
	.ENDIF
	.ENDM

; subtract 2 32bit values dest = src1 - src2
	.MACRO MSUB32 ; dest, arg1, arg2
	.IF %0 <> 3
	.ERROR "MSUB32 needs 3 parameters"
	.ELSE
	SEC
	LDA %2
	SBC %3
	STA %1
	LDA %2+1
	SBC %3+1
	STA %1+1
	LDA %2+2
	SBC %3+2
	STA %1+2
	LDA %2+3
	SBC %3+3
	STA %1+3
	.ENDIF
	.ENDM

; compare 32bit value arg1 with arg2
	.MACRO MCMP32 ; arg1, arg2
	.IF %0 <> 2
	.ERROR "MCMP32 needs 2 parameters"
	.ELSE
	LDA %1+3
	CMP %2+3
	BCC MEND
	BNE MEND

	LDA %1+2
	CMP %2+2
	BCC MEND
	BNE MEND

	LDA %1+1
	CMP %2+1
	BCC MEND
	BNE MEND

	LDA %1
	CMP %2
MEND
	.ENDIF
	.ENDM
