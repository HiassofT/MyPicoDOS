# 
# DiskCart Makefile (c) 2003-2013 by Matthias Reichl <hias@horus.com>
#

ATASM ?= atasm

CXX=g++
#CXXFLAGS=-W -Wall
CXXFLAGS=-W -Wall -g
#LDFLAGS=
LDFLAGS=-g

MINGW_CXX?=i686-w64-mingw32-g++
MINGW_STRIP?=i686-w64-mingw32-strip

all: diskcart.atr atr2cart atr2cart.exe
# m512.rom am8.rom

ASMFLAGS = 
#ASMFLAGS = -s
#ASMFLAGS = -v -s
#ASMFLAGS = -s -dHWDEBUG

ASMFLAGS += -Icartsio -Ihisio -Itargets
#ASMFLAGS += -dCOLORS -dFASTCOPY
#ASMFLAGS += -dCOLORS

MYPDOSINC = mypdos/common.inc mypdos/getdens.src mypdos/longname.src \
	mypdos/rreadcode.src mypdos/comloadcode.src mypdos/basloadcode.src \
	rread.bin comload.bin basload.bin

MYPDOSFLAGS = $(ASMFLAGS) -Imypdos

HISIOINC = hisio/hisio.inc hisio/hisiocode.src hisio/hisiodet.src \
	hisio/hisiocode-break.src hisio/hisiocode-cleanup.src \
	hisio/hisiocode-main.src hisio/hisiocode-send.src \
	hisio/hisiocode-check.src hisio/hisiocode-diag.src \
	hisio/hisiocode-receive.src hisio/hisiocode-vbi.src

CARTSIOINC = cartsio/cartsio.inc targets/cartsio-inc-target.inc \
	cartsio/cartsiocode-ram.src cartsio/cartsiocode-rom.src \
	cartsio/cartsiocode-osram.src \
	cartsio/cartsio-mega512.inc cartsio/cartsio-mega4096.inc \
	cartsio/cartsio-atarimax8.inc \
	cartsio/cartsio-freezer2005.inc cartsio/cartsio-freezer2011.inc

LIBFLASHINC = libflash/libflash.inc libflash/libflash.src \
	targets/libflash-inc-target.inc \
	libflash/libflash-atarimax8.src \
	libflash/libflash-freezer2005.src \
	libflash/libflash-freezer2011.src \
	libflash/libflash-mega512.src \
	libflash/libflash-mega4096.src

rread.bin: mypdos/rread.src mypdos/rreadcode.src mypdos/common.inc
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ $<

basload.bin: mypdos/basload.src mypdos/basloadcode.src mypdos/common.inc mypdos/rreadcode.src
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ $<

comload.bin: mypdos/comload.src mypdos/comloadcode.src mypdos/common.inc mypdos/rreadcode.src
	$(ATASM) $(MYPDOSFLAGS) -r -o$@ $<

hisio.bin: hisio.src $(HISIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

include targets/targets.mk

testdisk.atr: testdisk testdisk/*
	dir2atr -b MyPicoDos406N -P 1040 testdisk.atr testdisk

testam8.rom: testdisk.atr atr2cart
	./atr2cart -a am8 $@ $<
	
testdd.atr: testdisk testdisk/*
	dir2atr -b MyPicoDos406N -P -d 720 testdd.atr testdisk

mydos.rom: atr2cart
	./atr2cart $@ /data/hias/xl/camel/boot/mydosx1.atr

testdisk.raw: testdisk.atr
	dd if=$< of=$@ bs=16 skip=1

atr2cart.o: atr2cart.cpp\
	targets/atr2cart-inc-target.c \
	mypdos-mega512.c mypdos-mega4096.c \
	mypdos-atarimax8.c \
	mypdos-freezer2005.c mypdos-freezer2011.c \
	diskwriter-mega512.c diskwriter-mega4096.c \
	diskwriter-atarimax8.c \
	diskwriter-freezer2005.c diskwriter-freezer2011.c \
	diskwriter-freezer2011-512k.c

atr2cart: atr2cart.o AtrUtils.o Error.o
	$(CXX) $(LDFLAGS) -o $@ $^

atr2cart.exe: atr2cart.cpp AtrUtils.cpp Error.cpp
	$(MINGW_CXX) $(CXXFLAGS) -DWINVER -o $@ $^
	$(MINGW_STRIP) $@

piconame.txt: piconame.src version.inc
	$(ATASM) -r -o$@ $<

diskcart.atr: \
	diskcart-mega512.com \
	diskcart-mega4096.com \
	diskcart-atarimax8.com \
	diskcart-freezer2005.com \
	diskcart-freezer2011.com \
	diskcart-freezer2011-512k.com \
	piconame.txt
	rm -rf disk
	mkdir -p disk
	cp -f diskcart-mega512.com disk/medisk.com
	cp -f diskcart-mega4096.com disk/m4disk.com
	cp -f diskcart-atarimax8.com disk/am8disk.com
	cp -f diskcart-freezer2005.com disk/f05disk.com
	cp -f diskcart-freezer2011.com disk/f11disk.com
	cp -f diskcart-freezer2011-512k.com disk/f115disk.com
	cp -f piconame.txt disk/PICONAME.TXT
	dir2atr -b MyPicoDos406 1040 $@ disk

#test.rom: atr2cart testdisk.atr testdd.atr
#	./atr2cart $@ testdisk.atr testdd.atr

m512.rom: atr2cart
	./atr2cart m512 m512.rom ~/private/xl/boot/turbo.atr ~/private/xl/boot/turbosd.atr ~/private/xl/boot/mydosx1.atr

m4096.rom: atr2cart
	./atr2cart m4096 m4096.rom ~/private/xl/boot/turbo.atr ~/private/xl/boot/turbosd.atr ~/private/xl/boot/mydosx1.atr

am8.rom: atr2cart
	./atr2cart am8 am8.rom ~/private/xl/boot/turbo.atr ~/private/xl/boot/turbosd.atr ~/private/xl/boot/mydosx2.atr ~/private/xl/boot/mydosx1.atr


clean:
	rm -rf atr2cart atr2cart.exe mypdrom.c *.o *.bin *.com *.atr *.rom \
		mypdos*.c diskwriter*.c hisio.c disk piconame.txt
