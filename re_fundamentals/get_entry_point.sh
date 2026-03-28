#!/bin/bash

# 1. Arqumentin (fayl adının) verilib-verilmədiyini yoxla
if [ $# -ne 1 ]; then
    echo "Usage: $0 <elf_file>"
    exit 1
fi

file_name="$1"

# 2. Faylın mövcud olub-olmadığını yoxla
if [ ! -f "$file_name" ]; then
    echo "Error: File '$file_name' does not exist."
    exit 1
fi

# 3. Faylın keçərli bir ELF faylı olub-olmadığını yoxla
if ! readelf -h "$file_name" >/dev/null 2>&1; then
    echo "Error: '$file_name' is not a valid ELF file."
    exit 1
fi

# 4. readelf vasitəsilə məlumatları çıxar və dəyişənlərə mənimsət
magic_number=$(readelf -h "$file_name" | grep "Magic:" | sed 's/^ *Magic: *//')
class=$(readelf -h "$file_name" | grep "Class:" | sed 's/^ *Class: *//')
byte_order=$(readelf -h "$file_name" | grep "Data:" | sed 's/^ *Data: *//')
entry_point_address=$(readelf -h "$file_name" | grep "Entry point address:" | sed 's/^ *Entry point address: *//')

# 5. messages.sh faylını eyni mühitə daxil et (source)
if [ -f "messages.sh" ]; then
    source ./messages.sh
    # messages.sh içindəki funksiyanı çağır
    display_elf_header_info
else
    echo "Error: messages.sh file not found."
    exit 1
fi
