;  diskcart-sxegs512.inc - definitions for SXEGS 512k cart
;
;  Copyright (C) 2021 Matthias Reichl <hias@horus.com>
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

; offsets in SXEGS 512k cart

; last bank (63) is always mapped to $A000
OFSCODH	= 7
OFSCODL	= $E000

; configuration page
OFSCFGH = 7
OFSCFGL = CCONFPG+$4000

; diskwriter code
OFSDWH  = 7
OFSDWL  = $C000

; start of disk image area
OFSIMSH	= 0
OFSIMSL	= 0

; end of disk image area
OFSIMEH	= 7
OFSIMEL	= $C000

