/*
   atr2cart - create flashcart image containing multiple ATRs

   Copyright (C) 2010 Matthias Reichl <hias@horus.com>

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#include <string.h>
#include <stdint.h>
#include <iostream>

#include "AtrUtils.h"
#include "AtariDebug.h"
#include "Error.h"

#include "mypdrom.c"

using namespace std;
using namespace AtrUtils;

#define IMAGESIZE (512*1024)

#define DRVTAB_OFFSET 0x3F00

static uint8_t rom_image[IMAGESIZE];

static unsigned int image_offset;
static unsigned int image_rom_end;	// highest rom address to use
static unsigned int current_driveno;

void set_drive_table(
	unsigned int driveno, // 1..8
	unsigned int density, // 0=sd, 1=dd, other=unused
	unsigned int sectors, // 1..65535
	unsigned int starting_offset_bytes)
{
	unsigned int ofs;
	if (driveno < 1 or driveno > 8) {
		Assert(false);
		return;
	}
	ofs = (driveno - 1) * 8 + DRVTAB_OFFSET;
	memset(rom_image + ofs, 0xff, 8);

	if (density <= 1) {
		rom_image[ofs] = density;
		rom_image[ofs+1] = (starting_offset_bytes >> 8) & 0xff;
		rom_image[ofs+2] = (starting_offset_bytes >> 16) & 0xff;
		rom_image[ofs+3] = sectors & 0xff;
		rom_image[ofs+4] = (sectors >> 8) & 0xff;
	}
}

void init_rom_image()
{
	int i;
	memset(rom_image, 0xff, IMAGESIZE);
	memcpy(rom_image + 8192, mypdos8_rom, 8192);
	for (i=1; i<=8; i++) {
		set_drive_table(i, 0xff, 0, 0);
	}
	image_offset = 0x4000;
	image_rom_end = IMAGESIZE;
	current_driveno = 1;
}

bool add_atr_image(const char* filename)
{
	FILE *f;
	bool isDD;
	unsigned int sectors;
	unsigned int i, s, ofs;
	unsigned int sector_size;
	unsigned int image_size;

	cout << "adding \"" << filename << "\": " << flush;
	if (current_driveno > 8) {
		cerr << "cannot store more than 8 disk images\n";
		return false;
	}

	if (!(f=fopen(filename, "rb"))) {
		cout << "error opening file" << endl;
		return false;
	}
	try {
		ReadAtrHeader(f, sectors, isDD);
	}
        catch (ErrorObject& err) {
		cout << err.AsString() << endl;
		fclose(f);
		return false;
        }
	sector_size = isDD ? 256 : 128;

	image_size = sectors * sector_size;
	if (image_offset + image_size > image_rom_end) {
		cout	<< "not enough space in ROM (need "
			<< image_size << ", have "
			<< (image_rom_end - image_offset) << ")" << endl;
		fclose(f);
		return false;
	}
	fseek(f, 16, SEEK_SET);

	for (i = 1; i <= sectors; i++) {
		ofs = image_offset + (i-1) * sector_size;
		s = (i<4) ? 128 : sector_size;
		if (fread(rom_image + ofs, s, 1, f) != 1) {
			cout << "error reading file" << endl;
			fclose(f);
			return false;
		}
	}

	set_drive_table(current_driveno, isDD ? 1 : 0, sectors, image_offset);

	cout	<< "OK"
		<< " (" << sectors << " " << (isDD ? "DD" : "SD") << " sectors"
		<< " at page " << (image_offset >> 8) << ")"
		<< endl;

	current_driveno++;
	image_offset += image_size;


	fclose(f);
	return true;
}

int main(int argc, char** argv)
{
	int idx = 1;
	bool ok = true;
	const char* out_filename;

	cout << "atr2cart V0.1 (c) 2010 by Matthias Reichl <hias@horus.com>" << endl;
	if (argc <= 2) {
		goto usage;
	}

	out_filename = argv[idx++];

	init_rom_image();

	while (ok && (idx < argc)) {
		ok = add_atr_image(argv[idx++]);
	}
	if (ok) {
		FILE* f;
		if (!(f = fopen(out_filename, "wb"))) {
			cout << "error creating image file \"" << out_filename << "\"" << endl;
			return 1;
		}
		if (fwrite(rom_image, IMAGESIZE, 1, f) != 1) {
			cout << "error writing image file \"" << out_filename << "\"" << endl;
			fclose(f);
			unlink(out_filename);
			return 1;
		}
		fclose(f);
		cout	<< "successfully created image file \"" << out_filename << "\"" 
			<< " (" << (image_rom_end - image_offset) / 1024 << "k free)"
			<< endl;
	}

	return 0;
usage:
	printf("usage: atr2catr outfile.rom file1.atr [file2.atr ...]\n");
	return 1;
}
