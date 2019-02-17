Steps

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

		make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- install
	
8. navigte to _install/ folder

		cd _install

9. create RFS image with the cpiotool

		find .|cpio -o --format=newc > ../rootfs.img

10. compress the RFS image

		gzip -c rootfs.img > rootfs.img.gz
