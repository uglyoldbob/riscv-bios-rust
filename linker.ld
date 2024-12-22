MEMORY
{
  bios (rx) : ORIGIN = 0x00010000, LENGTH = 0x1000
  sdram (!rx) : ORIGIN = 0x00800000, LENGTH = 0x800000
  ram (!rx) : ORIGIN = 0x00020000, LENGTH = 0x1000
}

SECTIONS
{
  .text :
  {
    KEEP(*(.multiboot));

    *(.text);
    *(.text.*);
    *(.got);
    *(.got.plt);
  } > bios

  .vector_table :
  {
    LONG(0x2007ffff);
    LONG(_start);
    . = ALIGN(4);
    KEEP(*(.isr_vector)) /* Startup code */
    . = ALIGN(4);
  } > bios

  .rodata : { *(.rodata) } > bios
  .rela : { *(.rela.dyn); } > bios
  .strtab : { *(.strtab); } > bios
  RAMLOAD = .;
  .strings : {
    *(.dynstr);
  } > bios
  .data : AT(RAMLOAD) { 
    *(.data);
    *(.data.*);
  } > ram
  .bss : { 
    START_OF_BSS = .;
    *(.bss);
    *(.bss.*);
    END_OF_BSS = .;
  } > ram
  .debug (NOLOAD) : {
    KEEP(*(*.debug));
  }
  /DISCARD/ :
  {
    *(.dynamic);
    *(.dynsym);
    *(.gnu.hash);
    *(.comment);
    *(.hash);
    *(.ARM.exidx);
  }
}