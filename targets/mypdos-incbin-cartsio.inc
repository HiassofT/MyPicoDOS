.if .def FREEZER2011
CSIOP	.incbin "cartsio-freezer2011-pal.bin"
CSIOPL	= * - CSIOP
CSION	.incbin "cartsio-freezer2011-ntsc.bin"
CSIONL	= * - CSION
.endif
.if .def FREEZER2005
CSIOP	.incbin "cartsio-freezer2005-pal.bin"
CSIOPL	= * - CSIOP
CSION	.incbin "cartsio-freezer2005-ntsc.bin"
CSIONL	= * - CSION
.endif
.if .def MEGAMAX8
CSIOP	.incbin "cartsio-megamax8-pal.bin"
CSIOPL	= * - CSIOP
CSION	.incbin "cartsio-megamax8-ntsc.bin"
CSIONL	= * - CSION
.endif
.if .def MEGA512
CSIOP	.incbin "cartsio-mega512-pal.bin"
CSIOPL	= * - CSIOP
CSION	.incbin "cartsio-mega512-ntsc.bin"
CSIONL	= * - CSION
.endif
.if .def MEGA4096
CSIOP	.incbin "cartsio-mega4096-pal.bin"
CSIOPL	= * - CSIOP
CSION	.incbin "cartsio-mega4096-ntsc.bin"
CSIONL	= * - CSION
.endif
