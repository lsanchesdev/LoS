# LoS

Second atempt to build a BootLoader and a Kernel in C/C++.

## BootLoader

### [Jan. 18th] 
* BootLoader running in 16-bits mode.
* BootLoader is now able to print messages.

### Build

```
nasm bootloader/bootloader.asm -f bin -o bootloader/bootloader.bin
```

```
dd if=bootloader/bootloader.bin bs=512 of=bootloader/bootloader-vm.img
```