:: Comments begin with double-colons and are a good idea for documentation

set IMAGE_SOURCE="d:\Virtual Machines\Linux_Miny_LMDE6\linux_miny_lmde6.qcow2"
set ISO_IMAGE="d:\Virtual Machines\lmde-6-cinnamon-64bit.iso"

qemu-system-x86_64 ^
    -name "Alpine Linux" ^
    -smp 6 ^
    -m 8192 ^
    -vga qxl ^
    -accel whpx ^
    -rtc base=utc ^
    -drive file=%IMAGE_SOURCE%,if=virtio,format=qcow2 ^
    -boot order=cd,menu=on ^
    -device qemu-xhci ^
    -cdrom %ISO_IMAGE%
	
:: qemu-system-x86_64 ^
::     -name "Alpine Linux" ^
::     -machine type=pc-q35-6.0 ^
::     -accel tcg ^
::     -accel hax ^
::     -cpu qemu64 ^
::     -smp 4 ^
::     -m 8192 ^
::     -vga virtio ^
::     -rtc base=utc ^
::     -drive file=%IMAGE_SOURCE%,if=virtio,format=qcow2 ^
::     -drive file="alpine.qcow2",if=virtio,format=qcow2 ^
::     -boot order=cd,menu=on ^
::     -display gtk ^
::     -device virtio-vga ^
::     -nic user,id=NAT,model=virtio-net-pci,mac=02:00:00:00:00:01 ^
::     -device qemu-xhci ^
::     -device usb-tablet ^
::     -cdrom "alpine-virt-3.16.2-x86_64.iso"

echo QEMU has finished
pause
