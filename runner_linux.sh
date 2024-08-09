#!/bin/sh
# Example in Bourne shell script

qemu-system-x86_64 \
    -name "Alpine Linux" \
    -machine type=pc-q35-6.0 \
    -accel tcg \
    -cpu qemu64 \
    -smp 2 \
    -m 2048 \
    -rtc base=utc \
    -drive file="alpine.qcow2",if=virtio,format=qcow2 \
    -boot order=cd,menu=on \
    -display gtk \
    -device virtio-vga \
    -nic user,id=NAT,model=virtio-net-pci,mac=02:00:00:00:00:01 \
    -device qemu-xhci \
    -device usb-tablet \
    -cdrom "alpine-virt-3.16.2-x86_64.iso"

echo "QEMU has finished. Press Enter to continue."
read throwaway