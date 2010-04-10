# 
# MyPicoDos V4.05 Makefile (c) 2003-2010 by Matthias Reichl <hias@horus.com>
#

ATASM=atasm
#ATASM=/data/src/xl/atasm103/src/atasm

CXX=g++
CXXFLAGS=-W -Wall

#all: atr2cart atr2cart.exe diskcart.com ctest.com diskcart-hi.com diskcart.atr
##	mydos.rom 512kbase.rom test.rom

#all: mypdos-mega512.rom mypdos-atarimax8.rom
all: diskcart.atr atr2cart m512.rom am8.rom

#all: MYINIT.COM MYINITR.COM \
#	MYPDOS.COM MYPDOSN.COM \
#	MYPDOSR.COM MYPDOSRN.COM \
#	MYPDOSB.COM PICOBOOT.COM \
#	MYPDOSS.COM \
#	mypdos.atr mypdosn.atr \
#	mypdosr.atr mypdosrn.atr \
#	mypdoss0.atr mypdoss1.atr \
#	mypdosb.atr \
#	myinit.atr

#all: MYPDOS.COM mypdos.atr mypdoshs.atr myinit2.atr

ASMFLAGS= -Icartsio -Ilibflash -Ihisio
#ASMFLAGS = -Icartsio -Ilibflash -Ihisio -s
#ASMFLAGS = -Icartsio -Ilibflash -Ihisio -v -s
#ASMFLAGS = -Icartsio -Ilibflash -Ihisio -s -dHWDEBUG

MYPDOSINC = mypdos/common.inc mypdos/getdens.src mypdos/longname.src \
	mypdos/rreadcode.src mypdos/comloadcode.src mypdos/basloadcode.src \
	rread.bin comload.bin basload.bin

MYPDOSFLAGS = $(ASMFLAGS) -Imypdos

CARTSIOINC = cartsio/cartsio.inc \
	cartsio/cartsiocode-ram.src cartsio/cartsiocode-rom.src \
	cartsio/cartsio-mega512.inc cartsio/cartsio-atarimax8.inc

HISIOINC = hisio/hisio.inc hisio/hisiocode.src hisio/hisiodet.src \
	hisio/hisiocode-break.src hisio/hisiocode-cleanup.src \
	hisio/hisiocode-main.src hisio/hisiocode-send.src \
	hisio/hisiocode-check.src hisio/hisiocode-diag.src \
	hisio/hisiocode-receive.src hisio/hisiocode-vbi.src

rread.bin: mypdos/rread.src mypdos/rreadcode.src mypdos/common.inc
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ $<

basload.bin: mypdos/basload.src mypdos/basloadcode.src mypdos/common.inc mypdos/rreadcode.src
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ $<

comload.bin: mypdos/comload.src mypdos/comloadcode.src mypdos/common.inc mypdos/rreadcode.src
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ $<

cartsio-mega512.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ -dMEGA512 $<

cartsio-atarimax8.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ -dATARIMAX8 $<

cartsiocode-osram-mega512.bin: cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc \
	$(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ -dMEGA512 $<

cartsiocode-osram-atarimax8.bin: cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc \
	$(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ -dATARIMAX8 $<

hisio.bin: hisio.src $(HISIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

mypdos-code-mega512.bin: mypdos/mypdos.src $(MYPDOSINC) \
	mypdos/cartsio.src $(CARTSIOINC) cartsio-mega512.bin mypdos/imginfo.src \
	cartsiocode-osram-mega512.bin
	$(ATASM) $(MYPDOSFLAGS) -dMYPDOSROM -dCARTSIO -dMEGA512 -r -o$@ $<

mypdos-code-atarimax8.bin: mypdos/mypdos.src $(MYPDOSINC) \
	mypdos/cartsio.src $(CARTSIOINC) cartsio-atarimax8.bin mypdos/imginfo.src \
	cartsiocode-osram-atarimax8.bin
	$(ATASM) $(MYPDOSFLAGS) -dMYPDOSROM -dCARTSIO -dATARIMAX8 -r -o$@ $<

mypdos-mega512.rom: mypdrom.src mypdos-code-mega512.bin cartsio-mega512.bin
	$(ATASM) $(MYPDOSFLAGS) -r -f255 -o$@ -dMEGA512 $<

mypdos-atarimax8.rom: mypdrom.src mypdos-code-atarimax8.bin cartsio-atarimax8.bin
	$(ATASM) $(MYPDOSFLAGS) -r -f255 -o$@ -dATARIMAX8 $<

8kblank.rom:
	dd if=/dev/zero bs=8k count=1 | tr '\000' '\377' > 8kblank.rom

16kblank.rom:
	dd if=/dev/zero bs=16k count=1 | tr '\000' '\377' > 16kblank.rom

512kbase.rom: mypdos8.rom 8kblank.rom 16kblank.rom
	cat 8kblank.rom mypdos8.rom 16kblank.rom 16kblank.rom 16kblank.rom \
	16kblank.rom 16kblank.rom 16kblank.rom 16kblank.rom \
	16kblank.rom 16kblank.rom 16kblank.rom 16kblank.rom \
	16kblank.rom 16kblank.rom 16kblank.rom 16kblank.rom \
	16kblank.rom 16kblank.rom 16kblank.rom 16kblank.rom \
	16kblank.rom 16kblank.rom 16kblank.rom 16kblank.rom \
	16kblank.rom 16kblank.rom 16kblank.rom 16kblank.rom \
	16kblank.rom 16kblank.rom 16kblank.rom 16kblank.rom \
	> $@

512k.rom: 512kbase.rom testdisk.raw testdd.atr
	cp -f 512kbase.rom $@
	dd if=testdisk.raw of=$@ conv=notrunc bs=16384 seek=1
	dd if=testdd.atr of=$@ conv=notrunc bs=1 seek=164608 skip=400

testdisk.atr: testdisk testdisk/*
	dir2atr -b MyPicoDos405N -P 1040 testdisk.atr testdisk

testdd.atr: testdisk testdisk/*
	dir2atr -b MyPicoDos405N -P -d 720 testdd.atr testdisk

#test.rom: atr2cart testdisk.atr testdd.atr
#	./atr2cart $@ testdisk.atr testdd.atr

m512.rom: atr2cart
	./atr2cart m512 m512.rom ~/private/xl/boot/turbo.atr ~/private/xl/boot/turbosd.atr ~/private/xl/boot/mydosx2.atr

am8.rom: atr2cart
	./atr2cart am8 am8.rom ~/private/xl/boot/turbo.atr ~/private/xl/boot/turbosd.atr ~/private/xl/boot/mydosx2.atr

mydos.rom: atr2cart
	./atr2cart $@ /data/hias/xl/camel/boot/mydosx1.atr

testdisk.raw: testdisk.atr
	dd if=$< of=$@ bs=16 skip=1

mypdos-mega512.c: mypdos-mega512.rom
	xxd -i $< > $@

mypdos-atarimax8.c: mypdos-atarimax8.rom
	xxd -i $< > $@

atr2cart.o: mypdos-mega512.c mypdos-atarimax8.c

atr2cart: atr2cart.o AtrUtils.o Error.o
	$(CXX) -o $@ $^

atr2cart.exe: atr2cart.cpp AtrUtils.cpp Error.cpp
	i586-mingw32msvc-g++ $(CXXFLAGS) -DWINVER -o $@ $^
	i586-mingw32msvc-strip $@

diskcart-mega512.com: diskcart.src mypdos-mega512.rom libflash/*.src libflash/*.inc \
	arith.inc arith.src diskio.src
	$(ATASM) $(ASMFLAGS) -o$@ -dMEGA512 $<
	mkdir -p disk
	cp -f $@ disk/mdisk.com

diskcart-mega512-hi.com: diskcart.src mypdos-mega512.rom libflash/*.src libflash/*.inc \
	arith.inc arith.src diskio.src hisio.bin
	$(ATASM) $(ASMFLAGS) -dHIGHSPEED -o$@ -dMEGA512 $<
	mkdir -p disk
	cp -f $@ disk/mdiskhi.com

diskcart-atarimax8.com: diskcart.src mypdos-atarimax8.rom libflash/*.src libflash/*.inc \
	arith.inc arith.src diskio.src
	$(ATASM) $(ASMFLAGS) -o$@ -dATARIMAX8 $<
	mkdir -p disk
	cp -f $@ disk/adisk.com

diskcart-atarimax8-hi.com: diskcart.src mypdos-atarimax8.rom libflash/*.src libflash/*.inc \
	arith.inc arith.src diskio.src hisio.bin
	$(ATASM) $(ASMFLAGS) -dHIGHSPEED -o$@ -dATARIMAX8 $<
	mkdir -p disk
	cp -f $@ disk/adiskhi.com

ctest.com: ctest.src libflash/*.src libflash/*.inc \
	arith.inc arith.src
	$(ATASM) $(ASMFLAGS) -o$@ $<
	mkdir -p disk
	cp -f $@ disk

diskcart.atr: diskcart-mega512.com diskcart-mega512-hi.com \
	diskcart-atarimax8.com diskcart-atarimax8-hi.com \
	ctest.com
	atascii piconame.txt > disk/PICONAME.TXT
	dir2atr -b MyPicoDos405 $@ disk

clean:
	rm -rf atr2cart atr2cart.exe mypdrom.c *.65o *.o *.bin *.com *.atr *.rom disk
