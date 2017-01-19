# LoS

Second atempt to build a BootLoader and a Kernel in C/C++.

## BootLoader

### [Jan. 18th] 
* BootLoader running in 16-bits mode.
* BootLoader is now able to print messages.
* Line Break & Return implemented

### Build - Raw Bin

```
nasm bootloader/bootloader.asm -f bin -o bootloader/bootloader.bin
```

```
dd if=bootloader/bootloader.bin bs=512 of=bootloader/bootloader-vm.img
```

### Build - ELF32

```
nasm bootloader/bootloader-elf.asm -f elf -o bootloader/bootloader-elf.o           
```

```
g++ -c kernel/kernel.cpp -o kernel/kernel.o -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti 
```

```
g++ -T linker.ld -o LoS.bin -ffreestanding -O2 -nostdlib bootloader/bootloader-elf.o kernel/kernel.o -lgcc -nostartfiles -g
```