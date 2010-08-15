DiskCart / DiskWriter für 512k Flash Megacart V0.7

Copyright (C) 2010 by Matthias Reichl <hias@horus.com>

1. Features der Software

- Bis zu 8 Disketten Images beliebiger Grösse können in der
  Flashcart abgespeichert werden
- Nachträgliches Hinzufügen weiterer Images möglich
- Integriertes MyPicoDos zum Starten von Programmen direkt
  aus der Flashcart
- Image Boot Funktion (nur auf Atari XL/XE verfügbar)
- Software läuft auf allen Ataris ab 48k (auch Atari 400/800)


2. Anleitung DiskWriter

2.1 Was ist der DiskWriter

Mit dem "DiskWriter" können Disketten direkt mit dem Atari in
die Flashcart kopiert werden. Ausser einem Diskettenlaufwerk
(bzw. einem SIO2PC Kabel oder SIO2SD/SDrive/...) und natürlich
der Flashcart ist keine weitere Hardware erforderlich.

2.2 Starten des DiskWriters

Wurde die Flashcart bereits zuvor mit dem DiskWriter initialisiert,
kann der DiskWriter direkt aus der Flashcart geladen werden
(Details siehe Kapitel 3).

Bei erstmaliger Verwendung der Software muss die Datei "MEDISK.COM"
geladen werden.

Nach dem Start überprüft die Software ob ein Modul eingesteckt ist.
Wird kein Modul erkannt, erscheint die Meldung "No or unknown flash".
Durch Drücken einer beliebigen Taste kann die Erkennung neu gestartet
werden (hilfreich für die Freaks die zB einen Hardware-Schalter
zur Abschaltung der Module in ihren Atari eingebaut haben), mit der
"BREAK" Taste kann die Software beendet werden.

Danach überprüft die Software ob die Flashcart bereits initialisiert
wurde. Wenn ja, wird das Hauptmenü angezeigt (siehe Kaptitel 2.3).
Wenn nein erscheint die Meldung "cart uninitialized - init now (y/n)?".
Drückt man nun auf "y" wird die Flashcart mit der DiskCart Software
initialisert. ACHTUNG: Dabei wird die gesamte Flashcart gelöscht!
Drückt man auf "n", wird die Software neu gestartet (wieder für die
Freaks), per "BREAK" beendet man die Software.

2.3 Das DiskWriter Hauptmenü

Direkt unter der Titelzeile wird der Typ des Flash-Chips im Modul
angezeigt. Üblicherweise ist das "AMD 29F040B". Darunter steht die
Versionsnummer der DiskCart Software in der Flashcart (aktuell 20100713).
In der dritten Zeile steht die Info ob die integrierte Highspeed
SIO Routine eingeschaltet ist ("on") oder nicht ("off").

Danach folgt eine Liste der Disk-Images in der Flashcart, gefolgt
von der Grösse des freien Speichers in der Flashcart (in kB).

Die Liste der Images enthält folgende Informationen:

Ganz zu Beginn steht die Nummer des Images, in der Atari-üblichen
Schreibweise (also D1: bis D8:). Danach kommt die Grösse des
jeweiligen Images in Sektoren, gefolgt von der Dichte (also zB
1040 SD oder 720 DD). Zum Schluss folgt der (optionale) Name
des Images. Statt des Namens kann auch "incomplete data" (in
inverser Schrift) erscheinen, das bedeutet, daß beim Kopieren
des Images ein Fehler auftrat und deshalb dieses Image nicht
verfügbar ist.

Nun zu den einzelnen Punkten im Hauptmenü:

2.4 Init flash cartridge

Damit wird die Flashcart nach einer Sicherheitsabfrage neu initialisiert,
d.h. die Flashcart wird gelöscht und es wird die aktuelle DiskCart /
DiskWriter Software in die Flashcart geschrieben.

2.5 Add disk

Mit diesem Punkt kann man weitere Disks in die Flashcart schreiben.
Sind bereits 8 Images in der Flashcart gespeichert erscheint die
Fehlermeldung "image table full (max. 8)".

Als nächstes fragt der DiskWriter nach der Laufwerksnummer (1-8)
in der sich die zu kopierende Disk befindet. Mit "BREAK" kann man
wieder abbrechen, falls man die Funktion versehentlich aufgerufen hat.

Nun checkt der DiskWriter die Grösse der Diskette und gibt sie
am Bildschirm aus (zB "720 DD sectors"). Tritt dabei ein Fehler
auf (zB falsche Laufwerks-Nummer oder Laufwerk nicht eingeschaltet)
erscheint die Fehlermeldung "Error checking disk density" und
die Funktion wird abgebrochen.

Danach wird überprüft ob genügend freier Speicher in der Flashcart
vorhanden ist. Falls nein erscheit die Fehlermeldung "not enough free
space for disk".

Waren alle Checks OK und ist genügend freier Speicher vorhanden
fragt DiskWriter nach einem Namen. Diese Eingabe ist optional, man
kann auch einfach "RETURN" drücken, dann wird kein Name gespeichert.
Die aufmerksamen Leser werden es schon erraten haben, auch hier kann
man wieder mit "BREAK" die Funktion abbrechen.

Nun beginnt die Software die Disk einzulesen und ins Flash zu schreiben.
Läuft alles glatt sollte zum Schluss "operation successfully completed"
stehen. Bei einem Fehler (entweder Lesefehler von der Disk oder Fehler
beim Schreiben der Flashcart) wird eine Meldung ausgegeben und das
Image als "unvollständig" ("incomplete data") markiert.

Beim Kopieren wird übrigens der gesamte Disk-Inhalt inklusive Boot-
Sektoren ins Flash geschrieben. Zusätzlich wird der Disk-Status,
wie er vom Laufwerk gemeldet wurde und - falls vom Laufwerk
unterstützt - der Inhalt des Percom Blocks mit im Flash gespeichert.
Damit liegt eine 100% Kopie der Disk in der Flashcart.

2.6 Toggle HISIO on/off

Damit kann die integrierte Highspeed Routine an- bzw. abgeschaltet werden.

2.7 Start cartridge

Nach einer Abfrage wird die DiskCart Software in der FlashCart direkt
gestartet. Details zur DiskCart Software siehe Kapitel 3.

2.8 Exit Program

3 mal raten, ja, damit wird die DiskCart Software beendet :-)


3. Anleitung DiskCart

Wurde die Flashcart zuvor mit der DiskWriter Software initialisiert, so
wird beim Booten des Ataris automatisch das Hauptmenü der DiskCart
Software angezeigt. Dies kann übrigens durch Drücken der "OPTION"
Taste unterbunden werden (genauso wie beim eingebauten Basic).

3.1 Das DiskCart Hauptmenü

Hier wird eine Liste der Images in der Flashcart gefolgt von einer
Liste der verfügbaren Funktionen (in der unteren Bildschirmhälfte)
angezeigt. Die Liste der Funktionen kann variieren, zB ist die
Disk Boot Funktion nur auf XL/XEs verfügbar, sind keine Images
in der Flashcart gespeichert werden nur die Funktionen "start DiskWriter"
und "exit" angezeigt.

Nun zu den einzelnen Funktionen:

3.2 Starten der DiskWriter Software

Die DiskWriter Software wird beim Initialisieren in die Flashcart
geschrieben und kann mittels "W" aufgerufen werden. Dadurch kann
man jederzeit neue Images in die Flashcart schreiben und muß nicht
extra eine Diskette mit der DiskWriter Software dabeihaben.

3.3 Integriertes MyPicoDos

Durch Druck auf die Leertaste ("SPACE") wird eine speziell angepasste
Version von MyPicoDos gestartet. Diese Funktion ist verfügbar wenn
mindestens ein Image in der FlashCart gespeichert ist.

Die grundlegende Bedienung von MyPicoDos sollte hinlänglich bekannt
sein, deshalb hier nur eine Kurzbeschreibung der speziellen
FlashCart Version:

Mit "1" bis "8" kann man die Disk-Images 1 bis (maximal) 8 in der
Flashcart ansprechen. Wählt man ein nicht vorhandenes Image aus,
erscheint "disk error". Ein Zugriff auf "richtige" Diskettenlaufwerke
ist übrigens nicht möglich.

Mit "I" bekommt man eine Liste der Disk-Images in der Flashcart,
ähnlich wie im DiskCart Hauptmenü.

3.4 Booten von Images

Diese Funktion ist nur auf XL/XEs verfügbar, da dafür das OS ROM ins
RAM kopiert und angepasst werden muss.

Mit den Tasten "1" bis "8" kann ein Image ausgewählt und gebootet werden.
Zuvor kann mit "B" das eingebaute Basic an- bzw. abgeschaltet werden
und mit "D" kann man festlegen ob das ausgewählte Image der Flashcart als
"D1:" oder als "D2:" zur Verfügung stehen soll.

Wählt man "D1:" aus (der Default), so wird das Image gebootet. Nach dem
Booten bleibt das Image weiterhin als "D1:" verfügbar, weitere
vorhandene "richtige" Laufwerke kann man unter D2: etc. ansprechen.
Ein ggf. vorhandenes "D1:" Laufwerk wird aber ausgeblendet.

Wählt man "D2:" aus, so wird nur das 2. Laufwerk durch das Image in der
Flashcart "ersetzt". Der Atari bootet dann von einem "richtigen" D1:
Laufwerk. Diese Funktion ist unter anderem dann hilfreich, wenn man
Disk Images oder einzelne Dateien von der Flashcart wieder auf eine
"richtige" Diskette schreiben will: Man bootet ein DOS (oder einen
Sektorkopierer) von D1: und kann dann Daten von der Flashcart (D2:)
auf die Disk (zB D1:) kopieren.

Die DiskCart Software emuliert übrigens alle lesenden SIO Funktionen,
also neben "Read Sector" auch "Get Status" und "Get Percom Block".

Wie alle anderen Programme die das OS ins RAM kopieren und abändern
gibt's natürlich auch bei der Boot Funktion einige Einschränkungen
bezüglich der Kompatibilität:

Schaltet eine Software das OS ROM wieder ein, "verschwindet" das
Flashcart Laufwerk.

Überschreibt eine Software das RAM unter dem OS, kann der Atari
abstürzen. TurboBasic XL und die Disk Versionen von SpartaDOS
machen das und laufen daher nicht.

Die Image Boot Funktion installiert einen Reset-Handler (ab $0120),
der nach einem Reset das RAM unter dem OS wieder einblendet. Das
Flashcart Laufwerk sollte also auch nach einem Reset weiterhin
verfügbar sein, ausser ein Programm überscheibt oder deaktiviert
den Reset-Handler.

