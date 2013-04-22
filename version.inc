;  version.inc - macros for version numbers
;
;  Copyright (C) 2013 Matthias Reichl <hias@horus.com>
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

	.macro BVERSION
	.byte "1.21"
	.endm

	.macro SVERSION
	.sbyte "1.21"
	.endm

	.macro BYEAR
	.byte "2013"
	.endm

	.macro SYEAR
	.sbyte "2013"
	.endm

	.macro TIMESTAMP
	BYEAR
	.byte "0422"
	.endm