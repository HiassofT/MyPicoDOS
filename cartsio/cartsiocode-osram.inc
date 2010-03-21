;  cartsiocode-osram.inc - SIO replacement code for RAM OS
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

; offsets:
OSLOTNO	= 1	; slot number
OSTDSIO	= 5	; address of original SIO code

; address of reset-handler (to enable OS RAM)
RESADR  = $0120

