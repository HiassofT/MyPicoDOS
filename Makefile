# 
# MyPicoDos V4.05 Makefile (c) 2003-2010 by Matthias Reichl <hias@horus.com>
#

ATASM=atasm
#ATASM=/data/src/xl/atasm103/src/atasm

CXX=g++
CXXFLAGS=-W -Wall

all: atr2cart atr2cart.exe diskcart.com diskcart-hi.com diskcart.atr
#	mydos.rom 512kbase.rom test.rom

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
	cartsio/cartsiocode-ram.src cartsio/cartsiocode-rom.src

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

cartsio.bin: mypdos/cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ $<

cartsiocode-osram.bin: cartsio/cartsiocode-osram.src cartsio/cartsiocode-osram.inc \
	$(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

hisio.bin: hisio.src $(HISIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

mypdos-code-cartsio.bin: mypdos/mypdos.src $(MYPDOSINC) \
	mypdos/cartsio.src $(CARTSIOINC) cartsio.bin mypdos/imginfo.src \
	cartsiocode-osram.bin
	$(ATASM) $(MYPDOSFLAGS) -dMYPDOSROM=1 -dCARTSIO=1 -r -o$@ $<

mypdos8.rom: mypdrom.src mypdos-code-cartsio.bin cartsio.bin
	$(ATASM) $(MYPDOSFLAGS) -r -f255 -o$@ $<

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

test.rom: atr2cart testdisk.atr testdd.atr
	./atr2cart $@ testdisk.atr testdd.atr

mydos.rom: atr2cart
	./atr2cart $@ /data/hias/xl/camel/boot/mydosx1.atr

testdisk.raw: testdisk.atr
	dd if=$< of=$@ bs=16 skip=1

mypdrom.c: mypdos8.rom
	xxd -i $< > $@

atr2cart.o: mypdrom.c

atr2cart: atr2cart.o AtrUtils.o Error.o
	$(CXX) -o $@ $^

atr2cart.exe: atr2cart.cpp AtrUtils.cpp Error.cpp
	i586-mingw32msvc-g++ $(CXXFLAGS) -DWINVER -o $@ $^
	i586-mingw32msvc-strip $@

diskcart.com: diskcart.src mypdos8.rom libflash/*.src libflash/*.inc \
	arith.inc arith.src diskio.src
	$(ATASM) $(ASMFLAGS) -o$@ $<
	mkdir -p disk
	cp -f $@ disk

diskcart-hi.com: diskcart.src mypdos8.rom libflash/*.src libflash/*.inc \
	arith.inc arith.src diskio.src hisio.bin
	$(ATASM) $(ASMFLAGS) -dHIGHSPEED -o$@ $<
	mkdir -p disk
	cp -f $@ disk/diskchi.com

diskcart.atr: diskcart.com
	atascii piconame.txt > disk/PICONAME.TXT
	dir2atr -b MyPicoDos405 $@ disk

clean:
	rm -rf atr2cart atr2cart.exe mypdrom.c *.65o *.o *.bin *.com *.atr *.rom disk
