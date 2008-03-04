# 
# MyPicoDos V4.0 Makefile (c) 2003-2004 by Matthias Reichl <hias@horus.com>
#

ATASM=atasm
#ATASM=/data/src/xl/atasm103/src/atasm

all: MYPDOS.COM mypdos.atr mypdoshs.atr myinit2.atr

#all: MYPDOS.COM mypdos.atr mypdoshs.atr myinit2.atr myinit3.atr

ASMFLAGS=
#ASMFLAGS = -s

MYPDOSINC = common.inc getdens.src longname.src \
	rreadcode.src comloadcode.src basloadcode.src \
	rread.bin comload.bin basload.bin

rread.bin: rread.src rreadcode.src common.inc
	$(ATASM) $(ASMFLAGS) -r rread.src

basload.bin: basload.src basloadcode.src common.inc rreadcode.src
	$(ATASM) $(ASMFLAGS) -r basload.src

comload.bin: comload.src comloadcode.src common.inc rreadcode.src
	$(ATASM) $(ASMFLAGS) -r comload.src

highspeed.bin: highspeed.src highspeedcode.src common.inc \
	rreadcode.src comloadcode.src
	$(ATASM) $(ASMFLAGS) -r highspeed.src

mypdos.bin: mypdos.src $(MYPDOSINC)
	$(ATASM) $(ASMFLAGS) -r mypdos.src

mypdoshs.bin: mypdos.src mypdoshs.src $(MYPDOSINC) \
	highspeedcode.src highspeed.bin
	$(ATASM) $(ASMFLAGS) -r mypdoshs.src

mypdos.atr: mypdos.src mypdosatr.src $(MYPDOSINC)
	$(ATASM) $(ASMFLAGS) -r mypdosatr.src
	rm -f mypdos.atr
	mv mypdosatr.bin mypdos.atr

mypdoshs.atr: mypdos.src mypdoshsatr.src $(MYPDOSINC) \
	highspeedcode.src highspeed.bin
	$(ATASM) $(ASMFLAGS) -r mypdoshsatr.src
	rm -f mypdoshs.atr
	mv mypdoshsatr.bin mypdoshs.atr

MYPDOS.COM: myinit.src getdens.src longname.src qsort.src cio.inc \
	mypdos.bin mypdoshs.bin
	$(ATASM) $(ASMFLAGS) myinit.src
	cp -f myinit.65o MYPDOS.COM

initdisk:
	mkdir initdisk

myinit2.atr: MYPDOS.COM initdisk
	cp MYPDOS.COM initdisk
	unix2atr -m 720 myinit2.atr initdisk

myinit3:
	mkdir myinit3

myinit3.atr: MYPDOS.COM myinit3
	cp MYPDOS.COM myinit3/MYDOS.AR0
	unix2atr -m 720 myinit3.atr myinit3

disk:
	mkdir disk

mytest.atr:	MYPDOS.COM mypdos.atr mypdoshs.atr disk
	if test ! -d disk ; then mkdir disk ; fi
	cp MYPDOS.COM disk
	dd if=mypdos.atr of=disk/MYPDOS.BIN bs=1 skip=16
	dd if=mypdoshs.atr of=disk/MYPDOSHS.BIN bs=1 skip=16
	unix2atr 720 mytest.atr disk/

clean:
	rm -f *.65o *.bin *.com *.atr

backup:
	tar zcf bak/mypdos-`date '+%y%m%d-%H%M'`.tgz *.src *.inc \
	Makefile README* LICENSE mkdist
