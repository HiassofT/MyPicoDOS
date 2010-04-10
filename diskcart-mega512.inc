;  diskcart-mega512.inc - definitions for Mega512 cart
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

; offsets in 512k Mega16 flashcart

; code starts at offset $2000
OFSCODH	= 0
OFSCODL	= $2000

; drive table
OFSTABH	= 0
OFSTABL	= CARTTAB-$8000

; 16byte signature
OFSSIGH	= 0
OFSSIGL	= CARTSIG-$8000

; start of disk image area
OFSIMSL	= $4000
OFSIMSH	= 0

; end of disk image area
OFSIMEL	= 0
OFSIMEH	= 8

