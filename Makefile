all: MYPDOS.COM mypdos.atr

#ASMFLAGS=
ASMFLAGS = -s

mypdos.bin: mypdos.src
	atasm $(ASMFLAGS) -r mypdos.src

mypdos.atr: mypdos.src mypdosatr.src
	atasm $(ASMFLAGS) -r mypdosatr.src
	rm -f mypdos.atr
	mv mypdosatr.bin mypdos.atr

myinit.65o: myinit.src
	atasm $(ASMFLAGS) myinit.src

MYPDOS.COM: mypdos.bin myinit.65o
	cat myinit.65o mypdos.bin > MYPDOS.COM

# the creation of myinit.atr requires that you have a directory
# called 'initdisk' containing the DOS.SYS and DUP.SYS files of MyDos

myinit.atr: MYPDOS.COM
	cp MYPDOS.COM initdisk
	unix2atr -m 720 myinit.atr initdisk

myatr.atr:	MYPDOS.COM mypdos.atr
	if test ! -d disk ; then mkdir disk ; fi
	cp MYPDOS.COM disk
	dd if=mypdos.atr of=disk/MYPDOS.BIN bs=1 skip=16
	unix2atr 720 myatr.atr disk/

clean:
	rm -f *.65o *.bin *.com *.atr

backup:
	tar zcf bak/mypdos-`date '+%y%m%d-%H%M'`.tgz *.src Makefile README* LICENSE mkdist
