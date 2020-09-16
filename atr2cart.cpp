/*
   atr2cart - create flashcart image containing multiple ATRs

   Copyright (C) 2010-2020 Matthias Reichl <hias@horus.com>

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

#include <string>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <iostream>

#include "AtrUtils.h"
#include "AtariDebug.h"
#include "Error.h"

#include "targets/atr2cart-inc-target.c"

#ifdef WINVER
#define DIR_SEPARATOR '\\'
#else
#define DIR_SEPARATOR '/'
#endif

using namespace std;
using namespace AtrUtils;

enum ECartType {
	eMega512 = 0,
	eAtariMax8 = 1,
	eFreezer2005 = 2,
	eFreezer2011 = 3,
	eFreezer2011_512 = 4,
	eMega4096 = 5,
	eNoCart = 6
};

static ECartType cartType = eNoCart;

struct CartConfig {
	unsigned long image_size;	// total size of ROM image
	unsigned long image_start;	// start of disk images
	unsigned long image_end;	// end of disk images
	unsigned long cfgpage_offset;
	unsigned long cartrom_offset;
	unsigned long diskwriter_offset;
};

enum EConfigPageOffset {
	eOfsDriveTab = 0,
	eOfsImageEndAddress = 0xd0,
	eOfsAutorun = 0xdf
};

static const struct CartConfig AllCartConfigs[] = {
// Mega512
	{ 0x80000, 0x4000, 0x80000, 0x3f00, 0x2000, 0 },
// AtariMax 8MBit
	{ 0x100000, 0x2000, 0xfe000, 0x1f00, 0, 0xfe000 },
// Freezer 2005
	{ 0x70000, 0x4000, 0x70000, 0x1f00, 0, 0x2000 },
// Freezer 2011 / 960k
	{ 0xF0000, 0x4000, 0xF0000, 0x1f00, 0, 0x2000 },
// Freezer 2011 / 512k
	{ 0x80000, 0x4000, 0x80000, 0x1f00, 0, 0x2000 },
// Mega4096
	{ 0x3fc000, 0, 0x3f8000, 0x3fbf00, 0x3fa000, 0x3f8000 },
};

static const struct CartConfig* cartconfig;

// sector 0 of each image contains internal information:
// byte  0 ..  3 is "get status" data
// byte  4 .. 15 is "percom block" data
// byte 16 .. 47 is image name (EOL terminated)

#define STATUS_OFFSET 0
#define PERCOM_OFFSET 4
#define NAME_OFFSET 16
#define NAME_LENGTH 32

static uint8_t *rom_image = NULL;

static unsigned int current_driveno;
static unsigned long image_offset;

string& prepare_imagename(string& name)
{
	string::size_type idx;

	// strip directory
	idx = name.find_last_of(DIR_SEPARATOR);
	if (idx != string::npos) {
		name.erase(0, idx+1);
	}

	idx = name.find_last_of('.');
	if (idx != string::npos && idx+4 == name.length()) {
		name.erase(idx);
	}
	return name;
}


void set_drive_table(
	unsigned int driveno, // 1..8
	unsigned int density, // 0=sd, 1=dd, other=unused
	unsigned int sectors, // 1..65535
	unsigned long starting_offset_bytes)
{
	unsigned int ofs;

	if (driveno < 1 or driveno > 8) {
		Assert(false);
		return;
	}
	ofs = (driveno - 1) * 8 + cartconfig->cfgpage_offset + eOfsDriveTab;
	memset(rom_image + ofs, 0xff, 8);

	if (density <= 1) {
		rom_image[ofs] = 0; // slot active
		rom_image[ofs+1] = density;
		rom_image[ofs+2] = (starting_offset_bytes >> 8) & 0xff;
		rom_image[ofs+3] = (starting_offset_bytes >> 16) & 0xff;
		rom_image[ofs+4] = sectors & 0xff;
		rom_image[ofs+5] = (sectors >> 8) & 0xff;
	}
}

void init_rom_image(bool autorun)
{
	int i;
	rom_image = (uint8_t*) malloc(cartconfig->image_size);
	memset(rom_image, 0xff, cartconfig->image_size);

	switch (cartType) {
	case eMega512:
		memcpy(rom_image + cartconfig->cartrom_offset, mypdos_mega512_rom, 0x2000);
		memcpy(rom_image + cartconfig->diskwriter_offset, diskwriter_mega512_bin, sizeof(diskwriter_mega512_bin));
		break;
	case eMega4096:
		memcpy(rom_image + cartconfig->cartrom_offset, mypdos_mega4096_rom, 0x2000);
		memcpy(rom_image + cartconfig->diskwriter_offset, diskwriter_mega4096_bin, sizeof(diskwriter_mega4096_bin));
		break;
	case eAtariMax8:
		memcpy(rom_image + cartconfig->cartrom_offset, mypdos_atarimax8_rom, 0x2000);
		memcpy(rom_image+cartconfig->image_size-32, mypdos_atarimax8_rom + 0x2000-32, 32);	// cart init code for Atarimax
		memcpy(rom_image + cartconfig->diskwriter_offset, diskwriter_atarimax8_bin, sizeof(diskwriter_atarimax8_bin));
		break;
	case eFreezer2005:
		memcpy(rom_image + cartconfig->cartrom_offset, mypdos_freezer2005_rom, 0x2000);
		memcpy(rom_image + cartconfig->diskwriter_offset, diskwriter_freezer2005_bin, sizeof(diskwriter_freezer2005_bin));
		break;

	case eFreezer2011:
	case eFreezer2011_512:
		memcpy(rom_image + cartconfig->cartrom_offset, mypdos_freezer2011_rom, 0x2000);
		memcpy(rom_image + cartconfig->diskwriter_offset, diskwriter_freezer2011_bin, sizeof(diskwriter_freezer2011_bin));
		break;

	default:
		assert(false);
	}

	rom_image[cartconfig->cfgpage_offset + eOfsImageEndAddress] =
		 cartconfig->image_end & 0xff;
	rom_image[cartconfig->cfgpage_offset + eOfsImageEndAddress + 1] =
		(cartconfig->image_end >> 8) & 0xff;
	rom_image[cartconfig->cfgpage_offset + eOfsImageEndAddress + 2] =
		(cartconfig->image_end >> 16) & 0xff;
	rom_image[cartconfig->cfgpage_offset + eOfsImageEndAddress + 3] =
		(cartconfig->image_end >> 24) & 0xff;

	if (autorun) {
		rom_image[cartconfig->cfgpage_offset + eOfsAutorun] = 1;
	} else {
		rom_image[cartconfig->cfgpage_offset + eOfsAutorun] = 0;
	}

	for (i=1; i<=8; i++) {
		set_drive_table(i, 0xff, 0, 0);
	}

	image_offset = cartconfig->image_start;
	current_driveno = 1;
}


const uint8_t percom_block_sd[12] =
{
	40,	// tracks
	0,	// step rate
	0, 18,	// sectors per track hi/lo
	0,	// sides -1
	0,	// density FM/MFM
	0, 128,	// bytes per sector hi/lo
	1,	// drive online
	1,0,0	// dummy transfer rate, reserved
};

const uint8_t percom_block_ed[12] =
{
	40,	// tracks
	0,	// step rate
	0, 26,	// sectors per track hi/lo
	0,	// sides -1
	4,	// density FM/MFM
	0, 128,	// bytes per sector hi/lo
	1,	// drive online
	1,0,0	// dummy transfer rate, reserved
};

const uint8_t percom_block_dd[12] =
{
	40,	// tracks
	0,	// step rate
	0, 18,	// sectors per track hi/lo
	0,	// sides -1
	4,	// density FM/MFM
	1, 0,	// bytes per sector hi/lo
	1,	// drive online
	1,0,0	// dummy transfer rate, reserved
};

const uint8_t percom_block_qd[12] =
{
	40,	// tracks
	0,	// step rate
	0, 18,	// sectors per track hi/lo
	1,	// sides -1
	4,	// density FM/MFM
	1, 0,	// bytes per sector hi/lo
	1,	// drive online
	1,0,0	// dummy transfer rate, reserved
};

uint8_t percom_block_other[12] =
{
	1,	// tracks
	0,	// step rate
	0, 0,	// sectors per track hi/lo FILL IN
	0,	// sides -1
	4,	// density FM/MFM
	0, 0,	// bytes per sector hi/lo FILL IN
	1,	// drive online
	1,0,0	// dummy transfer rate, reserved
};

void set_image_infos(bool isDD, unsigned int sectors, string name)
{
	// set status info
	uint8_t status = 0x18; // motor on, write protected
	if (isDD) {
		// double density
		status |= 0x20;
		if (sectors == 1440) {
			// XF551 QD
			status |= 0x40;
		}
	} else {
		// single density
		if (sectors == 1040) {
			// enhanced density
			status |= 0x80;
		}
	}
	rom_image[image_offset + STATUS_OFFSET] = status;
	rom_image[image_offset + STATUS_OFFSET + 1] = 0xff; // dummy "last FDC status"
	rom_image[image_offset + STATUS_OFFSET + 2] = 0xe0; // dummy "format disk timeout"
	rom_image[image_offset + STATUS_OFFSET + 3] = 0; // dummy "characters in output buffer"

	const uint8_t* percom = percom_block_other;
	// set percom block
	if (isDD) {
		switch (sectors) {
		case 720: percom = percom_block_dd; break;
		case 1440: percom = percom_block_qd; break;
		default:
			percom_block_other[2] = sectors >> 8;
			percom_block_other[3] = sectors & 0xff;
			percom_block_other[6] = 1;	// bytes per sector
			percom_block_other[7] = 0;
			break;
		}
	} else {
		switch (sectors) {
		case 720: percom = percom_block_sd; break;
		case 1040: percom = percom_block_ed; break;
		default:
			percom_block_other[2] = sectors >> 8;
			percom_block_other[3] = sectors & 0xff;
			percom_block_other[6] = 0;	// bytes per sector
			percom_block_other[7] = 128;
			break;
		}
	}
	memcpy(rom_image + image_offset + PERCOM_OFFSET, percom, 12);

	// set image name
	name = prepare_imagename(name);

	// check maximum size
	if (name.length() > NAME_LENGTH-1) {
		name.erase(NAME_LENGTH-1);
	}
	name += 0x9b;

	memcpy(rom_image + image_offset + NAME_OFFSET, name.c_str(), name.length());
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

	// round up offset to next page, in case the disk image contained
	// an even number of SD sectors
	image_size = ( (sectors+1) * sector_size + 0xff) & ~0xff;

	if (image_offset + image_size > cartconfig->image_end) {
		cout	<< "not enough space in ROM (need "
			<< image_size << ", have "
			<< (cartconfig->image_end - image_offset) << ")" << endl;
		fclose(f);
		return false;
	}
	fseek(f, 16, SEEK_SET);

	for (i = 1; i <= sectors; i++) {
		ofs = image_offset + i * sector_size;
		s = (i<4) ? 128 : sector_size;
		if (fread(rom_image + ofs, s, 1, f) != 1) {
			cout << "error reading file" << endl;
			fclose(f);
			return false;
		}
	}

	set_drive_table(current_driveno, isDD ? 1 : 0, sectors, image_offset);

	set_image_infos(isDD, sectors, filename);

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
	bool autorun = false;
	const char* out_filename;

	cout << "atr2cart V1.22 (c) 2010-2020 by Matthias Reichl <hias@horus.com>" << endl;
	if (argc <= 3) {
		goto usage;
	}
	if (strcmp(argv[idx], "-a") == 0) {
		autorun = true;
		idx++;
		if (idx + 3 > argc) {
			goto usage;
		}
	}

	cartType = eNoCart;

	if (strcasecmp(argv[idx], "m512") == 0) {
		cartType = eMega512;
		cout << "output type: MegaCart 512k" << endl;
	}
	if (strcasecmp(argv[idx], "m4096") == 0) {
		cartType = eMega4096;
		cout << "output type: 4MB MegaCart" << endl;
	}
	if (strcasecmp(argv[idx], "am8") == 0) {
		cartType = eAtariMax8;
		cout << "output type: AtariMax 8MBit FlashCart" << endl;
	}
	if (strcasecmp(argv[idx], "frz05") == 0) {
		cartType = eFreezer2005;
		cout << "output type: TurboFreezer 2005 CartEmu" << endl;
	}
	if (strcasecmp(argv[idx], "frz11") == 0) {
		cartType = eFreezer2011;
		cout << "output type: TurboFreezer 2011 CartEmu (960k)" << endl;
	}
	if (strcasecmp(argv[idx], "frz11_512") == 0) {
		cartType = eFreezer2011_512;
		cout << "output type: TurboFreezer 2011 CartEmu (512k)" << endl;
	}
	if (cartType == eNoCart) {
		goto usage;
	}
	cartconfig = AllCartConfigs + cartType;
	idx++;

	out_filename = argv[idx++];

	init_rom_image(autorun);

	while (ok && (idx < argc)) {
		ok = add_atr_image(argv[idx++]);
	}
	if (ok) {
		FILE* f;
		if (!(f = fopen(out_filename, "wb"))) {
			cout << "error creating image file \"" << out_filename << "\"" << endl;
			return 1;
		}
		if (fwrite(rom_image, cartconfig->image_size, 1, f) != 1) {
			cout << "error writing image file \"" << out_filename << "\"" << endl;
			fclose(f);
			unlink(out_filename);
			return 1;
		}
		fclose(f);
		cout	<< "successfully created image file \"" << out_filename << "\"" 
			<< " (" << (cartconfig->image_end - image_offset) / 1024 << "k free)"
			<< endl;
	}

	if (rom_image != NULL) {
		free(rom_image);
		rom_image = NULL;
	}
	return 0;
usage:
	cout << "usage: atr2catr [-a] type outfile.rom file1.atr [file2.atr ...]" << endl;
	cout << "   -a: enable MyPicoDos autostart" << endl;
	cout << "supported types:" << endl;
	cout << "      am8: AtariMax 8MBit FlashCart" << endl;
	cout << "     m512: MegaCart 512k" << endl;
	cout << "    m4096: MegaCart 4MB" << endl;
	cout << "    frz05: TurboFreezer 2005 CartEmu" << endl;
	cout << "    frz11: TurboFreezer 2011 CartEmu (960k)" << endl;
	cout << "frz11_512: TurboFreezer 2011 CartEmu (512k)" << endl;
	return 1;
}
