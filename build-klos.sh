#!/bin/bash

echo "================================"
echo " KL OS Automatic Build Script"
echo "================================"

echo "Creating ISO directories..."
mkdir -p iso/boot/grub
mkdir -p iso/live

echo "Copying kernel..."
cp rootfs/boot/vmlinuz iso/live/vmlinuz

echo "Creating compressed filesystem..."
sudo mksquashfs rootfs iso/live/filesystem.squashfs -e boot

echo "Creating GRUB config..."

cat <<EOF > iso/boot/grub/grub.cfg
set timeout=5
set default=0

menuentry "KL OS Live" {
    linux /live/vmlinuz
}
EOF

echo "Building ISO..."

xorriso -as mkisofs \
-o KL_OS.iso \
-iso-level 3 \
-full-iso9660-filenames \
-volid "KLOS" \
iso

echo ""
echo "================================"
echo "KL OS ISO CREATED"
echo "File: KL_OS.iso"
echo "================================"
