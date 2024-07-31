## Qemu


- Creating a new virtual machine (VM) using QEMU via the command line involves several steps, 
including defining the VM's hardware characteristics, storage, network settings, and more. 

#### CLI script example for creating a new virtual machine:

```
    #!/bin/bash

    # Define variables for easy modification
    VM_NAME="my_vm"
    ISO_PATH="/path/to/your/installation.iso"
    DISK_IMAGE_PATH="/path/to/vm_disk.img"
    DISK_SIZE="20G"
    MEMORY="2048" # Memory in MB
    CPUS="2"      # Number of CPU cores

    # Create a disk image for the VM
    qemu-img create -f qcow2 $DISK_IMAGE_PATH $DISK_SIZE

    # Start the VM
    qemu-system-x86_64 \
    -name $VM_NAME \
    -enable-kvm \
    -m $MEMORY \
    -smp $CPUS \
    -hda $DISK_IMAGE_PATH \
    -cdrom $ISO_PATH \
    -boot d \
    -net nic \
    -net user \
    -vga virtio \
    -display sdl \
    -usb -device usb-tablet \
    -soundhw hda
```
<br/><br/>



### Explanation of the Script:

#### Variables:

    VM_NAME: "example_vm" - Name of the VM.
    ISO_PATH: "/path/to/installation.iso" - Path to the ISO file for the operating system installation.
    DISK_IMAGE_PATH: "/path/to/example_vm_disk.img" - Path to the disk image that will be created.
    DISK_SIZE: "20G" - Size of the virtual disk.
    MEMORY: "2048" - Amount of memory (RAM) allocated to the VM in MB.
    CPUS: "2" - Number of CPU cores allocated to the VM.

<br/>

    qemu-img create:
        Creates a new disk image with the specified size.
        qemu-img create -f qcow2 $DISK_IMAGE_PATH $DISK_SIZE
<br/>

    qemu-system-x86_64:
        Command to start the QEMU virtual machine.
        -name $VM_NAME: Sets the name of the VM.
        -enable-kvm: Enables KVM for hardware acceleration.
        -m $MEMORY: Allocates memory to the VM.
        -smp $CPUS: Allocates CPU cores to the VM.
        -hda $DISK_IMAGE_PATH: Specifies the hard disk image.
        -drive file=$DISK_IMAGE_PATH,format=qcow2: Specifies the virtual hard drive.
        -cdrom $ISO_PATH: Specifies the ISO file to use for installation.
        -boot d: Boots from the CD-ROM first.
        -net nic: Adds a network interface card.
        -net user: Uses user-mode networking.
            -netdev user,id=net0 -device e1000,netdev=net0: Configures networking using user-mode networking with an emulated e1000 network card.
        -vga virtio: Uses Virtio VGA for better graphics performance.
        -display sdl: Uses SDL for display.
        -usb -device usb-tablet: Adds USB support with a tablet device.
        -soundhw hda: Adds High Definition Audio (HDA) sound card.
<br/><br/>



#### Running the Script:

    Save the script to a file, e.g., create_vm.sh.


    Make the script executable:
        chmod +x create_vm.sh


    Run the script:
        ./create_vm.sh


- This script sets up a basic virtual machine with QEMU. 
- You can customize the parameters and options further based on your specific requirements. 
- For more detailed information, refer to the QEMU documentation and QEMU options.



```

	qemu-system-i386 \
	-device ne2k_isa,netdev=win95net0 \
	-netdev user,id=win95net0,restrict=off \
	-drive file=/var/lib/libvirt/images/win95.qcow2,format=qcow2 \
	-m 64 \
	-cpu pentium \
	-vga cirrus \
	-boot order=a \
        -drive file=/usr/share/win95/ie95.iso,media=cdrom \
        -drive file=/usr/share/win95/w95.iso,media=cdrom  \
        -drive file=/usr/share/win95/exes.iso,media=cdrom  
	#-drive file=,format=,index=0,if=floppy
	# comments
	# Basically what -cdrom does is to define where and what the cdrom image is, usful for sharing files on this VM
	# drive file basically points to the hard drive or floppy, whichever is defined.
	# drive file=.img,format=raw,index=0,if=floppy, just be sure to define the format and where the file is.
	# you can play around with this if you'd want.
```


```
    'qemu-system-x86_64 '
    f'-boot order=a -drive file={args.vm_path},format=raw,if=virtio '
    f'-nographic -kernel {args.kernel_path} '
    '-append "root=/dev/vda rw console=ttyS0 loglevel=7 '
    'raid=noautodetect" '
    f'-fsdev local,id=fs1,path={args.shared_folder},security_model=none '
    '-device virtio-9p-pci,fsdev=fs1,mount_tag=shared_folder '
    f'-fsdev local,id=fs2,path={args.kernel_headers_path},'
    'security_model=none '
    '-device virtio-9p-pci,fsdev=fs2,mount_tag=linux_headers '
    f'--enable-kvm -m {args.vm_memory} -smp {args.vm_num_cpus} -cpu host '
    f'-net nic,model=e1000 -net user,hostfwd=tcp::{args.host_ssh_port}-:22'
```


qemu-img create -f qcow2 myVirtualDisk.qcow2 20G

qemu-system-x86_64 -enable-kvm -cdrom http://archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-amd64/current/images/netboot/mini.iso

qemu-system-x86_64 -M ubuntu,accel=kvm,kernel-irqchip=split -device intel-iommu,intremap=on -smp cpus=300,maxcpus=300 ...


Create 60GB disk image for new KVM VM:
    Let us create 60GB image named ‘nixcraft-rhel8.new.image’ to store our new VM:
    export LIBGUESTFS_BACKEND=direct
    qemu-img create -f qcow2 -o preallocation=metadata $VM.new.image 60G

qemu-system-x86_64 -boot d -cdrom /path/debian.iso -m 1024 -hda /path/myvm.qcow2

sudo qemu-system-x86_64 --enable-kvm -m 1024 -hda myvm.qcow


#### Machine Type

```
A VM’s Machine Type defines the hardware layout of the VM’s virtual motherboard. You can choose between the default ```Intel 440FX``` or the ```Q35 chipset```, which also provides a virtual PCIe bus, and thus may be desired if you want to pass through PCIe hardware. Additionally, you can select a vIOMMU implementation.
```


#### Intel vIOMMU

- Intel vIOMMU specific VM requirements:
    Whether you are using an Intel or AMD CPU on your host, it is important to set intel_iommu=on in the VMs kernel parameters.

    To use Intel vIOMMU you need to set q35 as the machine type.

If all requirements are met, you can add viommu=intel to the machine parameter in the configuration of the VM that should be able to pass through PCI devices.

qm set VMID -machine q35,viommu=intel

