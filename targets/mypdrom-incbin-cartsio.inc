.if .def FREEZER2011
OSCODP	.incbin "cartsiocode-osram-freezer2011-pal.bin"
OSCODPL	= * - OSCODP
OSCODN	.incbin "cartsiocode-osram-freezer2011-ntsc.bin"
OSCODNL	= * - OSCODN
.endif
.if .def FREEZER2005
OSCODP	.incbin "cartsiocode-osram-freezer2005-pal.bin"
OSCODPL	= * - OSCODP
OSCODN	.incbin "cartsiocode-osram-freezer2005-ntsc.bin"
OSCODNL	= * - OSCODN
.endif
.if .def ATARIMAX8
OSCODP	.incbin "cartsiocode-osram-atarimax8-pal.bin"
OSCODPL	= * - OSCODP
OSCODN	.incbin "cartsiocode-osram-atarimax8-ntsc.bin"
OSCODNL	= * - OSCODN
.endif
.if .def MEGA512
OSCODP	.incbin "cartsiocode-osram-mega512-pal.bin"
OSCODPL	= * - OSCODP
OSCODN	.incbin "cartsiocode-osram-mega512-ntsc.bin"
OSCODNL	= * - OSCODN
.endif
.if .def MEGA4096
OSCODP	.incbin "cartsiocode-osram-mega4096-pal.bin"
OSCODPL	= * - OSCODP
OSCODN	.incbin "cartsiocode-osram-mega4096-ntsc.bin"
OSCODNL	= * - OSCODN
.endif
.if .def SXEGS512
OSCODP	.incbin "cartsiocode-osram-sxegs512-pal.bin"
OSCODPL	= * - OSCODP
OSCODN	.incbin "cartsiocode-osram-sxegs512-ntsc.bin"
OSCODNL	= * - OSCODN
.endif
