# 
# MyPicoDos V4.05 Makefile (c) 2003-2010 by Matthias Reichl <hias@horus.com>
#

ATASM ?= atasm

CXX=g++
CXXFLAGS=-W -Wall

all: diskcart.atr diskcart-megamax.atr diskcart-freezer05.atr diskcart-mega512.atr atr2cart atr2cart.exe
# m512.rom am8.rom

ASMFLAGS = 
#ASMFLAGS = -s
#ASMFLAGS = -v -s
#ASMFLAGS = -s -dHWDEBUG

ASMFLAGS += -Icartsio -Ilibflash -Ihisio
#ASMFLAGS += -dCOLORS -dFASTCOPY
#ASMFLAGS += -dCOLORS

MYPDOSINC = mypdos/common.inc mypdos/getdens.src mypdos/longname.src \
	mypdos/rreadcode.src mypdos/comloadcode.src mypdos/basloadcode.src \
	rread.bin comload.bin basload.bin

MYPDOSFLAGS = $(ASMFLAGS) -Imypdos

CARTSIOINC = cartsio/cartsio.inc \
	cartsio/cartsiocode-ram.src cartsio/cartsiocode-rom.src \
	cartsio/cartsiocode-osram.src \
	cartsio/cartsio-megamax8.inc cartsio/cartsio-freezer05.inc \
	cartsio/cartsio-mega512.inc

HISIOINC = hisio/hisio.inc hisio/hisiocode.src hisio/hisiodet.src \
	hisio/hisiocode-break.src hisio/hisiocode-cleanup.src \
	hisio/hisiocode-main.src hisio/hisiocode-send.src \
	hisio/hisiocode-check.src hisio/hisiocode-diag.src \
	hisio/hisiocode-receive.src hisio/hisiocode-vbi.src

LIBFLASHINC = libflash/libflash.inc libflash/libflash.src \
	libflash/libflash-megamax8.src \
	libflash/libflash-freezer2005.src \
	libflash/libflash-mega512.src

rread.bin: mypdos/rread.src mypdos/rreadcode.src mypdos/common.inc
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ $<

basload.bin: mypdos/basload.src mypdos/basloadcode.src mypdos/common.inc mypdos/rreadcode.src
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ $<

comload.bin: mypdos/comload.src mypdos/comloadcode.src mypdos/common.inc mypdos/rreadcode.src
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ $<

cartsio-megamax-pal.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ -dMEGAMAX8 -dPAL $<

cartsio-megamax-ntsc.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ -dMEGAMAX8 $<

cartsio-freezer05-pal.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ -dFREEZER2005 -dPAL $<

cartsio-freezer05-ntsc.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ -dFREEZER2005 $<

cartsio-mega512-pal.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ -dMEGA512 -dPAL $<

cartsio-mega512-ntsc.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ -dMEGA512 $<

cartsiocode-osram-megamax-pal.bin: cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc \
	$(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ -dMEGAMAX8 -dPAL $<

cartsiocode-osram-megamax-ntsc.bin: cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc \
	$(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ -dMEGAMAX8 $<

cartsiocode-osram-freezer05-pal.bin: cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc \
	$(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ -dFREEZER2005 -dPAL $<

cartsiocode-osram-freezer05-ntsc.bin: cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc \
	$(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ -dFREEZER2005 $<

cartsiocode-osram-mega512-pal.bin: cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc \
	$(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ -dMEGA512 -dPAL $<

cartsiocode-osram-mega512-ntsc.bin: cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc \
	$(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ -dMEGA512 $<

hisio.bin: hisio.src $(HISIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

mypdos-code-megamax.bin: mypdos/mypdos.src $(MYPDOSINC) $(CARTSIOINC) \
	mypdos/cartsio.src mypdos/imginfo.src \
	cartsio-megamax-pal.bin cartsio-megamax-ntsc.bin \
	cartsiocode-osram-megamax-pal.bin cartsiocode-osram-megamax-ntsc.bin
	$(ATASM) $(MYPDOSFLAGS) -dMYPDOSROM -dCARTSIO -dMEGAMAX8 -r -o$@ $<

mypdos-code-freezer05.bin: mypdos/mypdos.src $(MYPDOSINC) $(CARTSIOINC) \
	mypdos/cartsio.src mypdos/imginfo.src \
	cartsio-freezer05-pal.bin cartsio-freezer05-ntsc.bin \
	cartsiocode-osram-freezer05-pal.bin cartsiocode-osram-freezer05-ntsc.bin
	$(ATASM) $(MYPDOSFLAGS) -dMYPDOSROM -dCARTSIO -dFREEZER2005 -r -o$@ $<

mypdos-code-mega512.bin: mypdos/mypdos.src $(MYPDOSINC) $(CARTSIOINC) \
	mypdos/cartsio.src mypdos/imginfo.src \
	cartsio-mega512-pal.bin cartsio-mega512-ntsc.bin \
	cartsiocode-osram-mega512-pal.bin cartsiocode-osram-mega512-ntsc.bin
	$(ATASM) $(MYPDOSFLAGS) -dMYPDOSROM -dCARTSIO -dMEGA512 -r -o$@ $<

mypdos-megamax.rom: mypdrom.src mypdos-code-megamax.bin \
	cartsio-megamax-pal.bin cartsio-megamax-ntsc.bin hisio.bin
	$(ATASM) $(MYPDOSFLAGS) -r -f255 -o$@ -dMEGAMAX8 $<

mypdos-freezer05.rom: mypdrom.src mypdos-code-freezer05.bin \
	cartsio-freezer05-pal.bin cartsio-freezer05-ntsc.bin hisio.bin
	$(ATASM) $(MYPDOSFLAGS) -r -f255 -o$@ -dFREEZER2005 $<

mypdos-mega512.rom: mypdrom.src mypdos-code-mega512.bin \
	cartsio-mega512-pal.bin cartsio-mega512-ntsc.bin hisio.bin
	$(ATASM) $(MYPDOSFLAGS) -r -f255 -o$@ -dMEGA512 $<

testdisk.atr: testdisk testdisk/*
	dir2atr -b MyPicoDos405N -P 1040 testdisk.atr testdisk

testam8.rom: testdisk.atr atr2cart
	./atr2cart -a am8 $@ $<
	
testdd.atr: testdisk testdisk/*
	dir2atr -b MyPicoDos405N -P -d 720 testdd.atr testdisk

mydos.rom: atr2cart
	./atr2cart $@ /data/hias/xl/camel/boot/mydosx1.atr

testdisk.raw: testdisk.atr
	dd if=$< of=$@ bs=16 skip=1

diskwriter-mega512.bin: diskcart-mega512.com
	ataricom -b 1 -n $< $@

diskwriter-mega512.c: diskwriter-mega512.bin
	xxd -i $< > $@

diskwriter-megamax.bin: diskcart-megamax.com
	ataricom -b 1 -n $< $@

diskwriter-megamax.c: diskwriter-megamax.bin
	xxd -i $< > $@

diskwriter-freezer05.bin: diskcart-freezer05.com
	ataricom -b 1 -n $< $@

diskwriter-freezer05.c: diskwriter-freezer05.bin
	xxd -i $< > $@

mypdos-freezer05.c: mypdos-freezer05.rom
	xxd -i $< > $@

mypdos-mega512.c: mypdos-mega512.rom
	xxd -i $< > $@

mypdos-megamax.c: mypdos-megamax.rom
	xxd -i $< > $@

atr2cart.o: mypdos-mega512.c mypdos-megamax.c mypdos-freezer05.c \
	diskwriter-mega512.c diskwriter-megamax.c diskwriter-freezer05.c

atr2cart: atr2cart.o AtrUtils.o Error.o
	$(CXX) -o $@ $^

atr2cart.exe: atr2cart.cpp AtrUtils.cpp Error.cpp
	i586-mingw32msvc-g++ $(CXXFLAGS) -DWINVER -o $@ $^
	i586-mingw32msvc-strip $@

diskcart-megamax.com: diskcart.src mypdos-megamax.rom $(LIBFLASHINC) \
	iohelp.inc iohelp.src arith.inc arith.src diskio.src
	$(ATASM) $(ASMFLAGS) -o$@ -dMEGAMAX8 $<

diskcart-freezer05.com: diskcart.src mypdos-freezer05.rom $(LIBFLASHINC) \
	iohelp.inc iohelp.src arith.inc arith.src diskio.src
	$(ATASM) $(ASMFLAGS) -o$@ -dFREEZER2005 $<

diskcart-mega512.com: diskcart.src mypdos-mega512.rom $(LIBFLASHINC) \
	iohelp.inc iohelp.src arith.inc arith.src diskio.src
	$(ATASM) $(ASMFLAGS) -o$@ -dMEGA512 $<

ctestmm.com: ctest.src $(LIBFLASHINC) \
	iohelp.inc iohelp.src arith.inc arith.src
	$(ATASM) $(ASMFLAGS) -dMEGAMAX8 -o$@ $<

ctestme.com: ctest.src $(LIBFLASHINC) \
	iohelp.inc iohelp.src arith.inc arith.src
	$(ATASM) $(ASMFLAGS) -dMEGA512 -o$@ $<

diskcart.atr: \
	diskcart-megamax.com \
	diskcart-freezer05.com \
	diskcart-mega512.com \
	ctestmm.com \
	ctestme.com
	rm -rf disk
	mkdir -p disk
	cp -f diskcart-megamax.com disk/mmdisk.com
	cp -f diskcart-freezer05.com disk/f05disk.com
	cp -f diskcart-mega512.com disk/medisk.com
	cp -f ctestmm.com disk
	cp -f ctestme.com disk
	atascii piconame.txt > disk/PICONAME.TXT
	dir2atr -b MyPicoDos405 $@ disk

diskcart-megamax.atr: diskcart-megamax.com ctestmm.com
	rm -rf disk-m8
	mkdir -p disk-m8
	cp -f diskcart-megamax.com disk-m8/mmdisk.com
	cp -f ctestmm.com disk-m8
	atascii piconame-m8.txt > disk-m8/PICONAME.TXT
	dir2atr -b MyPicoDos405 $@ disk-m8

diskcart-freezer05.atr: diskcart-freezer05.com
	rm -rf disk-frz05
	mkdir -p disk-frz05
	cp -f diskcart-freezer05.com disk-frz05/f05disk.com
	atascii piconame-frz05.txt > disk-frz05/PICONAME.TXT
	dir2atr -b MyPicoDos405 $@ disk-frz05

diskcart-mega512.atr: diskcart-mega512.com ctestme.com
	rm -rf disk-m512
	mkdir -p disk-m512
	cp -f diskcart-mega512.com disk-m512/medisk.com
	cp -f ctestme.com disk-m512
	atascii piconame-m512.txt > disk-m512/PICONAME.TXT
	dir2atr -b MyPicoDos405 $@ disk-m512

#test.rom: atr2cart testdisk.atr testdd.atr
#	./atr2cart $@ testdisk.atr testdd.atr

m512.rom: atr2cart
	./atr2cart m512 m512.rom ~/private/xl/boot/turbo.atr ~/private/xl/boot/turbosd.atr ~/private/xl/boot/mydosx1.atr

am8.rom: atr2cart
	./atr2cart am8 am8.rom ~/private/xl/boot/turbo.atr ~/private/xl/boot/turbosd.atr ~/private/xl/boot/mydosx2.atr ~/private/xl/boot/mydosx1.atr


clean:
	rm -rf atr2cart atr2cart.exe mypdrom.c *.65o *.o *.bin *.com *.atr *.rom \
		mypdos*.c diskwriter*.c disk disk-m8 disk-m512 disk-frz
