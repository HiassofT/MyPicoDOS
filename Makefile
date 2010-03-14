# 
# MyPicoDos V4.05 Makefile (c) 2003-2010 by Matthias Reichl <hias@horus.com>
#

ATASM=atasm
#ATASM=/data/src/xl/atasm103/src/atasm

CXX=g++
CXXFLAGS=-W -Wall

all: atr2cart atr2cart.exe test.rom diskcart.com

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

ASMFLAGS= -Icartsio -Ilibflash
#ASMFLAGS = -Icartsio -Ilibflash -s
#ASMFLAGS = -Icartsio -Ilibflash -v -s
#ASMFLAGS = -Icartsio -Ilibflash -s -dHWDEBUG

MYPDOSINC = common.inc getdens.src longname.src \
	rreadcode.src comloadcode.src basloadcode.src \
	rread.bin comload.bin basload.bin

CARTSIOINC = cartsio/cartsio.inc \
	cartsio/cartsiocode-ram.src cartsio/cartsiocode-rom.src

rread.bin: rread.src rreadcode.src common.inc
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

basload.bin: basload.src basloadcode.src common.inc rreadcode.src
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

comload.bin: comload.src comloadcode.src common.inc rreadcode.src
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

cartsio.bin: cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

mypdos-code-cartsio.bin: mypdos.src $(MYPDOSINC) \
	cartsio.src $(CARTSIOINC) cartsio.bin
	$(ATASM) $(ASMFLAGS) -dMYPDOSROM=1 -dCARTSIO=1 -r -o$@ $<

mypdos8.rom: mypdrom.src mypdos-code-cartsio.bin cartsio.bin
	$(ATASM) $(ASMFLAGS) -r -f255 -o$@ $<

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

testdisk.raw: testdisk.atr
	dd if=$< of=$@ bs=16 skip=1

mypdrom.c: mypdos8.rom
	xxd -i $< > $@

atr2cart.o: mypdrom.c

atr2cart: atr2cart.o AtrUtils.o Error.o
	$(CXX) -o $@ $^

atr2cart.exe: atr2cart.cpp AtrUtils.cpp Error.cpp
	i586-mingw32msvc-g++ $(CXXFLAGS) -o $@ $^
	i586-mingw32msvc-strip $@

diskcart.com: diskcart.src mypdos8.rom libflash/*.src libflash/*.inc \
	arith.inc arith.src diskio.src
	$(ATASM) $(ASMFLAGS) -o$@ $<
	mkdir -p disk
	cp -f $@ disk

clean:
	rm -f atr2cart atr2cart.exe mypdrom.c *.65o *.o *.bin *.com *.atr *.rom
