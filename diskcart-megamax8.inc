;  diskcart-megamax8.inc - definitions for Megamax 1024k cart in 8k mode
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

; offsets in Megamax 1024k flashcart (8k mode)

; code starts at offset 0
OFSCODH = 0
OFSCODL = 0

; drive table
OFSTABH	= 0
OFSTABL	= CARTTAB-$A000

; 16byte signature
OFSSIGH	= 0
OFSSIGL	= CARTSIG-$A000

; diskwriter code
OFSDWH  = $F
OFSDWL  = $E000

; start of disk image area
OFSIMSH	= 0
OFSIMSL	= $2000

; end of disk image area
OFSIMEH	= $F
OFSIMEL	= $E000
