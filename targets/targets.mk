cartsio-freezer2011-pal.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -dFREEZER2011 -dPAL -r -o$@ $<

cartsio-freezer2011-ntsc.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -dFREEZER2011 -r -o$@ $<

cartsiocode-osram-freezer2011-pal.bin: \
	cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc $(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -dFREEZER2011 -dPAL -r -o$@ $<

cartsiocode-osram-freezer2011-ntsc.bin: \
	cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc $(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -dFREEZER2011 -r -o$@ $<

mypdos-code-freezer2011.bin: mypdos/mypdos.src $(MYPDOSINC) $(CARTSIOINC) \
	mypdos/cartsio.src mypdos/imginfo.src \
	targets/mypdos-incbin-cartsio.inc \
	cartsio-freezer2011-pal.bin cartsio-freezer2011-ntsc.bin \
	cartsiocode-osram-freezer2011-pal.bin cartsiocode-osram-freezer2011-ntsc.bin
	$(ATASM) $(MYPDOSFLAGS) -dMYPDOSROM -dCARTSIO -dFREEZER2011 -r -o$@ $<

mypdos-freezer2011.rom: mypdrom.src mypdos-code-freezer2011.bin version.inc \
	targets/mypdrom-incbin-cartsio.inc \
	targets/mypdrom-incbin-mypdos.inc \
	cartsio-freezer2011-pal.bin cartsio-freezer2011-ntsc.bin hisio.bin
	$(ATASM) $(MYPDOSFLAGS) -dFREEZER2011 -r -f255 -o$@ $<

diskcart-freezer2011.com: diskcart.src mypdos-freezer2011.rom $(LIBFLASHINC) \
	targets/diskcart-inc-target.inc \
	targets/diskcart-incbin-mypdos.inc \
	iohelp.inc iohelp.src arith.inc arith.src diskio.src version.inc
	$(ATASM) $(ASMFLAGS) -Ilibflash -dFREEZER2011 -o$@ $<

diskwriter-freezer2011.bin: diskcart-freezer2011.com
	ataricom -b 1 -n $< $@

diskwriter-freezer2011.c: diskwriter-freezer2011.bin
	xxd -i $< > $@

mypdos-freezer2011.c: mypdos-freezer2011.rom
	xxd -i $< > $@

cartsio-freezer2005-pal.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -dFREEZER2005 -dPAL -r -o$@ $<

cartsio-freezer2005-ntsc.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -dFREEZER2005 -r -o$@ $<

cartsiocode-osram-freezer2005-pal.bin: \
	cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc $(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -dFREEZER2005 -dPAL -r -o$@ $<

cartsiocode-osram-freezer2005-ntsc.bin: \
	cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc $(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -dFREEZER2005 -r -o$@ $<

mypdos-code-freezer2005.bin: mypdos/mypdos.src $(MYPDOSINC) $(CARTSIOINC) \
	mypdos/cartsio.src mypdos/imginfo.src \
	targets/mypdos-incbin-cartsio.inc \
	cartsio-freezer2005-pal.bin cartsio-freezer2005-ntsc.bin \
	cartsiocode-osram-freezer2005-pal.bin cartsiocode-osram-freezer2005-ntsc.bin
	$(ATASM) $(MYPDOSFLAGS) -dMYPDOSROM -dCARTSIO -dFREEZER2005 -r -o$@ $<

mypdos-freezer2005.rom: mypdrom.src mypdos-code-freezer2005.bin version.inc \
	targets/mypdrom-incbin-cartsio.inc \
	targets/mypdrom-incbin-mypdos.inc \
	cartsio-freezer2005-pal.bin cartsio-freezer2005-ntsc.bin hisio.bin
	$(ATASM) $(MYPDOSFLAGS) -dFREEZER2005 -r -f255 -o$@ $<

diskcart-freezer2005.com: diskcart.src mypdos-freezer2005.rom $(LIBFLASHINC) \
	targets/diskcart-inc-target.inc \
	targets/diskcart-incbin-mypdos.inc \
	iohelp.inc iohelp.src arith.inc arith.src diskio.src version.inc
	$(ATASM) $(ASMFLAGS) -Ilibflash -dFREEZER2005 -o$@ $<

diskwriter-freezer2005.bin: diskcart-freezer2005.com
	ataricom -b 1 -n $< $@

diskwriter-freezer2005.c: diskwriter-freezer2005.bin
	xxd -i $< > $@

mypdos-freezer2005.c: mypdos-freezer2005.rom
	xxd -i $< > $@

cartsio-megamax8-pal.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -dMEGAMAX8 -dPAL -r -o$@ $<

cartsio-megamax8-ntsc.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -dMEGAMAX8 -r -o$@ $<

cartsiocode-osram-megamax8-pal.bin: \
	cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc $(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -dMEGAMAX8 -dPAL -r -o$@ $<

cartsiocode-osram-megamax8-ntsc.bin: \
	cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc $(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -dMEGAMAX8 -r -o$@ $<

mypdos-code-megamax8.bin: mypdos/mypdos.src $(MYPDOSINC) $(CARTSIOINC) \
	mypdos/cartsio.src mypdos/imginfo.src \
	targets/mypdos-incbin-cartsio.inc \
	cartsio-megamax8-pal.bin cartsio-megamax8-ntsc.bin \
	cartsiocode-osram-megamax8-pal.bin cartsiocode-osram-megamax8-ntsc.bin
	$(ATASM) $(MYPDOSFLAGS) -dMYPDOSROM -dCARTSIO -dMEGAMAX8 -r -o$@ $<

mypdos-megamax8.rom: mypdrom.src mypdos-code-megamax8.bin version.inc \
	targets/mypdrom-incbin-cartsio.inc \
	targets/mypdrom-incbin-mypdos.inc \
	cartsio-megamax8-pal.bin cartsio-megamax8-ntsc.bin hisio.bin
	$(ATASM) $(MYPDOSFLAGS) -dMEGAMAX8 -r -f255 -o$@ $<

diskcart-megamax8.com: diskcart.src mypdos-megamax8.rom $(LIBFLASHINC) \
	targets/diskcart-inc-target.inc \
	targets/diskcart-incbin-mypdos.inc \
	iohelp.inc iohelp.src arith.inc arith.src diskio.src version.inc
	$(ATASM) $(ASMFLAGS) -Ilibflash -dMEGAMAX8 -o$@ $<

diskwriter-megamax8.bin: diskcart-megamax8.com
	ataricom -b 1 -n $< $@

diskwriter-megamax8.c: diskwriter-megamax8.bin
	xxd -i $< > $@

mypdos-megamax8.c: mypdos-megamax8.rom
	xxd -i $< > $@

cartsio-mega512-pal.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -dMEGA512 -dPAL -r -o$@ $<

cartsio-mega512-ntsc.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -dMEGA512 -r -o$@ $<

cartsiocode-osram-mega512-pal.bin: \
	cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc $(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -dMEGA512 -dPAL -r -o$@ $<

cartsiocode-osram-mega512-ntsc.bin: \
	cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc $(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -dMEGA512 -r -o$@ $<

mypdos-code-mega512.bin: mypdos/mypdos.src $(MYPDOSINC) $(CARTSIOINC) \
	mypdos/cartsio.src mypdos/imginfo.src \
	targets/mypdos-incbin-cartsio.inc \
	cartsio-mega512-pal.bin cartsio-mega512-ntsc.bin \
	cartsiocode-osram-mega512-pal.bin cartsiocode-osram-mega512-ntsc.bin
	$(ATASM) $(MYPDOSFLAGS) -dMYPDOSROM -dCARTSIO -dMEGA512 -r -o$@ $<

mypdos-mega512.rom: mypdrom.src mypdos-code-mega512.bin version.inc \
	targets/mypdrom-incbin-cartsio.inc \
	targets/mypdrom-incbin-mypdos.inc \
	cartsio-mega512-pal.bin cartsio-mega512-ntsc.bin hisio.bin
	$(ATASM) $(MYPDOSFLAGS) -dMEGA512 -r -f255 -o$@ $<

diskcart-mega512.com: diskcart.src mypdos-mega512.rom $(LIBFLASHINC) \
	targets/diskcart-inc-target.inc \
	targets/diskcart-incbin-mypdos.inc \
	iohelp.inc iohelp.src arith.inc arith.src diskio.src version.inc
	$(ATASM) $(ASMFLAGS) -Ilibflash -dMEGA512 -o$@ $<

diskwriter-mega512.bin: diskcart-mega512.com
	ataricom -b 1 -n $< $@

diskwriter-mega512.c: diskwriter-mega512.bin
	xxd -i $< > $@

mypdos-mega512.c: mypdos-mega512.rom
	xxd -i $< > $@

cartsio-mega4096-pal.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -dMEGA4096 -dPAL -r -o$@ $<

cartsio-mega4096-ntsc.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -dMEGA4096 -r -o$@ $<

cartsiocode-osram-mega4096-pal.bin: \
	cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc $(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -dMEGA4096 -dPAL -r -o$@ $<

cartsiocode-osram-mega4096-ntsc.bin: \
	cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc $(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -dMEGA4096 -r -o$@ $<

mypdos-code-mega4096.bin: mypdos/mypdos.src $(MYPDOSINC) $(CARTSIOINC) \
	mypdos/cartsio.src mypdos/imginfo.src \
	targets/mypdos-incbin-cartsio.inc \
	cartsio-mega4096-pal.bin cartsio-mega4096-ntsc.bin \
	cartsiocode-osram-mega4096-pal.bin cartsiocode-osram-mega4096-ntsc.bin
	$(ATASM) $(MYPDOSFLAGS) -dMYPDOSROM -dCARTSIO -dMEGA4096 -r -o$@ $<

mypdos-mega4096.rom: mypdrom.src mypdos-code-mega4096.bin version.inc \
	targets/mypdrom-incbin-cartsio.inc \
	targets/mypdrom-incbin-mypdos.inc \
	cartsio-mega4096-pal.bin cartsio-mega4096-ntsc.bin hisio.bin
	$(ATASM) $(MYPDOSFLAGS) -dMEGA4096 -r -f255 -o$@ $<

diskcart-mega4096.com: diskcart.src mypdos-mega4096.rom $(LIBFLASHINC) \
	targets/diskcart-inc-target.inc \
	targets/diskcart-incbin-mypdos.inc \
	iohelp.inc iohelp.src arith.inc arith.src diskio.src version.inc
	$(ATASM) $(ASMFLAGS) -Ilibflash -dMEGA4096 -o$@ $<

diskwriter-mega4096.bin: diskcart-mega4096.com
	ataricom -b 1 -n $< $@

diskwriter-mega4096.c: diskwriter-mega4096.bin
	xxd -i $< > $@

mypdos-mega4096.c: mypdos-mega4096.rom
	xxd -i $< > $@
