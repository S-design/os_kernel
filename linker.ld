//controls how kernel code is arranged in memory
//entry point of my program is kernel_main

ENTRY(kernel_main)

//defines how different parts of my program are arranged in memory

SECTIONS {
    //sets the starting address to 1 MB (0x100000) which is standard for multi boot kernels
    //grib loads the kernel at 1MB mark, the start of safe memory space not used by BIOS or hardware buffers
    . = 1M;
    //puts all code (.text sections from all object files) at this address *() means include all matching sections from all files
    .text : {
        *(.text*)
    }
    //puts the all initialised global/static variables here in memory
    .data : {
        *(.data*)
    }
    //this puts all the uninitialised global/static variables here.
    //doesnt take space in file, gets zeroed out in memory at runtime
    .bss : {
        *(.bss*)
    }
}

//1.tells kernel to start at kernel_main
//2.puts the entire kernel starting at 1 MB - memory address (0x100000)
//3.organizes memory layout:
//code -> .text
//initialised data -> .data
//uninitialised data -> .bss