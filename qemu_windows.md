## Qemu windows specific


### KVM

- KVM is short for Kernel-based Virtual Machine. 
- It's for Linux only and its not available for Windovs.
- does not install on a windows system, because it is a linux kernel module.
<br>

- You can use the similar solution - HAXM. 
- HAXM is supported by Windows 7 (32/64) or higher. You can get details from here: https://github.com/intel/haxm



- If you have used QEMU on Linux, you have probably enjoyed the performance boost brought by KVM
The same VM runs a lot faster when you launch QEMU with the ```-accel kvm (or -enable-kvm)``` option, thanks to hardware-assisted virtualization. 
On Windows, you can achieve a similar speed-up with ```-accel hax (or -enable-hax)```, after completing a one-time setup process.

<br/>

### Intel HAXM

- https://github.com/intel/haxm

- On Windows, you can achieve a similar speed-up with ```-accel hax (or -enable-hax)```, after completing a one-time setup process.

- Unfortunately HAXM does not work with Ryzen CPUs. Hyper-V is required.

- https://developer.android.com/studio/emulator_archive

<br/>


### Option for KVM on windows for AMD

- Android Emulator hypervisor driver for AMD Processors

- Google ported KVM to Windows. The name is misleading. 
- http://github.com/google/Android-emulator-hypervisor-driver-for-amd-processors
- https://github.com/google/android-emulator-hypervisor-driver


#### Prerequisite:

    CPU has virtualization extension and BIOS has NOT disabled the extension.
    Hyper-V must be disabled. Refer to this page for more information.



### Check HAXM


- To verify that Intel HAXM is running, open a Command Prompt window with administrator privileges (Run as Administrator) 
  and execute the following command:

```
    PS C:\Build\qemu_vm\Install> sc query intelhaxm

    SERVICE_NAME: intelhaxm
            TYPE               : 1  KERNEL_DRIVER
            STATE              : 1  STOPPED
            WIN32_EXIT_CODE    : 31  (0x1f)
            SERVICE_EXIT_CODE  : 0  (0x0)
            CHECKPOINT         : 0x0
            WAIT_HINT          : 0x0
```

- For Android:

```
    PS C:\Users\uia66114\AppData\Local\Android\Sdk\emulator> emulator -accel-check
    accel: 15
    Please disable Hyper-V before using the Android Emulator.  
    Start a command prompt as Administrator, run 'bcdedit /set hypervisorlaunchtype off', reboot.
    accel
```