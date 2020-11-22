#!/bin/bash

# Define the version of your qcow2 images

Ver="3.4.3"

# Define the location of your qcow2 images, place them in your home folder like below:
#
# root@eve-comm-vm:~/velo3.4.3# ls -l --recursiv
# 
#  ~/velo3.4.3/veloedge
#       virtioa.qcow2
#
#  ~/velo3.4.3/velogw
#       virtioa.qcow2
#
#  ~/velo3.4.3/veloorch
#       virtioa.qcow2
#       virtiob.qcow2
#       virtioc.qcow2

OrchSrcPath="~/velo$Ver/veloorch"
GWSrcPath="~/velo$Ver/velogw"
EdgeSrcPath="~/velo$Ver/veloedge"

# End of Configuration

# ------------------------------

# Create template folders

mkdir /opt/unetlab/addons/qemu/template-veloorch-$Ver
mkdir /opt/unetlab/addons/qemu/template-velogw-$Ver
mkdir /opt/unetlab/addons/qemu/template-veloedge-$Ver

# Copy qcow2 files into the template directory

cp $OrchSrcPath/*.qcow2 /opt/unetlab/addons/qemu/template-veloorch-$Ver/
cp $GWSrcPath/*.qcow2 /opt/unetlab/addons/qemu/template-veloorch-$Ver/
cp $EdgeSrcPath/*.qcow2 /opt/unetlab/addons/qemu/template-veloorch-$Ver/

# Build each image by:
#  - symlinking the files from the template directory
#  - Creating the user-data and meta-data files including hostnames
#  - Creating ISO file including user-data and meta-data files

# Build Orchestrator Image 1

mkdir /opt/unetlab/addons/qemu/veloorch-$Ver-01

ln /opt/unetlab/addons/qemu/template-veloorch-$Ver/virtioa.qcow2 /opt/unetlab/addons/qemu/veloorch-$Ver-01/virtioa.qcow2
ln /opt/unetlab/addons/qemu/template-veloorch-$Ver/virtiob.qcow2 /opt/unetlab/addons/qemu/veloorch-$Ver-01/virtiob.qcow2
ln /opt/unetlab/addons/qemu/template-veloorch-$Ver/virtioc.qcow2 /opt/unetlab/addons/qemu/veloorch-$Ver-01/virtioc.qcow2

echo -e "#cloud-config" >> /opt/unetlab/addons/qemu/veloorch-$Ver-01/user-data
echo -e "            password: password1" >> /opt/unetlab/addons/qemu/veloorch-$Ver-01/user-data
echo -e "            chpasswd: {expire: False} " >> /opt/unetlab/addons/qemu/veloorch-$Ver-01/user-data
echo -e "            ssh_pwauth: True " >> /opt/unetlab/addons/qemu/veloorch-$Ver-01/user-data
echo -e "            ssh_authorized_keys:" >> /opt/unetlab/addons/qemu/veloorch-$Ver-01/user-data
echo -e "            " >> /opt/unetlab/addons/qemu/veloorch-$Ver-01/user-data
echo -e "            vco:" >> /opt/unetlab/addons/qemu/veloorch-$Ver-01/user-data
echo -e "              super_users:" >> /opt/unetlab/addons/qemu/veloorch-$Ver-01/user-data
echo -e "                list: |" >> /opt/unetlab/addons/qemu/veloorch-$Ver-01/user-data
echo -e "                  super@lab.local:password1" >> /opt/unetlab/addons/qemu/veloorch-$Ver-01/user-data
echo -e "                remove_default_users: True" >> /opt/unetlab/addons/qemu/veloorch-$Ver-01/user-data

echo instance-id: vco-01 >> /opt/unetlab/addons/qemu/veloorch-$Ver-01/meta-data
echo local-hostname: vco-01 >> /opt/unetlab/addons/qemu/veloorch-$Ver-01/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloorch-$Ver-01/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloorch-$Ver-01/user-data /opt/unetlab/addons/qemu/veloorch-$Ver-01/meta-data

# - Build Orchestrator Image 2

mkdir /opt/unetlab/addons/qemu/veloorch-$Ver-02

ln /opt/unetlab/addons/qemu/template-veloorch-$Ver/virtioa.qcow2 /opt/unetlab/addons/qemu/veloorch-$Ver-02/virtioa.qcow2
ln /opt/unetlab/addons/qemu/template-veloorch-$Ver/virtiob.qcow2 /opt/unetlab/addons/qemu/veloorch-$Ver-02/virtiob.qcow2
ln /opt/unetlab/addons/qemu/template-veloorch-$Ver/virtioc.qcow2 /opt/unetlab/addons/qemu/veloorch-$Ver-02/virtioc.qcow2

echo -e "#cloud-config" >> /opt/unetlab/addons/qemu/veloorch-$Ver-02/user-data
echo -e "            password: password1" >> /opt/unetlab/addons/qemu/veloorch-$Ver-02/user-data
echo -e "            chpasswd: {expire: False} " >> /opt/unetlab/addons/qemu/veloorch-$Ver-02/user-data
echo -e "            ssh_pwauth: True " >> /opt/unetlab/addons/qemu/veloorch-$Ver-02/user-data
echo -e "            ssh_authorized_keys:" >> /opt/unetlab/addons/qemu/veloorch-$Ver-02/user-data
echo -e "            " >> /opt/unetlab/addons/qemu/veloorch-$Ver-02/user-data
echo -e "            vco:" >> /opt/unetlab/addons/qemu/veloorch-$Ver-02/user-data
echo -e "              super_users:" >> /opt/unetlab/addons/qemu/veloorch-$Ver-02/user-data
echo -e "                list: |" >> /opt/unetlab/addons/qemu/veloorch-$Ver-02/user-data
echo -e "                  super@lab.local:password1" >> /opt/unetlab/addons/qemu/veloorch-$Ver-02/user-data
echo -e "                remove_default_users: True" >> /opt/unetlab/addons/qemu/veloorch-$Ver-02/user-data

echo instance-id: vco-02 >> /opt/unetlab/addons/qemu/veloorch-$Ver-02/meta-data
echo local-hostname: vc0-02 >> /opt/unetlab/addons/qemu/veloorch-$Ver-02/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloorch-$Ver-02/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloorch-$Ver-02/user-data /opt/unetlab/addons/qemu/veloorch-$Ver-02/meta-data

# - Build GW Image 1

mkdir /opt/unetlab/addons/qemu/velogw-$Ver-01

ln /opt/unetlab/addons/qemu/template-velogw-$Ver/virtioa.qcow2 /opt/unetlab/addons/qemu/velogw-$Ver-01/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/velogw-$Ver-01/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/velogw-$Ver-01/user-data

echo instance-id: vcg-01 >> /opt/unetlab/addons/qemu/velogw-$Ver-01/meta-data
echo local-hostname: vcg-01 >> /opt/unetlab/addons/qemu/velogw-$Ver-01/meta-data

genisoimage -output /opt/unetlab/addons/qemu/velogw-$Ver-01/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/velogw-$Ver-01/user-data /opt/unetlab/addons/qemu/velogw-$Ver-01/meta-data

# - Build GW Image 2

mkdir /opt/unetlab/addons/qemu/velogw-$Ver-02

ln /opt/unetlab/addons/qemu/template-velogw-$Ver/virtioa.qcow2 /opt/unetlab/addons/qemu/velogw-$Ver-02/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/velogw-$Ver-02/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/velogw-$Ver-02/user-data

echo instance-id: vcg-02 >> /opt/unetlab/addons/qemu/velogw-$Ver-02/meta-data
echo local-hostname: vcg-02 >> /opt/unetlab/addons/qemu/velogw-$Ver-02/meta-data

# - Build GW Image 3

mkdir /opt/unetlab/addons/qemu/velogw-$Ver-03

ln /opt/unetlab/addons/qemu/template-velogw-$Ver/virtioa.qcow2 /opt/unetlab/addons/qemu/velogw-$Ver-03/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/velogw-$Ver-03/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/velogw-$Ver-03/user-data

echo instance-id: vcg-03 >> /opt/unetlab/addons/qemu/velogw-$Ver-03/meta-data
echo local-hostname: vcg-03 >> /opt/unetlab/addons/qemu/velogw-$Ver-03/meta-data

# - Build GW Image 4

mkdir /opt/unetlab/addons/qemu/velogw-$Ver-04

ln /opt/unetlab/addons/qemu/template-velogw-$Ver/virtioa.qcow2 /opt/unetlab/addons/qemu/velogw-$Ver-04/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/velogw-$Ver-04/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/velogw-$Ver-04/user-data

echo instance-id: vcg-04 >> /opt/unetlab/addons/qemu/velogw-$Ver-04/meta-data
echo local-hostname: vcg-04 >> /opt/unetlab/addons/qemu/velogw-$Ver-04/meta-data

# - Build Edge Image 1

mkdir /opt/unetlab/addons/qemu/veloedge-$Ver-01

ln /opt/unetlab/addons/qemu/template-veloedge-$Ver/virtioa.qcow2 /opt/unetlab/addons/qemu/veloedge-$Ver-01/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/veloedge-$Ver-01/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/veloedge-$Ver-01/user-data

echo instance-id: vce-01 >> /opt/unetlab/addons/qemu/veloedge-$Ver-01/meta-data
echo local-hostname: vce-01 >> /opt/unetlab/addons/qemu/veloedge-$Ver-01/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloedge-$Ver-01/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloedge-$Ver-01/user-data /opt/unetlab/addons/qemu/veloedge-$Ver-01/meta-data

# - Build Edge Image 2

mkdir /opt/unetlab/addons/qemu/veloedge-$Ver-02

ln /opt/unetlab/addons/qemu/template-veloedge-$Ver/virtioa.qcow2 /opt/unetlab/addons/qemu/veloedge-$Ver-02/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/veloedge-$Ver-02/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/veloedge-$Ver-02/user-data

echo instance-id: vce-02 >> /opt/unetlab/addons/qemu/veloedge-$Ver-02/meta-data
echo local-hostname: vce-02 >> /opt/unetlab/addons/qemu/veloedge-$Ver-02/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloedge-$Ver-02/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloedge-$Ver-02/user-data /opt/unetlab/addons/qemu/veloedge-$Ver-02/meta-data

# - Build Edge Image 3

mkdir /opt/unetlab/addons/qemu/veloedge-$Ver-03

ln /opt/unetlab/addons/qemu/template-veloedge-$Ver/virtioa.qcow2 /opt/unetlab/addons/qemu/veloedge-$Ver-03/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/veloedge-$Ver-03/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/veloedge-$Ver-03/user-data

echo instance-id: vce-03 >> /opt/unetlab/addons/qemu/veloedge-$Ver-03/meta-data
echo local-hostname: vce-03 >> /opt/unetlab/addons/qemu/veloedge-$Ver-03/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloedge-$Ver-03/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloedge-$Ver-03/user-data /opt/unetlab/addons/qemu/veloedge-$Ver-03/meta-data

# - Build Edge Image 4

mkdir /opt/unetlab/addons/qemu/veloedge-$Ver-04

ln /opt/unetlab/addons/qemu/template-veloedge-$Ver/virtioa.qcow2 /opt/unetlab/addons/qemu/veloedge-$Ver-04/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/veloedge-$Ver-04/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/veloedge-$Ver-04/user-data

echo instance-id: vce-04 >> /opt/unetlab/addons/qemu/veloedge-$Ver-04/meta-data
echo local-hostname: vce-04 >> /opt/unetlab/addons/qemu/veloedge-$Ver-04/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloedge-$Ver-04/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloedge-$Ver-04/user-data /opt/unetlab/addons/qemu/veloedge-$Ver-04/meta-data

# - Build Edge Image 5

mkdir /opt/unetlab/addons/qemu/veloedge-$Ver-05

ln /opt/unetlab/addons/qemu/template-veloedge-$Ver/virtioa.qcow2 /opt/unetlab/addons/qemu/veloedge-$Ver-05/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/veloedge-$Ver-05/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/veloedge-$Ver-05/user-data

echo instance-id: vce-05 >> /opt/unetlab/addons/qemu/veloedge-$Ver-05/meta-data
echo local-hostname: vce-05 >> /opt/unetlab/addons/qemu/veloedge-$Ver-05/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloedge-$Ver-05/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloedge-$Ver-05/user-data /opt/unetlab/addons/qemu/veloedge-$Ver-05/meta-data

# - Build Edge Image 6

mkdir /opt/unetlab/addons/qemu/veloedge-$Ver-06

ln /opt/unetlab/addons/qemu/template-veloedge-$Ver/virtioa.qcow2 /opt/unetlab/addons/qemu/veloedge-$Ver-06/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/veloedge-$Ver-06/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/veloedge-$Ver-06/user-data

echo instance-id: vce-06 >> /opt/unetlab/addons/qemu/veloedge-$Ver-06/meta-data
echo local-hostname: vce-06 >> /opt/unetlab/addons/qemu/veloedge-$Ver-06/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloedge-$Ver-06/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloedge-$Ver-06/user-data /opt/unetlab/addons/qemu/veloedge-$Ver-06/meta-data

# - Build Edge Image 7

mkdir /opt/unetlab/addons/qemu/veloedge-$Ver-07

ln /opt/unetlab/addons/qemu/template-veloedge-$Ver/virtioa.qcow2 /opt/unetlab/addons/qemu/veloedge-$Ver-07/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/veloedge-$Ver-07/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/veloedge-$Ver-07/user-data

echo instance-id: vce-07 >> /opt/unetlab/addons/qemu/veloedge-$Ver-07/meta-data
echo local-hostname: vce-07 >> /opt/unetlab/addons/qemu/veloedge-$Ver-07/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloedge-$Ver-07/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloedge-$Ver-07/user-data /opt/unetlab/addons/qemu/veloedge-$Ver-07/meta-data

# - Build Edge Image 8

mkdir /opt/unetlab/addons/qemu/veloedge-$Ver-08

ln /opt/unetlab/addons/qemu/template-veloedge-$Ver/virtioa.qcow2 /opt/unetlab/addons/qemu/veloedge-$Ver-08/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/veloedge-$Ver-08/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/veloedge-$Ver-08/user-data

echo instance-id: vce-08 >> /opt/unetlab/addons/qemu/veloedge-$Ver-08/meta-data
echo local-hostname: vce-08 >> /opt/unetlab/addons/qemu/veloedge-$Ver-08/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloedge-$Ver-08/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloedge-$Ver-08/user-data /opt/unetlab/addons/qemu/veloedge-$Ver-08/meta-data

# Run standard eve-ng fixpermissions script to finish

/opt/unetlab/wrappers/unl_wrapper -a fixpermissions
