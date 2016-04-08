;  flash11.inc - common definitions and addresses for Freezer 2011 flash
;
;  Copyright (C) 2011 Matthias Reichl <hias@horus.com>
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

CE_BANK		= $D590		; main bank register (0-127), 8k granularity
CE_ENABLE	= $D591		; cartemu enable(=1)/disable(=0)

CE_RBANK	= $D592		; separate 8k RAM bank register (0-47)
CE_RENABLE	= $D593		; separate 8k RAM enable(=1)/disable(=0)

CE_MODE		= $D594		; cartemu mode (0-7), see below
CE_MODE_OFF 	= 0		; no cartemu at all
CE_MODE_8K  	= 1		; 8k banks at $A000
CE_MODE_8K_RAM	= 2		; 8k banks with optional 8k RAM at $8000
CE_MODE_8K_OLD	= 3		; 8k with Turbo Freezer 2005 bank select (D540-7F,80/81/84/85)
CE_MODE_16K	= 4		; 16k banks at $8000-$BFFF
CE_MODE_OSS	= 5		; 16k OSS cart at $A000-$BFFF
CE_MODE_AMAX	= 6		; 8k using Atarimax 8MBit compatible banking
;CE_MODE_RESVD	= 7		; reserved

CE_CFG		= $D595		; cartemu config (0-7 / bit 2-0), see below
CE_CFG_WE	= 1		; write enable (=1)/disable (=0)
CE_CFG_WE_MSK	= $FE		; corresponding bit mask
CE_CFG_SRC	= 2		; source RAM (=2) / ROM (=0)
CE_CFG_SRC_MSK	= $FD		; corresponding bit mask
CE_CFG_MENU	= 4		; enable cartemu menu (=4) / normal operation (=0)
CE_CFG_MENU_MSK	= $FB		; corresponding bit mask

CE_SDX		= $D596		; SDX emulation (Ultimate 1MB banking, 0-3), see below
CE_SDX_OFF	= 0		; SDX emulation off
CE_SDX_RAM	= 1		; SDX emulation from RAM (starting bank 0)
CE_SDX_ROM1	= 2		; SDX emulation from ROM (starting bank 0)
CE_SDX_ROM2	= 3		; SDX emulation from ROM (starting bank 64)

; OSS banking registers
OSSBANK1	= $D500
OSSBANK2	= $D509
OSSBANK3	= $D501
OSSOFF		= $D508

; SDX banking registers (bit 7,6=ctl, 5-0=bank)
SDXBANKCTL	= $D5E0

; Atarimax banking registers
AMAXBANK	= $D500
AMAXOFF		= $D580

; offset to freezer version (located in bank no. 125)
VEROFSH		= $0F
VEROFSL		= $BEE0

; cartemu menu ROM bank
CE_MENU_BANK	= $7E
; bank holding MyPicoDos
CE_MYPDOS_BANK	= $7A

; RAM bank for cartemu menu configuration
CE_MENU_RAM_BANK= $3D

; 2 8k temp ram banks for MyPicoDos CAR loading
CE_TEMP_RAM_BANK= $38

; non-volatile config offsets withing cartemu menu configuration bank
; 8-byte signature
CE_MENU_NVSIG_OFS	= 0
CE_MENU_NVSIG_LEN	= 8

; nvram entry
CE_MENU_NVRAM_OFS	= 8

; offsets within NVRAM
CE_MENU_NV_MODE_OFS	= 0
CE_MENU_NV_BANK_OFS	= 1
CE_MENU_NV_SRC_OFS	= 2
CE_MENU_NV_SDX_OFS	= 3
CE_MENU_NV_BOOT_OFS	= 4
CE_MENU_NV_ARUN_OFS	= 5

; user presets

; 8-byte signature that user presets are present
CE_MENU_UPSIG_OFS	= $20
CE_MENU_UPSIG_LEN	= 8
; non-volatile global preset config
; currently selected page
CE_MENU_UP_PAGE_OFS	= $28
; temp storage for displaying entry on main menu
CE_MENU_UP_TMP1_OFS	= $2E
CE_MENU_UP_TMP2_OFS	= $2F


; number & size of user preset page titles/entries
CE_MENU_UP_NUM_ENTRIES	= $80
CE_MENU_UP_NUM_PAGES	= 8

CE_MENU_UP_ENTRY_LEN	= $20
CE_MENU_UP_TITLE_LEN	= $20

; buffers for saving title/entry input
CE_MENU_SAVE_ENTRY_BUF	= $40
CE_MENU_SAVE_TITLE_BUF	= $60

; max 128 presets
CE_MENU_UP_MODE_OFS	= $300
CE_MENU_UP_BANK_OFS	= $380
CE_MENU_UP_SRC_OFS	= $400
CE_MENU_UP_SDX_OFS	= $480
CE_MENU_UP_BOOT_OFS	= $500

; 8 page titles of 32 bytes each = 512 bytes
CE_MENU_UP_TITLE_OFS	= $600

; user presets
; 128 entries of 32 bytes each = 4k
CE_MENU_UP_ENTRY_OFS	= $800

; 1k of temp screen memory
CE_MENU_SCREEN_OFS	= $1C00

