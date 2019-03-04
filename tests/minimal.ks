install
lang en_US.UTF-8
keyboard us
timezone America/New_York --isUtc
auth --useshadow --enablemd5
selinux --disabled
firewall --disabled
services --enabled=NetworkManager,sshd
eula --agreed
ignoredisk --only-use=sdb
reboot
text
network --bootproto=static --device=eno1 --gateway=205.153.31.1 --ip=205.153.31.182 --nameserver=205.153.31.6 --netmask=255.255.255.0 --activate
network --hostname=PROD01-ZDEL-TEST-001
bootloader --location=mbr
zerombr
clearpart --all --initlabel --drives=sdb
part /boot --fstype xfs --size=400
#  the ondisk fixed a problem with disk selection saying nothign was selected
part pv.01 --size=1 --grow --ondisk=sdb
volgroup root_vg pv.01
logvol / --fstype xfs --name=root_lv --vgname=root_vg --size=47683
logvol swap  --fstype="swap" --size=4096 --name=swap_lv --vgname=root_vg

rootpw --iscrypted $6$3t0WZfXSz/x7STQa$.UXWN7W8xgj3.wf4X7e6UiOPMRGkKm9jhfLSmIspZ9eQlAUrG.1GWEzqvABtn.kS4rPcQAfbZJXX8jJV55clm/

%packages --nobase --ignoremissing
@core
%end
