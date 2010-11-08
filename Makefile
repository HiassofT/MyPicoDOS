# 
# MyPicoDos V4.05 Makefile (c) 2003-2010 by Matthias Reichl <hias@horus.com>
#

ATASM ?= atasm

CXX=g++
CXXFLAGS=-W -Wall

all: diskcart.atr diskcart-atarimax8.atr diskcart-freezer.atr diskcart-mega512.atr atr2cart atr2cart.exe
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
	cartsio/cartsio-atarimax8.inc cartsio/cartsio-freezer.inc \
	cartsio/cartsio-mega512.inc

HISIOINC = hisio/hisio.inc hisio/hisiocode.src hisio/hisiodet.src \
	hisio/hisiocode-break.src hisio/hisiocode-cleanup.src \
	hisio/hisiocode-main.src hisio/hisiocode-send.src \
	hisio/hisiocode-check.src hisio/hisiocode-diag.src \
	hisio/hisiocode-receive.src hisio/hisiocode-vbi.src

LIBFLASHINC = libflash/libflash.inc libflash/libflash.src \
	libflash/libflash-atarimax8.src \
	libflash/libflash-freezer.src \
	libflash/libflash-mega512.src

rread.bin: mypdos/rread.src mypdos/rreadcode.src mypdos/common.inc
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ $<

basload.bin: mypdos/basload.src mypdos/basloadcode.src mypdos/common.inc mypdos/rreadcode.src
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ $<

comload.bin: mypdos/comload.src mypdos/comloadcode.src mypdos/common.inc mypdos/rreadcode.src
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ $<

cartsio-atarimax8-pal.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ -dATARIMAX8 -dPAL $<

cartsio-atarimax8-ntsc.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ -dATARIMAX8 $<

cartsio-freezer-pal.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ -dFREEZER -dPAL $<

cartsio-freezer-ntsc.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ -dFREEZER $<

cartsio-mega512-pal.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ -dMEGA512 -dPAL $<

cartsio-mega512-ntsc.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ -dMEGA512 $<

cartsiocode-osram-atarimax8-pal.bin: cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc \
	$(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ -dATARIMAX8 -dPAL $<

cartsiocode-osram-atarimax8-ntsc.bin: cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc \
	$(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ -dATARIMAX8 $<

cartsiocode-osram-freezer-pal.bin: cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc \
	$(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ -dFREEZER -dPAL $<

cartsiocode-osram-freezer-ntsc.bin: cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc \
	$(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ -dFREEZER $<

cartsiocode-osram-mega512-pal.bin: cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc \
	$(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ -dMEGA512 -dPAL $<

cartsiocode-osram-mega512-ntsc.bin: cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc \
	$(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ -dMEGA512 $<

hisio.bin: hisio.src $(HISIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

mypdos-code-atarimax8.bin: mypdos/mypdos.src $(MYPDOSINC) $(CARTSIOINC) \
	mypdos/cartsio.src mypdos/imginfo.src \
	cartsio-atarimax8-pal.bin cartsio-atarimax8-ntsc.bin \
	cartsiocode-osram-atarimax8-pal.bin cartsiocode-osram-atarimax8-ntsc.bin
	$(ATASM) $(MYPDOSFLAGS) -dMYPDOSROM -dCARTSIO -dATARIMAX8 -r -o$@ $<

mypdos-code-freezer.bin: mypdos/mypdos.src $(MYPDOSINC) $(CARTSIOINC) \
	mypdos/cartsio.src mypdos/imginfo.src \
	cartsio-freezer-pal.bin cartsio-freezer-ntsc.bin \
	cartsiocode-osram-freezer-pal.bin cartsiocode-osram-freezer-ntsc.bin
	$(ATASM) $(MYPDOSFLAGS) -dMYPDOSROM -dCARTSIO -dFREEZER -r -o$@ $<

mypdos-code-mega512.bin: mypdos/mypdos.src $(MYPDOSINC) $(CARTSIOINC) \
	mypdos/cartsio.src mypdos/imginfo.src \
	cartsio-mega512-pal.bin cartsio-mega512-ntsc.bin \
	cartsiocode-osram-mega512-pal.bin cartsiocode-osram-mega512-ntsc.bin
	$(ATASM) $(MYPDOSFLAGS) -dMYPDOSROM -dCARTSIO -dMEGA512 -r -o$@ $<

mypdos-atarimax8.rom: mypdrom.src mypdos-code-atarimax8.bin \
	cartsio-atarimax8-pal.bin cartsio-atarimax8-ntsc.bin hisio.bin
	$(ATASM) $(MYPDOSFLAGS) -r -f255 -o$@ -dATARIMAX8 $<

mypdos-freezer.rom: mypdrom.src mypdos-code-freezer.bin \
	cartsio-freezer-pal.bin cartsio-freezer-ntsc.bin hisio.bin
	$(ATASM) $(MYPDOSFLAGS) -r -f255 -o$@ -dFREEZER $<

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

diskwriter-atarimax8.bin: diskcart-atarimax8.com
	ataricom -b 1 -n $< $@

diskwriter-atarimax8.c: diskwriter-atarimax8.bin
	xxd -i $< > $@

diskwriter-freezer.bin: diskcart-freezer.com
	ataricom -b 1 -n $< $@

diskwriter-freezer.c: diskwriter-freezer.bin
	xxd -i $< > $@

hisio.c: hisio.bin
	xxd -i $< > $@

mypdos-freezer.c: mypdos-freezer.rom
	xxd -i $< > $@

mypdos-mega512.c: mypdos-mega512.rom
	xxd -i $< > $@

mypdos-atarimax8.c: mypdos-atarimax8.rom
	xxd -i $< > $@

atr2cart.o: mypdos-mega512.c mypdos-atarimax8.c mypdos-freezer.c \
	diskwriter-mega512.c diskwriter-atarimax8.c diskwriter-freezer.c \
	hisio.c

atr2cart: atr2cart.o AtrUtils.o Error.o
	$(CXX) -o $@ $^

atr2cart.exe: atr2cart.cpp AtrUtils.cpp Error.cpp
	i586-mingw32msvc-g++ $(CXXFLAGS) -DWINVER -o $@ $^
	i586-mingw32msvc-strip $@

diskcart-atarimax8.com: diskcart.src mypdos-atarimax8.rom $(LIBFLASHINC) \
	iohelp.src arith.inc arith.src diskio.src
	$(ATASM) $(ASMFLAGS) -o$@ -dATARIMAX8 $<

diskcart-freezer.com: diskcart.src mypdos-freezer.rom $(LIBFLASHINC) \
	iohelp.src arith.inc arith.src diskio.src
	$(ATASM) $(ASMFLAGS) -o$@ -dFREEZER $<

diskcart-mega512.com: diskcart.src mypdos-mega512.rom $(LIBFLASHINC) \
	iohelp.src arith.inc arith.src diskio.src
	$(ATASM) $(ASMFLAGS) -o$@ -dMEGA512 $<

ctesta8.com: ctest.src $(LIBFLASHINC) \
	iohelp.src arith.inc arith.src
	$(ATASM) $(ASMFLAGS) -dATARIMAX8 -o$@ $<

ctestme.com: ctest.src $(LIBFLASHINC) \
	iohelp.src arith.inc arith.src
	$(ATASM) $(ASMFLAGS) -dMEGA512 -o$@ $<

diskcart.atr: \
	diskcart-atarimax8.com \
	diskcart-freezer.com \
	diskcart-mega512.com \
	ctesta8.com \
	ctestme.com
	rm -rf disk
	mkdir -p disk
	cp -f diskcart-atarimax8.com disk/amdisk.com
	cp -f diskcart-freezer.com disk/frdisk.com
	cp -f diskcart-mega512.com disk/medisk.com
	cp -f ctesta8.com disk
	cp -f ctestme.com disk
	atascii piconame.txt > disk/PICONAME.TXT
	dir2atr -b MyPicoDos405 $@ disk

diskcart-atarimax8.atr: diskcart-atarimax8.com ctesta8.com
	rm -rf disk-a8
	mkdir -p disk-a8
	cp -f diskcart-atarimax8.com disk-a8/amdisk.com
	cp -f ctesta8.com disk-a8
	atascii piconame-a8.txt > disk-a8/PICONAME.TXT
	dir2atr -b MyPicoDos405 $@ disk-a8

diskcart-freezer.atr: diskcart-freezer.com
	rm -rf disk-frz
	mkdir -p disk-frz
	cp -f diskcart-freezer.com disk-frz/frdisk.com
	atascii piconame-frz.txt > disk-frz/PICONAME.TXT
	dir2atr -b MyPicoDos405 $@ disk-frz

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
		mypdos*.c diskwriter*.c hisio.c disk disk-a8 disk-m512 disk-frz
