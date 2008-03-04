all: MYPDOS.COM mypdos.atr

ASMFLAGS=
#ASMFLAGS = -s

mypdos.bin: mypdos.src getdens.src
	atasm $(ASMFLAGS) -r mypdos.src

mypdos.atr: mypdos.src mypdosatr.src getdens.src
	atasm $(ASMFLAGS) -r mypdosatr.src
	rm -f mypdos.atr
	mv mypdosatr.bin mypdos.atr

myinit.65o: myinit.src getdens.src
	atasm $(ASMFLAGS) myinit.src

MYPDOS.COM: mypdos.bin myinit.65o
	cat myinit.65o mypdos.bin > MYPDOS.COM

myinit2.atr: MYPDOS.COM
	cp MYPDOS.COM initdisk
	unix2atr -m 720 myinit2.atr initdisk

mytest.atr:	MYPDOS.COM mypdos.atr
	if test ! -d disk ; then mkdir disk ; fi
	cp MYPDOS.COM disk
	dd if=mypdos.atr of=disk/MYPDOS.BIN bs=1 skip=16
	unix2atr 720 mytest.atr disk/

clean:
	rm -f *.65o *.bin *.com *.atr

backup:
	tar zcf bak/mypdos-`date '+%y%m%d-%H%M'`.tgz *.src Makefile README* LICENSE mkdist
