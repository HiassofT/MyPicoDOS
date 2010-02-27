/*
   AtrUtils - misc code to access ATR files

   Copyright (C) 2006 Matthias Reichl <hias@horus.com>

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

#include "AtrUtils.h"
#include "Error.h"
#include "AtariDebug.h"

void AtrUtils::ReadAtrHeader(FILE* f,
	unsigned int& numberOfSectors,
	bool& isDD,
	bool allowTruncated)
{
	Assert(f);

	unsigned char hdr[16];
	if (fread(hdr, 1, 16, f) != 16) {
		throw ErrorObject("error reading ATR-header");
	}
	if ( (hdr[0] != 0x96) || (hdr[1] != 0x02) ) {
		throw ErrorObject("not an ATR-Image");
	}

	int sectSize = ((size_t) hdr[4]) + (((size_t) hdr[5])<<8);
	long imgSize = ( ((size_t) hdr[2]) + (((size_t) hdr[3])<<8) +
		(((size_t) hdr[6])<<16) + (((size_t) hdr[7])<<24) ) << 4;

	long fileSize;

	if (fseek(f, 0L, SEEK_END) != 0) {
		throw ErrorObject("seeking to end of file failed");
	}

	fileSize = ftell(f);
	Assert(fileSize >= 16);

	if (fileSize < imgSize + 16) {
		if (!allowTruncated) {
			throw ErrorObject("truncated ATR file");
		}
		// fix...
		imgSize = fileSize - 16;
	}

	if (sectSize == 128) {
		isDD = false;
		numberOfSectors = imgSize / 128;
	} else if (sectSize == 256) {
		isDD = true;
		if (imgSize <= 384) {
			numberOfSectors = imgSize / 128;
		} else {
			numberOfSectors = (imgSize + 384) / 256;
		}
	} else {
		goto illegal_image;
	}

	if (numberOfSectors == 0) {
		goto illegal_image;
	}

	if (fseek(f, 16L, SEEK_SET) != 0) {
		throw ErrorObject("cannot seek to start of data");
	}
	return;

illegal_image:
	throw ErrorObject("illegal ATR image");
}

void AtrUtils::WriteAtrHeader(FILE *f,
	unsigned int numberOfSectors,
	bool isDD)
{
	Assert(f);
	if (numberOfSectors == 0 || numberOfSectors > 65535) {
		throw ErrorObject("illegal number of sectors");
	}

	unsigned char hdr[16];
	memset(hdr, 0, 16);

	hdr[0] = 0x96;
	hdr[1] = 0x02;

	long len;
	if (isDD) {
		hdr[4] = 0;
		hdr[5] = 1;
		if (numberOfSectors > 3) {
			len = 384 + 256 * (numberOfSectors - 3);
		} else {
			len = 128 * numberOfSectors;
		}
	} else {
		hdr[4] = 128;
		hdr[5] = 0;
		len = 128 * numberOfSectors;
	}
	len >>= 4;
	hdr[2] = len & 0xff;
	hdr[3] = (len >> 8) & 0xff;
	hdr[6] = (len >> 16) & 0xff;
	hdr[7] = (len >> 24) & 0xff;

	if (fwrite(hdr, 1, 16, f) != 16) {
		throw ErrorObject("error writing ATR header");
	}
}
