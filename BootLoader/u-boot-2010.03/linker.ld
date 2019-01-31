ENTRY(_Reset)
SECTIONS
{
. = 0x100000;/*for versatilepb 0x10000 for vexpress 0x60010000*/
.startup . : {startup.o(.text)}
.text : {*(.text)}
.data : {*(.data)}
.bss : {*(.bss COMMON)}
. = ALIGN(8);
. = . + 0x1000;/*4kB of stack memory*/
stack_top = .;
}
