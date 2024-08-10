:: Comments begin with double-colons and are a good idea for documentation

:: qemu-system-x86_64 -m 8196 -smp 6 -enable-kvm -cdrom "D:\VM\linuxmint-21.3-xfce-64bit.iso" -boot menu=on -drive file="d:\VM\debian\debian.qcow2"
:: qemu-system-x86_64 -m 8196 -smp 6 -drive file="d:\VM\debian\debian.qcow2" -accel hax 
:: -display sdl,grab-on-hover=on,window_close=off -usb -device usb-tablet -full-screen

:: c:\qemu\qemu-system-x86_64 -m 8196 -smp 6 -drive file="d:\VM\debian\debian.qcow2" -accel hax -display gtk -device virtio-vga -device usb-table


set IMAGE_SOURCE="d:\VM\debian\debian.qcow2"
set ISO_IMAGE="D:\VM\linuxmint-21.3-xfce-64bit.iso"
set QEMU_PATH="c:\qemu"

call c:



c:\qemu\qemu-system-x86_64 ^
	-m 8192 ^
    -smp 6 ^
    -drive file=%IMAGE_SOURCE% ^
	-accel hax ^
	-rtc base=utc ^
	-display gtk

	
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
