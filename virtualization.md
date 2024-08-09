## Supported Accelerators


- https://www.qemu.org/docs/master/system/introduction.html#virtualisation-accelerators


| Accelerator                           |      Host OS                         |  Host Architectures                              |
|---------------------------------------|:------------------------------------:|:-------------------------------------------------|
| KVM                                   | Linux                                | Arm (64 bit only), MIPS, PPC, RISC-V, s390x, x86 |
| Xen                                   | Linux (as dom0)                      | Arm, x86                                         |
| Hypervisor Framework (hvf)            | MacOS                                | x86 (64 bit only), Arm (64 bit only)             |
| Windows Hypervisor Platform (whpx)    | Windows                              | x86                                              |
| NetBSD Virtual Machine Monitor (nvmm) | NetBSD                               | x86                                              |
| Tiny Code Generator (tcg)             | Linux, other POSIX, Windows, MacOS   | Arm, x86, Loongarch64, MIPS, PPC, s390x, Sparc64 |



| Options       | Description                                                                                              |
| ------------- | -------------------------------------------------------------------------------------------------------- | 
| Machine       | Define the machine type, amount of memory etc                                                                                                                                             |   
| CPU           | Type and number/topology of vCPUs. Most accelerators offer a host cpu option which simply passes through your host CPU configuration without filtering out any features.                  |  
| Accelerator   | This will depend on the hypervisor you run. Note that the default is TCG, which is purely emulated, so you must specify an accelerator type to take advantage of hardware virtualization. |  
| Devices       | Additional devices that are not defined by default with the machine type.                                                                                                                 | 
| Backends      | Backends are how QEMU deals with the guest’s data, for example how a block device is stored, how network devices see the network or how a serial device is directed to the outside world. | 
| Interfaces    | How the system is displayed, how it is managed and controlled or debugged.                                                                                                                |                                                                                                                     
| Boot          | How the system boots, via firmware or direct kernel boot.                                                                                                                                 |    




C:\windows\system32>bcdedit
C:\windows\system32>sc query aehd
C:\windows\system32>systeminfo
C:\windows\system32>bcdedit /set hypervisorlaunchtype off
C:\windows\system32>C:\Users\uia66114\AppData\Local\Android\Sdk\emulator\emulator -accel-check
C:\windows\system32>emulator -accel-check
C:\windows\system32>sc query intelhaxm



The option to enable HAXM is -accel hax
-accel hax
-accel tcg
-accel hvf
-accel whpx
-boot -enable-hax




### Restrictions

VM acceleration has the following restrictions:

    You can't run a VM-accelerated emulator inside another VM, such as a VM hosted by VirtualBox, VMWare, or Docker. 
    You must run a VM-accelerated emulator directly on your host computer.
    
    
    
    
First, make sure your host system meets the requirements of HAXM:

    - An Intel CPU that supports Intel VT-x with Extended Page Tables (EPT).
        Intel CPUs that do not support the said feature are almost extinct now. If you have a Core i3/i5/i7, you should be good to go.
    - Windows 7 or later.
        HAXM works on both 32-bit and 64-bit versions of Windows. For the rest of this tutorial, I’ll assume you are running 64-bit Windows, which is far more popular than 32-bit nowadays.

