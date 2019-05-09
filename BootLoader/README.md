Steps

1. download u-boot (bootloader)

		wget ftp://ftp.denx.de/pub/u-boot/u-boot-2010.03.tar.bz2

2. unzip the downloaded bootloader

		tar -xjf  u-boot-2010.03.tar.bz2
	
3. navigate to the unzipped folder

		cd u-boot-2010.03

4. Exoport Environment variables
	
		export ARCH=arm
		export CROSS_COMPILE=arm-none-eabi-
		
	Note: If you are using arm-linux-gnueabi- toolchain, use appropriate version to avoid colored LED errors
		
5. clean the previous builds
		
		make clean
		make distclean		
		
6. make board config
		
		make versatilepb_config

7. compile the bootloader

		make -j 2 all
		
8. create and compile startup, linker and application files
		arm-none-eabi-gcc -c -nostdlib -mcpu=arm926ej-s hello.c -o hello.o
		arm-none-eabi-as -mcpu=arm926ej -g startup.s -o startup.o
		arm-none-eabi-ld -T linker.ld startup.o hello.o -o hello.elf
		arm-none-eabi-objcopy -O binary hello.elf hello.bin
		mkimage -A arm -C none -O linux -T kernel -d hello.bin -a 0x00100000 -e 0x00100000 hello.uimg
		
9. create a single binary file with application and u-boot binaries
		cat u-boot.bin hello.uimg > flash.bin

10. check the starting address of application
		printf "0x%X\n" $(expr $(stat -c%s u-boot.bin) + 65536)

11. run bootloader with application
		qemu-system-arm -M versatilepb -m 1024M -kernel flash.bin -nographic

12. Load the application (Enter the bootm value in qemu terminal)
		bootm [address]
