Steps

1. download linux custom kernel

		wget ftp://ftp.riken.jp/Linux/kernel/v4.x/linux-4.9.11.tar.gz

2. unzip the downloaded kernel

		tar xvfs linux-4.9.11.tar.gz
	
3. navigate to the unzipped folder

		cd linux-4.9.11/

4. clean the previous builds
		
		make clean
		make distclean

5. Export architecture config
		
		export ARCH=arm
		export CROSS_COMPILE=arm-linux-gnueabi-
		
6. make board config
		
		make vexpress_defconfig

7. activate Allow old ABI binaries to run with this kernel
		
		make menuconfig
			-> Kernel features
				-> Allow old ABI binaries to run with this kernel

	press y to activate and save
	

8. compile the kernel

		make -j 2 all
		
9. navigte to /linux-4.9.11/arch/arm/boot

		cd linux-4.9.11/arch/arm/boot

10. run kernel without any application

		qemu-system-arm -M vexpress-a9 -dtb ./dts/vexpress-v2p-ca9.dtb -kernel zImage -append "console=ttyAMA0" -nographic

	You should get kernel panic error

11. create hello.c(application) in the same folder

		nano hello.c

12. compile and install application

		arm-linux-gnueabihf-gcc -static hello.c -o hello
		echo hello| cpio -o --format=newc > initramfs
		cpio -t < initramfs
		
13. run kernel with application

		qemu-system-arm -M vexpress-a9 -dtb ./dts/vexpress-v2p-ca9.dtb -kernel zImage -initrd initramfs -append "rdinit=/hello console=ttyAMA0" -nographic

	After the execution of the application, kernel panic error occurs.
	If the application involves infinite loop, the kernel keeps on executing it
			
