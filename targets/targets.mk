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

cartsio-atarimax8-pal.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -dATARIMAX8 -dPAL -r -o$@ $<

cartsio-atarimax8-ntsc.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -dATARIMAX8 -r -o$@ $<

cartsiocode-osram-atarimax8-pal.bin: \
	cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc $(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -dATARIMAX8 -dPAL -r -o$@ $<

cartsiocode-osram-atarimax8-ntsc.bin: \
	cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc $(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -dATARIMAX8 -r -o$@ $<

mypdos-code-atarimax8.bin: mypdos/mypdos.src $(MYPDOSINC) $(CARTSIOINC) \
	mypdos/cartsio.src mypdos/imginfo.src \
	targets/mypdos-incbin-cartsio.inc \
	cartsio-atarimax8-pal.bin cartsio-atarimax8-ntsc.bin \
	cartsiocode-osram-atarimax8-pal.bin cartsiocode-osram-atarimax8-ntsc.bin
	$(ATASM) $(MYPDOSFLAGS) -dMYPDOSROM -dCARTSIO -dATARIMAX8 -r -o$@ $<

mypdos-atarimax8.rom: mypdrom.src mypdos-code-atarimax8.bin version.inc \
	targets/mypdrom-incbin-cartsio.inc \
	targets/mypdrom-incbin-mypdos.inc \
	cartsio-atarimax8-pal.bin cartsio-atarimax8-ntsc.bin hisio.bin
	$(ATASM) $(MYPDOSFLAGS) -dATARIMAX8 -r -f255 -o$@ $<

diskcart-atarimax8.com: diskcart.src mypdos-atarimax8.rom $(LIBFLASHINC) \
	targets/diskcart-inc-target.inc \
	targets/diskcart-incbin-mypdos.inc \
	iohelp.inc iohelp.src arith.inc arith.src diskio.src version.inc
	$(ATASM) $(ASMFLAGS) -Ilibflash -dATARIMAX8 -o$@ $<

diskwriter-atarimax8.bin: diskcart-atarimax8.com
	ataricom -b 1 -n $< $@

diskwriter-atarimax8.c: diskwriter-atarimax8.bin
	xxd -i $< > $@

mypdos-atarimax8.c: mypdos-atarimax8.rom
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

cartsio-sxegs512-pal.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -dSXEGS512 -dPAL -r -o$@ $<

cartsio-sxegs512-ntsc.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -dSXEGS512 -r -o$@ $<

cartsiocode-osram-sxegs512-pal.bin: \
	cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc $(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -dSXEGS512 -dPAL -r -o$@ $<

cartsiocode-osram-sxegs512-ntsc.bin: \
	cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc $(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -dSXEGS512 -r -o$@ $<

mypdos-code-sxegs512.bin: mypdos/mypdos.src $(MYPDOSINC) $(CARTSIOINC) \
	mypdos/cartsio.src mypdos/imginfo.src \
	targets/mypdos-incbin-cartsio.inc \
	cartsio-sxegs512-pal.bin cartsio-sxegs512-ntsc.bin \
	cartsiocode-osram-sxegs512-pal.bin cartsiocode-osram-sxegs512-ntsc.bin
	$(ATASM) $(MYPDOSFLAGS) -dMYPDOSROM -dCARTSIO -dSXEGS512 -r -o$@ $<

mypdos-sxegs512.rom: mypdrom.src mypdos-code-sxegs512.bin version.inc \
	targets/mypdrom-incbin-cartsio.inc \
	targets/mypdrom-incbin-mypdos.inc \
	cartsio-sxegs512-pal.bin cartsio-sxegs512-ntsc.bin hisio.bin
	$(ATASM) $(MYPDOSFLAGS) -dSXEGS512 -r -f255 -o$@ $<

diskcart-sxegs512.com: diskcart.src mypdos-sxegs512.rom $(LIBFLASHINC) \
	targets/diskcart-inc-target.inc \
	targets/diskcart-incbin-mypdos.inc \
	iohelp.inc iohelp.src arith.inc arith.src diskio.src version.inc
	$(ATASM) $(ASMFLAGS) -Ilibflash -dSXEGS512 -o$@ $<

diskwriter-sxegs512.bin: diskcart-sxegs512.com
	ataricom -b 1 -n $< $@

diskwriter-sxegs512.c: diskwriter-sxegs512.bin
	xxd -i $< > $@

mypdos-sxegs512.c: mypdos-sxegs512.rom
	xxd -i $< > $@

