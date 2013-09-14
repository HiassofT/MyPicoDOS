#!/bin/sh

# generate target specific includes and makefile targets

TARGETS="freezer2011 freezer2005 megamax8 mega512 mega4096"

# run function with lowercase and uppercase parameters
doall() {
	for t in $TARGETS ; do
		UPPER=`echo $t | tr /a-z/ /A-Z/`
		$1 $t $UPPER
	done
}

# atr2cart.cpp

atr2cart_inc_target() {
cat << EOF
#include "../mypdos-$1.c"
#include "../diskwriter-$1.c"
EOF
}

doall atr2cart_inc_target > targets/atr2cart-inc-target.c

# cartsio.inc

cartsio_inc_target() {
cat << EOF
.if .def $2
	.include "cartsio-$1.inc"
.endif
EOF
}

doall cartsio_inc_target > targets/cartsio-inc-target.inc

# diskcart.src

diskcart_inc_target() {
cat << EOF
.if .def $2
	.include "diskcart-$1.inc"
.endif
EOF
}

doall diskcart_inc_target > targets/diskcart-inc-target.inc

diskcart_incbin_mypdos() {
cat << EOF
.if .def $2
	.incbin "mypdos-$1.rom"
.endif
EOF
}

doall diskcart_incbin_mypdos > targets/diskcart-incbin-mypdos.inc

# libflash.src
libflash_inc_target() {
cat << EOF
.if .def $2
	.include "libflash-$1.src"
.endif
EOF
}

doall libflash_inc_target > targets/libflash-inc-target.inc

# mypdos.src

mypdos_incbin() {
cat << EOF
.if .def $2
CSIOP	.incbin "cartsio-$1-pal.bin"
CSIOPL	= * - CSIOP
CSION	.incbin "cartsio-$1-ntsc.bin"
CSIONL	= * - CSION
.endif
EOF
}

doall mypdos_incbin > targets/mypdos-incbin-cartsio.inc

# mypdrom.src

mypdrom_incbin_mypdos() {
cat << EOF
.if .def $2
	.incbin "mypdos-code-$1.bin"
.endif
EOF
}

doall mypdrom_incbin_mypdos > targets/mypdrom-incbin-mypdos.inc

mypdrom_incbin_cartsio() {
cat << EOF
.if .def $2
OSCODP	.incbin "cartsiocode-osram-$1-pal.bin"
OSCODPL	= * - OSCODP
OSCODN	.incbin "cartsiocode-osram-$1-ntsc.bin"
OSCODNL	= * - OSCODN
.endif
EOF
}

doall mypdrom_incbin_cartsio > targets/mypdrom-incbin-cartsio.inc

# Makefile
targets_mk() {

LIBFLASH_SRC='$(LIBFLASHINC)'
LIBFLASH_INC='-Ilibflash'

cat << EOF
cartsio-$1-pal.bin: mypdos/cartsiobin.src \$(CARTSIOINC)
	\$(ATASM) \$(MYPDOSFLAGS) -d$2 -dPAL -r -o\$@ \$<

cartsio-$1-ntsc.bin: mypdos/cartsiobin.src \$(CARTSIOINC)
	\$(ATASM) \$(MYPDOSFLAGS) -d$2 -r -o\$@ \$<

cartsiocode-osram-$1-pal.bin: \\
	cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc \$(CARTSIOINC)
	\$(ATASM) \$(ASMFLAGS) -d$2 -dPAL -r -o\$@ \$<

cartsiocode-osram-$1-ntsc.bin: \\
	cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc \$(CARTSIOINC)
	\$(ATASM) \$(ASMFLAGS) -d$2 -r -o\$@ \$<

mypdos-code-$1.bin: mypdos/mypdos.src \$(MYPDOSINC) \$(CARTSIOINC) \\
	mypdos/cartsio.src mypdos/imginfo.src \\
	targets/mypdos-incbin-cartsio.inc \\
	cartsio-$1-pal.bin cartsio-$1-ntsc.bin \\
	cartsiocode-osram-$1-pal.bin cartsiocode-osram-$1-ntsc.bin
	\$(ATASM) \$(MYPDOSFLAGS) -dMYPDOSROM -dCARTSIO -d$2 -r -o\$@ \$<

mypdos-$1.rom: mypdrom.src mypdos-code-$1.bin version.inc \\
	targets/mypdrom-incbin-cartsio.inc \\
	targets/mypdrom-incbin-mypdos.inc \\
	cartsio-$1-pal.bin cartsio-$1-ntsc.bin hisio.bin
	\$(ATASM) \$(MYPDOSFLAGS) -d$2 -r -f255 -o\$@ \$<

diskcart-$1.com: diskcart.src mypdos-$1.rom $LIBFLASH_SRC \\
	targets/diskcart-inc-target.inc \\
	targets/diskcart-incbin-mypdos.inc \\
	iohelp.inc iohelp.src arith.inc arith.src diskio.src version.inc
	\$(ATASM) \$(ASMFLAGS) $LIBFLASH_INC -d$2 -o\$@ \$<

diskwriter-$1.bin: diskcart-$1.com
	ataricom -b 1 -n \$< \$@

diskwriter-$1.c: diskwriter-$1.bin
	xxd -i \$< > \$@

mypdos-$1.c: mypdos-$1.rom
	xxd -i \$< > \$@

EOF
}

doall targets_mk > targets/targets.mk
