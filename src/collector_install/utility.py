# fdisk
# mkfs DATA
# mkfs BOOT
#  write mbr

yum install -y syslinux


sfdisk -f /dev/sdb < usb_boot.sfdisk.txt

sudo mkfs -t vfat -n "BOOT" /dev/sdb1
sudo mkfs -L "DATA" /dev/sdb2

sudo dd conv=notrunc bs=440 count=1 if=/usr/share/syslinux/mbr.bin of=/dev/sdb

sudo syslinux /dev/sdb1

curl http://205.153.31.172/centos/CentOS-7-x86_64-DVD-1810.iso -o CentOS-7-x86_64-DVD-1810.iso

mkdir BOOT && sudo mount /dev/sdb1 BOOT
mkdir DATA && sudo mount /dev/sdb2 DATA
mkdir DVD && sudo mount CentOS-7-x86_64-DVD-1810.iso DVD


sudo cp DVD/isolinux/* BOOT
sudo mv BOOT/isolinux.cfg BOOT/syslinux.cfg


#  customize the apped in the syslinux.cfg
append initrd=initrd.img inst.stage2=hd:LABEL=DATA:/ ks=hd:LABEL=BOOT:/minimal.ks

cp syslinux.cfg BOOT
cp minimal.ks BOOT
