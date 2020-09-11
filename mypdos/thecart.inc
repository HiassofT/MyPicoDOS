;  flash.inc - common definitions and addresses for The!Cart
;
;  Copyright (C) 2011-2013 Matthias Reichl <hias@horus.com>
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

TC_BANKLO		= $D5A0		; main bank register, 2 bytes!
TC_BANKHI		= $D5A1		; high bank register (0-63)
TC_ENABLE		= $D5A2		; cart enable(=1)/disable(=0)

TC_BANK2LO		= $D5A3		; secondary bank register for flexi mode
TC_BANK2HI		= $D5A4
TC_ENABLE2		= $D5A5		; secondary enable register for flexi mode

TC_MODE			= $D5A6		; cart mode, see below

; 8k modes ($A000-$BFFF)
TC_MODE_OFF 		= $00		; cart disabled
TC_MODE_8K  		= $01		; 8k banks at $A000
TC_MODE_ATARIMAX1	= $02		; 8k using Atarimax 1MBit compatible banking
TC_MODE_ATARIMAX8	= $03		; 8k using Atarimax 8MBit compatible banking
TC_MODE_OSS		= $04		; 16k OSS cart, M091 banking

TC_MODE_SDX64		= $08		; SDX 64k cart, $D5Ex banking
TC_MODE_DIAMOND64	= $09		; Diamond GOS 64k cart, $D5Dx banking
TC_MODE_EXPRESS64	= $0A		; Express 64k cart, $D57x banking

TC_MODE_ATRAX128	= $0C		; Atrax 128k cart
TC_MODE_WILLIAMS64	= $0D		; Williams 64k cart

; 16k modes ($8000-$BFFF)
TC_MODE_FLEXI		= $20		; flexi mode
TC_MODE_16K		= $21		; 16k banks at $8000-$BFFF
TC_MODE_MEGAMAX16	= $22		; MegaMax 16k mode (up to 2MB)
TC_MODE_BLIZZARD	= $23		; Blizzard 16k
TC_MODE_SIC		= $24		; Sic!Cart 512k

TC_MODE_MEGA_16		= $28		; switchable MegaCarts
TC_MODE_MEGA_32		= $29
TC_MODE_MEGA_64		= $2A
TC_MODE_MEGA_128	= $2B
TC_MODE_MEGA_256	= $2C
TC_MODE_MEGA_512	= $2D
TC_MODE_MEGA_1024	= $2E
TC_MODE_MEGA_2048	= $2F

TC_MODE_XEGS_32		= $30		; non-switchable XEGS carts
TC_MODE_XEGS_64		= $31
TC_MODE_XEGS_128	= $32
TC_MODE_XEGS_256	= $33
TC_MODE_XEGS_512	= $34
TC_MODE_XEGS_1024	= $35

TC_MODE_SXEGS_32	= $38		; switchable XEGS carts
TC_MODE_SXEGS_64	= $39
TC_MODE_SXEGS_128	= $3A
TC_MODE_SXEGS_256	= $3B
TC_MODE_SXEGS_512	= $3C
TC_MODE_SXEGS_1024	= $3D

TC_CFG			= $D5A7		; cart config (0-15 / bit 3-0), see below

TC_CFG_WE		= 1		; write enable (=1)/disable (=0)
TC_CFG_WE_MSK		= $FE		; corresponding bit mask
TC_CFG_SRC		= 2		; source RAM (=2) / ROM (=0)
TC_CFG_SRC_MSK		= $FD		; corresponding bit mask
TC_CFG_WE2		= 4		; write enable 8xxx for flexi mode
TC_CFG_WE2_MSK		= $FB		; corresponding bit mask
TC_CFG_SRC2		= 8		; source RAM 8xxx for flexi mode
TC_CFG_SRC2_MSK		= $F7		; corresponding bit mask

TC_SPI			= $D5A8		; SPI I/O
TC_SPI_SO		= $80		; SPI data in (read, out from eeprom)
TC_SPI_SI		= $80		; SPI data out (write, in on eeprom)
TC_SPI_CS		= 2		; SPI chip select (write)
TC_SPI_CLK		= 1		; SPI clock (write)

TC_SPI_MSK		= $7C		; mask of unused bits (must read 0)

TC_LOCKCFG		= $D5AF		; lock current configuration

; OSS banking registers
OSSBANK1		= $D500
OSSBANK2		= $D509
OSSBANK3		= $D501
OSSOFF			= $D508

SDX64_BANKCTL		= $D5E0
DIAMOND64_BANKCTL	= $D5D0
EXPRESS64_BANKCTL	= $D570
SIC_BANKCTL		= $D500

; Atarimax banking registers
AMAXBANK		= $D500
AMAX1OFF		= $D510
AMAX8OFF		= $D580

; cartmenu menu ROM bank
TC_MENU_BANK		= 0
TC_PICODOS_BANK		= 1
TC_MYDOS_BANK		= 2
TC_FLASH_BANK1		= 3
TC_FLASH_BANK2		= 4

; main signature address
TC_MAINSIG	= $BFE0

; entry vector to cartmenu
TC_ENTRYVEC	= $A000
