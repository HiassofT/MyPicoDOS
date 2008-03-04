all: MYPDOS.COM mypdos.atr

ASMFLAGS=
#ASMFLAGS = -s

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

myatr.atr:	mypdos.com mypdos.atr
	if test ! -d disk ; then mkdir disk ; fi
	cp mypdos.com disk/MYPDOS.COM
	dd if=mypdos.atr of=disk/MYPDOS.BIN bs=1 skip=16
	unix2atr -m 720 myatr.atr disk/

clean:
	rm -f *.65o *.bin *.com *.atr
