# Build
building a multiboot-compliant kernel then packaging it into a bootable ISO with GRUB. Then using QEMU to run it.

# Kernel.c
the actual operating system code, containing the entry function.
writes to video memory. it is the program you want to run as an OS.

# Linker.ld
The memory layout, tells the linker where in memory to place code, data and other sections. places the kernel at (0x100000) where GRUB will then load it. It defines the entry point kernel_main and makes sure the binary is flat and simple.
Its a memory map for placing code in physical RAM.

# Makefile
This is the build automation, and automates compiling kernel.c to kernel.o
links with linker.ld to kernel.bin
packaging it with GRUB into a bootable ISO
then running the ISO with QEMU
It is a script that assembles your kernel and boots it automatically.

# grub.cfg
The GRUB boot configuration, tells grub not to wait load the kernel from /boot/kernel.bin, use multiboot protocol and execute from the entry point kernel_main.
generates bootable ISO image, it is a GRUB menue that knows where your kernel is and how to load it.

# Connections
write code in kernel.c, then run make, which compiles code into kernel.o, links it with linker.ld to make kernel.bin. creates the ISO structure and copies kernel.bin to /boot/ and grub.cfg to /boot/grub/ then uses grub-mkrescue to make simple_os.iso. 
we run 'make run' which then launches the ISO in QEMU, GRUB reads grub.cfg and loads kernel.bin into RAM. GRUB jumps to kernel_main() as defined in my binary. the kernel runs and prints "Hello My OS!" on screen.

# Summary
kernel.c -> the actual OS logic
linker.ld -> Specifies where the kernel loads in memory
grub.cfg -> tells grub how to find and load the kernel
Makefile -> automates the process, build package run.