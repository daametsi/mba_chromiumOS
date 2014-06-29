#script concept to automate the building process..

export BUILD_DIR=/tmp/kernel

export BOARD=???-generic

export TARGET_ARCH=???

export TOOLCHAIN=/usr/bin/x86_64-pc-linux-gnu-


#configure kernel

  #use ${BUILD_DIR} as build location
cd ../third_party/kernel/3.14
ARCH=x86 make menuconfig O=${BUILD_DIR}

  #compile kernel
mv .git .git.bak
CROSS_COMPILE=${TOOLCHAIN} ARCH=${TARGET_ARCH} make -j 8 bzImage modules O=${BUILD_DIR}
mv .git.bak .git

#build image

cd ~/truck/src/scripts

./build_image --board=${BOARD} --noenable_rootfs_verification dev

#write to flashdrive

  #currently up to the user to copy/paste the command
  
  #copy kernel to /EFI-SYSTEM/efi/boot/
  #cp ${BUILD_DIR}/arch/${TARGET_ARCH}/boot/bzImage ${USBDRIVE}/EFI-SYSTEM/efi/boot/
  #configure /EFI-SYSTEM/efi/boot/grub.cfg to boot kernel
cros flash usb:// ${BOARD}/latest
