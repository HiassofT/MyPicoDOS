;  version - MyPicoDos common version strings
;
;  Copyright (C) 2014-2017 Matthias Reichl <hias@horus.com>
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

; version string in ATASCII format
	.MACRO VERSION
	.BYTE "4.06"
;	.BYTE "4dev"
	.ENDM

; version string in screen format
	.MACRO SVERSION
	.SBYTE "4.06"
;	.SBYTE "4dev"
	.ENDM

; copyright year string
	.MACRO COPYYEAR
	.BYTE "2017"
	.ENDM

; copyright year string
	.MACRO SCOPYYEAR
	.SBYTE "2017"
	.ENDM

