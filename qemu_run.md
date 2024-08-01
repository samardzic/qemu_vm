## Qemu RUN image

```
qemu-system-x86_64 -enable-kvm -cdrom "D:\Virtual Machines\lmde-6-cinnamon-64bit.iso" -boot menu=on -drive file="d:\Virtual Machines\ubuntu_18.04\ubuntu.img" -m 8G
qemu-system-x86_64 -cdrom "D:\Virtual Machines\lmde-6-cinnamon-64bit.iso" -boot menu=on -drive file="d:\Virtual Machines\ubuntu_18.04\ubuntu.img" -m 8G

qemu-system-x86_64 -m 1G -smp 2 -boot order=dc -hda ubuntu20.img -cdrom "e:\ubuntu-20.04.3-desktop-amd64.iso"
```

```
exec qemu-system-x86_64 \
 -enable-kvm -cpu host -m 4G \
 -drive file=win10.qcow2,if=virtio \
 -device virtio-tablet \
 -rtc base=localtime \
 -net nic,model=virtio-net-pci -net user,hostname=win10 \
 -monitor stdio \
 -name "win10" \
 -usb -device usb-ehci -device usb-host,vendorid=0x091e \
 -display gtk,grab-on-hover=on
 ```
 
 
- enable-kvm -cpu host -m 4G
	- This enables the KVM virtualization support and passthrough the CPU specs. Note this only creates one cpu in the Virtual environment. In addition the system will have 4gb of memory.
- drive file=win10.qcow2,if=virtio
	- Very important to mount your drive image!
- device virtio-tablet
	- The virtio-tablet is needed if you wish the virtual window to release the keyboard/mouse when you move the mouse out of the window. Otherwise you have to use Ctrl-Alt-g (huge pain)
- rtc base=localtime
    - This is will format the virtual real time clock so Windows will get the correct time.
- net nic,model=virtio-net-pci -net user,hostname=win10
    - Networking is pretty basic with a simple NAT setup.
- monitor stdio
    - The QEMU control console will be launched from the same terminal this script runs from.
- name “win10”
    - win10 will be displayed at the top of the virtual window.
- usb -device usb-ehci -device usb-host,vendorid=0x091e
    - This is the USB pass-thru. For some reason USB 3 wouldn’t work and I had to define a USB 2 virtual device to host the pass through. It is critical to define the USB hub device BEFORE the pass-thru definitions. The vendorid allows Windows 10 to capture any Garmin device plugged into the host machine (more below).
- display gtk,grab-on-hover=on
    - A very important undocumented feature! When you move the mouse into the virtual window it auto-magically captures the keyboard!
 
 <br/>
 
 ```
 win10.sh
 ==========
 
 #!/bin/sh
	exec qemu-system-x86_64 \
	 -enable-kvm -cpu host -m 4G \
	 -drive file=win10.qcow2,if=virtio \
	 -device virtio-tablet \
	 -rtc base=localtime \
	 -net nic,model=virtio-net-pci -net user,hostname=win10 \
	 -monitor stdio \
	 -name "win10" \
	 -usb -device usb-ehci -device usb-host,vendorid=0x091e \
	 -display gtk,grab-on-hover=on \
	 "$@"
 ```
 
 ```
 Boot Windows 10 Installation:
 ==============================
 
 ./win10.sh -boot d -drive file=win10cd.iso,media=cdrom -drive file=virtio-win.iso,media=cdrom
 ```
 
 
 
 
 ```
 start "QEMU" "C:\Program Files\qemu\qemu-system-x86_64w.exe" -drive file=void.musl.img,index=0,media=disk,format=raw -m 2G -L Bios -usbdevice mouse -usbdevice keyboard -boot menu=on -rtc base=localtime,clock=host -parallel none -serial none -name void_musl -no-acpi -no-hpet -no-reboot -device e1000,netdev=user.0 -netdev user,id=user.0,hostfwd=tcp::2222-:22
 ```
 
 
 ```
start "QEMU" "C:\Program Files\qemu\qemu-system-x86_64.exe" ^
-drive file=alpine.img,index=0,media=disk,format=raw ^
-cdrom alpine-virt-3.14.2-x86_64.iso -m 128 -L Bios ^
-usbdevice mouse -usbdevice keyboard -boot menu=on ^
-rtc base=localtime,clock=host -parallel none -serial none -name alpine ^
-no-acpi -no-hpet -no-reboot 
 ```
 
 
### KVM
 
#### KVM enable
```
qemu-system-x86_64 -enable-kvm
```


#### KVM disable
 
- If we want to disable KVM we can use this CLI switch:

```
Disable KVM
$ qemu-kvm --help | grep no-kvm

-no-kvm disable KVM hardware virtualization
-no-kvm-irqchip disable KVM kernel mode PIC/IOAPIC/LAPIC
-no-kvm-pit disable KVM kernel mode PIT
-no-kvm-pit-reinjection

```

### QEMU complex commands

```
qemu-system-arm -m 1024 -cpu cortex-a57 -M virt -nographic -pflash flash0.img -pflash flash1.img -drive if=none,file=xenial-server-cloudimg-arm64-uefi1.img,id=hd0 -device virtio-blk-device,drive=hd0 -netdev type=tap,id=net0 -device virtio-net-device,netdev=net0,mac=$randmac

qemu-system-arm -m 1024 -cpu cortex-a57 -M virt -nographic -drive file=flash0.img,format=raw,if=pflash -drive file=flash1.img,format=raw,if=pflash -drive if=none,file=xenial-server-cloudimg-arm64-uefi1.img,id=hd0 -device virtio-blk-device,drive=hd0 -device virtio-net-device,netdev=net0,mac=$randmac -netdev type=tap,id=net0

qemu-system-x86_64 -drive file=virtualdebian.img -enable-kvm -vga virtio -device virtio-serial-pci -spice unix,addr=/tmp/vm_spice.socket,disable-ticketing -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 -chardev spicevmc,id=spicechannel0,name=vdagent

qemu-system-x86_64 -m 8196 -M q35,accel=kvm,kernel-irqchip=split -cpu host -smp 8 -drive file=~/qemu/ubuntu-18.04.2-desktop-amd64.img.qcow2,format=qcow2 -vnc :5 -net nic -net user,hostfwd=tcp::2222-:22 -device intel-iommu,intremap=on  **-vga cirrus**

```