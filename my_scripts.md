qemu-system-x86_64 -m 8196 -smp 6 --enable-hax -cdrom "D:\VM\linuxmint-21.3-xfce-64bit.iso" -boot menu=on -drive file="d:\VM\debian\debian.qcow2"


qemu-system-x86_64.exe -vga std -m 2048 -smp 2 -soundhw ac97 -net nic,model=e1000 -net user -cdrom android-x86_64-8.1-r1.iso -hda android.img -accel hax

-machine accel=haxm: No accelerator found

The option to enable HAXM is -accel hax


PS C:\qemu> qemu-system-x86_64 -m 8196 -smp 6 -cdrom "D:\VM\linuxmint-21.3-xfce-64bit.iso" -boot menu=on -drive file="d:\VM\debian\debian.qcow2" -machine accel=hax
qemu-system-x86_64 -accel whpx -hda .\[name].qcow2 -m 512 -net nic,model=virtio -net user -cdrom .\[name].iso -vga std -boot strict=on