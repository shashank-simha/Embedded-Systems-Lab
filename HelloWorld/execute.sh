#$1 => name of the file
#$2 => name of the board ex: versatilepb(mcpu=arm926ej), vexpress-a9(mcpu=cortex-a9)
#to exit = CTRL+A and x

if [ $2 = "versatilepb" ]; then
	arm-linux-gnueabi-gcc -c -nostdlib -mcpu=arm926ej-s $1.c -o $1.o
	arm-linux-gnueabi-as -mcpu=arm926ej -g startup.s -o startup.o
	arm-linux-gnueabi-ld -T linker.ld startup.o $1.o -o $1.elf
	arm-linux-gnueabi-objcopy -O binary $1.elf $1.bin
	qemu-system-arm -M versatilepb -kernel $1.bin -nographic

elif [ $2 = "vexpress" ]; then
	arm-linux-gnueabihf-gcc -c -mcpu=cortex-a9 $1.c -o $1.o
	arm-linux-gnueabihf-as -mcpu=cortex-a9 startup.s -o startup.o
	arm-linux-gnueabihf-ld -T linker.ld startup.o $1.o -o $1.elf
	arm-linux-gnueabihf-objcopy -O binary $1.elf $1.bin
	qemu-system-arm -M vexpress-a9 -nographic -m 1024M -kernel $1.bin

else
	echo "Invalid board type"

fi
