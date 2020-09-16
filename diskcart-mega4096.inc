;  diskcart-mega4096.inc - definitions for 4MB mega cart
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

; offsets in 4MB Mega16 flashcart

; this cart starts with bank 254 ($3F8000)

; code starts at upper half of bank 254
OFSCODH	= $3F
OFSCODL	= $A000

; configuration page
OFSCFGH = $3F
OFSCFGL = CCONFPG

; diskwriter code
OFSDWH  = $3F
OFSDWL  = $8000

; start of disk image area
OFSIMSH	= 0
OFSIMSL	= 0

; end of disk image area
OFSIMEH	= $3F
OFSIMEL	= $8000

