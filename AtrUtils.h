#ifndef ATRUTILS_H
#define ATRUTILS_H

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

#include <stdio.h>

namespace AtrUtils {

	// parse a 16-byte ATR header
	void ReadAtrHeader(FILE *f,
		unsigned int& numberOfSectors,
		bool& isDD,
		bool allowTruncated = false);

	void WriteAtrHeader(FILE *f,
		unsigned int numberOfSectors,
		bool isDD);
};

#endif
