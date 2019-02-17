Steps

Compile Kernel

1. download linux custom kernel

		wget ftp://ftp.riken.jp/Linux/kernel.org/linux/kernel/v4.x/linux-4.9.11.tar.gz

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

Compile RootFileSystem

1. download busybox
		
		wget https://busybox.net/downloads/busybox-1.29.0.tar.bz2

2. unzip the downloaded busybox
		
		tar xvf busybox-1.29.0.tar.bz2
	
3. move to the unzipped folder
			
		cd busybox-1.29.0

4. clean the previous builds
	
		make clean
		make distclean

5. configure default architecture
		
		make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- defconfig
		
6. enable static generation of binaries
	
		make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- menuconfig
	
	go to "settings" -> under build options check "build static binary"	
	press y to activate and save

7. compile busybox
		
		make -j 4 install
	
8. navigte to _install/ folder and create important directories
	
		cd _install
		mkdir proc sys dev etc etc/init.d

9. create etc/init.d/rcS file and enter the following shell code
		
		nano etc/init.d/rcS
			
		#!/bin/sh
		mount -t proc none /proc
		mount -t sysfs none /sys
		/sbin/mdev -s

10. Mark rcS file as executable
		
		chmod +x etc/init.d/rcS

11. Copy our Custom Memory Device Driver to filesystem (Optional)
	    ->Copy Driver *.ko to a new folder, memDriver
		
		mkdir memDriver/
		cp <path to driver files> memDriver/
		
12. create RFS image with the cpiotool
	
		find .|cpio -o --format=newc > ../rootfs.img

Running the kernel and mounting RFS with QEMU

1. create a new folder to contain image files required to boot

		mkdir src/

2. copy all the necessary files into src folder

		cp linux-4.9.11/arch/arm/boot/zImage src/
		cp linux-4.9.11/arch/arm/boot/dts/vexpress-v2p-ca9.dtb src/
		cp busybox-1.29.0/rootfs.img src/

3. navigate to src directory

		cd src/

4. boot the system with all the copied files

		qemu-system-arm -M vexpress-a9 -dtb vexpress-v2p-ca9.dtb -m 256M -kernel zImage -initrd rootfs.img -append "root=/dev/ram rdinit=/sbin/init"
