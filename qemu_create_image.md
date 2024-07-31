## Qemu Create Virtual Image


```
	qemu-img create -f qcow2 "d:\Virtual Machines\ubuntu_18.04\ubuntu.img" 20G
	qemu-img create -f qcow2 "d:\Virtual Machines\ubuntu_18.04\ubuntu.qcow2" 100G
	qemu-img create -f vdi XP.vdi 1G
	qemu-img create -f vmdk 2000.vmdk 2G
	qemu-img create -f vhdx Server2012.vhdx 8G
	qemu-img create -f parallels Win7_32.img 16G
```


creates a qcow2 image with a maximum size of 10 GB:
```
Command:
	qemu-img create -f qcow2 /var/lib/libvirt/images/disk1.img 10G 

Output:
	Formatting '/var/lib/libvirt/images/disk1.img', fmt=qcow2
	size=10737418240 encryption=off cluster_size=65536
	lazy_refcounts=off
```

```
qemu-img info "d:\Virtual Machines\ubuntu_18.04\ubuntu2.img"

Output:
	image: d:\Virtual Machines\ubuntu_18.04\ubuntu2.img
	file format: qcow2
	virtual size: 20 GiB (21474836480 bytes)
	disk size: 192 KiB
	cluster_size: 65536
	Format specific information:
		compat: 1.1
		compression type: zlib
		lazy refcounts: false
		refcount bits: 16
		corrupt: false
		extended l2: false
	Child node '/file':
		filename: d:\Virtual Machines\ubuntu_18.04\ubuntu2.img
		protocol type: file
		file length: 192 KiB (197120 bytes)
		disk size: 192 KiB
```

```
Command:
	qemu-img resize "d:\Virtual Machines\ubuntu_18.04\ubuntu2.img" 22G

Output:
	Image resized.
```

<br/>



#### How the command works

```
    # Define variables for easy modification
    VM_NAME="my_vm"
    DISK_IMAGE_PATH="/path/to/vm_disk.img"
    DISK_SIZE="20G"
    
    # Create a disk image for the VM
    qemu-img create -f qcow2 $DISK_IMAGE_PATH $DISK_SIZE
```

The command is broken down like this:
- qemu-img
	- This is the name of the program. It is necessary for using the following command.

- create
	- This tells qemu-img that we are creating a disk image.
	- Other arguments include "dd", "info", "map", "measure", "snapshot", "rebase", and "resize". 
	- There is no documentation for these arguments for now, they will be described in more detail later.

- "-f"
	- An argument that specifies which file format we are going to be using.

- qcow2
	- The file format we are using, in this case qcow2.
	- qcow2 is the recommended since it is dynamically allocated - e.g. it only allocates space when needed, 
	- but at a (pretty much) unnoticeable speed loss. There are many other file formats, which will be listed below.

- example.img
	- This specifies the name of the image we are going to be using. 
	- It can be whatever, and have whatever extension (or none at all), it doesn't matter.

- 100M
	- This specifies the size of the virtual disk. 100M stands for 100 megabytes. 
	- Of course modern operating systems take up much more than that, so it's recommended to make it at least 30 gigabytes or more, 
	which can be done by replacing 100M with 30G. The following letters are accepted:

<br/>