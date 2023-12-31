ENTRY(_start)

SECTIONS {
    . = 0x100000;  /* Location where the kernel will be loaded in memory */

    .text : {
        *(.text)
    }

    .data : {
        *(.data)
    }

    .bss : {
        *(.bss)
    }
}
