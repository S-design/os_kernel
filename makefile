#automates the build process of my os, and deffines targets like kernel.bin, iso, all.


#the default target, this runs when you type make, tells make to build the iso
all: iso

#builds kernel.bin from the kernel.c file
#compile kernel.c into object file kernel.o
#-ffreestanding -> dont assume standard C libraries
#-m32 for 32 bit architecture
#linking kernel.o into a flat binary by using linker.ld
#-T linker.ld say to use the linker script
#-m elf_i386 says to specify 32-bit ELF format
kernel.bin: kernel.c
	i686-elf-gcc -ffreestanding -m32 -c kernel.c -o kernel.o
	i686-elf-ld -T linker.ld -o kernel.bin -m elf_i386 kernel.o

#this builds the bootable .iso image with grub and makes dir structure
#grub-mkrescue packages it into simple_os.iso
iso: kernel.bin
	mkdir -p isodir/boot/grub
	cp kernel.bin isodir/boot/
	cp boot/grub/grub.cfg isodir/boot/grub/
	grub-mkrescue -o simple_os.iso isodir

#this launches the iso in QEMU emulating a 32 bit pc
run: iso
	qemu-system-i386 -cdrom simple_os.iso

# removes the build artifacts to ensure a fresh build every time
clean:
	rm -rf *.o *.bin isodir simple_os.iso
