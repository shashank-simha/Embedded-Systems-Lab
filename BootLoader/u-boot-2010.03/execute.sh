#$1 => name of the file
#$2 => name of the board ex: versatilepb(mcpu=arm926ej), vexpress-a9(mcpu=cortex-a9)
#to exit = CTRL+A and x

if [ $2 = "versatilepb" ]; then
	arm-none-eabi-gcc -c -nostdlib -mcpu=arm926ej-s $1.c -o $1.o
	arm-none-eabi-as -mcpu=arm926ej -g startup.s -o startup.o
	arm-none-eabi-ld -T linker.ld startup.o $1.o -o $1.elf
	arm-none-eabi-objcopy -O binary $1.elf $1.bin
	mkimage -A arm -C none -O linux -T kernel -d $1.bin -a 0x00100000 -e 0x00100000 $1.uimg
	cat u-boot.bin $1.uimg>flash.bin
	bootm=$(printf "0x%X\n" $(expr $(stat -c%s u-boot.bin) + 65536))
	echo "bootm "$bootm
	qemu-system-arm -M versatilepb -m 1024M -kernel flash.bin -nographic
	#execute bootm $bootm(ie; value got for bootm) in the qemu shell 

elif [ $2 = "vexpress" ]; then
	arm-linux-gnueabihf-gcc -c -mcpu=cortex-a9 $1.c -o $1.o
	arm-linux-gnueabihf-as -mcpu=cortex-a9 startup.s -o startup.o
	arm-linux-gnueabihf-ld -T linker.ld startup.o $1.o -o $1.elf
	arm-linux-gnueabihf-objcopy -O binary $1.elf $1.bin
	qemu-system-arm -M vexpress-a9 -nographic -m 1024M -kernel $1.bin

else
	echo "Invalid board type"

fi
