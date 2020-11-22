#!/bin/bash

# Define the version of your qcow2 images

Ver="3.4.3"

# Define the location of your qcow2 images

OrchSrcPath="~/velo343/veloorch"
GWSrcPath="~/velo343/velogw"
EdgeSrcPath="~/velo343/veloedge"

# End of Configuration

# ------------------------------

# Create template folders

mkdir /opt/unetlab/addons/qemu/template-veloorch-3.2.2
mkdir /opt/unetlab/addons/qemu/template-velogw-3.2.2
mkdir /opt/unetlab/addons/qemu/template-veloedge-3.2.2

# Copy qcow2 files into the template directory

cp $OrchSrcPath/*.qcow2 /opt/unetlab/addons/qemu/template-veloorch-3.2.2/
cp $GWSrcPath/*.qcow2 /opt/unetlab/addons/qemu/template-veloorch-3.2.2/
cp $EdgeSrcPath/*.qcow2 /opt/unetlab/addons/qemu/template-veloorch-3.2.2/

# Build each image by:
#  - symlinking the files from the template directory
#  - Creating the user-data and meta-data files including hostnames
#  - Creating ISO file including user-data and meta-data files

# Build Orchestrator Image 1

mkdir /opt/unetlab/addons/qemu/veloorch-3.4.3-01

ln /opt/unetlab/addons/qemu/template-veloorch-3.4.3/virtioa.qcow2 /opt/unetlab/addons/qemu/veloorch-3.4.3-01/virtioa.qcow2
ln /opt/unetlab/addons/qemu/template-veloorch-3.4.3/virtiob.qcow2 /opt/unetlab/addons/qemu/veloorch-3.4.3-01/virtiob.qcow2
ln /opt/unetlab/addons/qemu/template-veloorch-3.4.3/virtioc.qcow2 /opt/unetlab/addons/qemu/veloorch-3.4.3-01/virtioc.qcow2

echo -e "#cloud-config" >> /opt/unetlab/addons/qemu/veloorch-3.4.3-01/user-data
echo -e "            password: password1" >> /opt/unetlab/addons/qemu/veloorch-3.4.3-01/user-data
echo -e "            chpasswd: {expire: False} " >> /opt/unetlab/addons/qemu/veloorch-3.4.3-01/user-data
echo -e "            ssh_pwauth: True " >> /opt/unetlab/addons/qemu/veloorch-3.4.3-01/user-data
echo -e "            ssh_authorized_keys:" >> /opt/unetlab/addons/qemu/veloorch-3.4.3-01/user-data
echo -e "            " >> /opt/unetlab/addons/qemu/veloorch-3.4.3-01/user-data
echo -e "            vco:" >> /opt/unetlab/addons/qemu/veloorch-3.4.3-01/user-data
echo -e "              super_users:" >> /opt/unetlab/addons/qemu/veloorch-3.4.3-01/user-data
echo -e "                list: |" >> /opt/unetlab/addons/qemu/veloorch-3.4.3-01/user-data
echo -e "                  super@lab.local:password1" >> /opt/unetlab/addons/qemu/veloorch-3.4.3-01/user-data
echo -e "                remove_default_users: True" >> /opt/unetlab/addons/qemu/veloorch-3.4.3-01/user-data

echo instance-id: vco-01 >> /opt/unetlab/addons/qemu/veloorch-3.4.3-01/meta-data
echo local-hostname: vco-01 >> /opt/unetlab/addons/qemu/veloorch-3.4.3-01/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloorch-3.4.3-01/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloorch-3.4.3-01/user-data /opt/unetlab/addons/qemu/veloorch-3.4.3-01/meta-data

# - Build Orchestrator Image 2

mkdir /opt/unetlab/addons/qemu/veloorch-3.4.3-02

ln /opt/unetlab/addons/qemu/template-veloorch-3.4.3/virtioa.qcow2 /opt/unetlab/addons/qemu/veloorch-3.4.3-02/virtioa.qcow2
ln /opt/unetlab/addons/qemu/template-veloorch-3.4.3/virtiob.qcow2 /opt/unetlab/addons/qemu/veloorch-3.4.3-02/virtiob.qcow2
ln /opt/unetlab/addons/qemu/template-veloorch-3.4.3/virtioc.qcow2 /opt/unetlab/addons/qemu/veloorch-3.4.3-02/virtioc.qcow2

echo -e "#cloud-config" >> /opt/unetlab/addons/qemu/veloorch-3.4.3-02/user-data
echo -e "            password: password1" >> /opt/unetlab/addons/qemu/veloorch-3.4.3-02/user-data
echo -e "            chpasswd: {expire: False} " >> /opt/unetlab/addons/qemu/veloorch-3.4.3-02/user-data
echo -e "            ssh_pwauth: True " >> /opt/unetlab/addons/qemu/veloorch-3.4.3-02/user-data
echo -e "            ssh_authorized_keys:" >> /opt/unetlab/addons/qemu/veloorch-3.4.3-02/user-data
echo -e "            " >> /opt/unetlab/addons/qemu/veloorch-3.4.3-02/user-data
echo -e "            vco:" >> /opt/unetlab/addons/qemu/veloorch-3.4.3-02/user-data
echo -e "              super_users:" >> /opt/unetlab/addons/qemu/veloorch-3.4.3-02/user-data
echo -e "                list: |" >> /opt/unetlab/addons/qemu/veloorch-3.4.3-02/user-data
echo -e "                  super@lab.local:password1" >> /opt/unetlab/addons/qemu/veloorch-3.4.3-02/user-data
echo -e "                remove_default_users: True" >> /opt/unetlab/addons/qemu/veloorch-3.4.3-02/user-data

echo instance-id: vco-02 >> /opt/unetlab/addons/qemu/veloorch-3.4.3-02/meta-data
echo local-hostname: vc0-02 >> /opt/unetlab/addons/qemu/veloorch-3.4.3-02/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloorch-3.4.3-02/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloorch-3.4.3-02/user-data /opt/unetlab/addons/qemu/veloorch-3.4.3-02/meta-data

# - Build GW Image 1

mkdir /opt/unetlab/addons/qemu/velogw-3.4.3-01

ln /opt/unetlab/addons/qemu/template-velogw-3.4.3/virtioa.qcow2 /opt/unetlab/addons/qemu/velogw-3.4.3-01/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/velogw-3.4.3-01/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/velogw-3.4.3-01/user-data

echo instance-id: vcg-01 >> /opt/unetlab/addons/qemu/velogw-3.4.3-01/meta-data
echo local-hostname: vcg-01 >> /opt/unetlab/addons/qemu/velogw-3.4.3-01/meta-data

genisoimage -output /opt/unetlab/addons/qemu/velogw-3.4.3-01/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/velogw-3.4.3-01/user-data /opt/unetlab/addons/qemu/velogw-3.4.3-01/meta-data

# - Build GW Image 2

mkdir /opt/unetlab/addons/qemu/velogw-3.4.3-02

ln /opt/unetlab/addons/qemu/template-velogw-3.4.3/virtioa.qcow2 /opt/unetlab/addons/qemu/velogw-3.4.3-02/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/velogw-3.4.3-02/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/velogw-3.4.3-02/user-data

echo instance-id: vcg-02 >> /opt/unetlab/addons/qemu/velogw-3.4.3-02/meta-data
echo local-hostname: vcg-02 >> /opt/unetlab/addons/qemu/velogw-3.4.3-02/meta-data

# - Build GW Image 3

mkdir /opt/unetlab/addons/qemu/velogw-3.4.3-03

ln /opt/unetlab/addons/qemu/template-velogw-3.4.3/virtioa.qcow2 /opt/unetlab/addons/qemu/velogw-3.4.3-03/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/velogw-3.4.3-03/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/velogw-3.4.3-03/user-data

echo instance-id: vcg-03 >> /opt/unetlab/addons/qemu/velogw-3.4.3-03/meta-data
echo local-hostname: vcg-03 >> /opt/unetlab/addons/qemu/velogw-3.4.3-03/meta-data

# - Build GW Image 4

mkdir /opt/unetlab/addons/qemu/velogw-3.4.3-04

ln /opt/unetlab/addons/qemu/template-velogw-3.4.3/virtioa.qcow2 /opt/unetlab/addons/qemu/velogw-3.4.3-04/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/velogw-3.4.3-04/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/velogw-3.4.3-04/user-data

echo instance-id: vcg-04 >> /opt/unetlab/addons/qemu/velogw-3.4.3-04/meta-data
echo local-hostname: vcg-04 >> /opt/unetlab/addons/qemu/velogw-3.4.3-04/meta-data

# - Build Edge Image 1

mkdir /opt/unetlab/addons/qemu/veloedge-3.4.3-01

ln /opt/unetlab/addons/qemu/template-veloedge-3.4.3/virtioa.qcow2 /opt/unetlab/addons/qemu/veloedge-3.4.3-01/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/veloedge-3.4.3-01/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/veloedge-3.4.3-01/user-data

echo instance-id: vce-01 >> /opt/unetlab/addons/qemu/veloedge-3.4.3-01/meta-data
echo local-hostname: vce-01 >> /opt/unetlab/addons/qemu/veloedge-3.4.3-01/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloedge-3.4.3-01/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloedge-3.4.3-01/user-data /opt/unetlab/addons/qemu/veloedge-3.4.3-01/meta-data

# - Build Edge Image 2

mkdir /opt/unetlab/addons/qemu/veloedge-3.4.3-02

ln /opt/unetlab/addons/qemu/template-veloedge-3.4.3/virtioa.qcow2 /opt/unetlab/addons/qemu/veloedge-3.4.3-02/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/veloedge-3.4.3-02/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/veloedge-3.4.3-02/user-data

echo instance-id: vce-02 >> /opt/unetlab/addons/qemu/veloedge-3.4.3-02/meta-data
echo local-hostname: vce-02 >> /opt/unetlab/addons/qemu/veloedge-3.4.3-02/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloedge-3.4.3-02/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloedge-3.4.3-02/user-data /opt/unetlab/addons/qemu/veloedge-3.4.3-02/meta-data

# - Build Edge Image 3

mkdir /opt/unetlab/addons/qemu/veloedge-3.4.3-03

ln /opt/unetlab/addons/qemu/template-veloedge-3.4.3/virtioa.qcow2 /opt/unetlab/addons/qemu/veloedge-3.4.3-03/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/veloedge-3.4.3-03/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/veloedge-3.4.3-03/user-data

echo instance-id: vce-03 >> /opt/unetlab/addons/qemu/veloedge-3.4.3-03/meta-data
echo local-hostname: vce-03 >> /opt/unetlab/addons/qemu/veloedge-3.4.3-03/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloedge-3.4.3-03/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloedge-3.4.3-03/user-data /opt/unetlab/addons/qemu/veloedge-3.4.3-03/meta-data

# - Build Edge Image 4

mkdir /opt/unetlab/addons/qemu/veloedge-3.4.3-04

ln /opt/unetlab/addons/qemu/template-veloedge-3.4.3/virtioa.qcow2 /opt/unetlab/addons/qemu/veloedge-3.4.3-04/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/veloedge-3.4.3-04/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/veloedge-3.4.3-04/user-data

echo instance-id: vce-04 >> /opt/unetlab/addons/qemu/veloedge-3.4.3-04/meta-data
echo local-hostname: vce-04 >> /opt/unetlab/addons/qemu/veloedge-3.4.3-04/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloedge-3.4.3-04/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloedge-3.4.3-04/user-data /opt/unetlab/addons/qemu/veloedge-3.4.3-04/meta-data

# - Build Edge Image 5

mkdir /opt/unetlab/addons/qemu/veloedge-3.4.3-05

ln /opt/unetlab/addons/qemu/template-veloedge-3.4.3/virtioa.qcow2 /opt/unetlab/addons/qemu/veloedge-3.4.3-05/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/veloedge-3.4.3-05/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/veloedge-3.4.3-05/user-data

echo instance-id: vce-05 >> /opt/unetlab/addons/qemu/veloedge-3.4.3-05/meta-data
echo local-hostname: vce-05 >> /opt/unetlab/addons/qemu/veloedge-3.4.3-05/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloedge-3.4.3-05/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloedge-3.4.3-05/user-data /opt/unetlab/addons/qemu/veloedge-3.4.3-05/meta-data

# - Build Edge Image 6

mkdir /opt/unetlab/addons/qemu/veloedge-3.4.3-06

ln /opt/unetlab/addons/qemu/template-veloedge-3.4.3/virtioa.qcow2 /opt/unetlab/addons/qemu/veloedge-3.4.3-06/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/veloedge-3.4.3-06/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/veloedge-3.4.3-06/user-data

echo instance-id: vce-06 >> /opt/unetlab/addons/qemu/veloedge-3.4.3-06/meta-data
echo local-hostname: vce-06 >> /opt/unetlab/addons/qemu/veloedge-3.4.3-06/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloedge-3.4.3-06/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloedge-3.4.3-06/user-data /opt/unetlab/addons/qemu/veloedge-3.4.3-06/meta-data

# - Build Edge Image 7

mkdir /opt/unetlab/addons/qemu/veloedge-3.4.3-07

ln /opt/unetlab/addons/qemu/template-veloedge-3.4.3/virtioa.qcow2 /opt/unetlab/addons/qemu/veloedge-3.4.3-07/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/veloedge-3.4.3-07/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/veloedge-3.4.3-07/user-data

echo instance-id: vce-07 >> /opt/unetlab/addons/qemu/veloedge-3.4.3-07/meta-data
echo local-hostname: vce-07 >> /opt/unetlab/addons/qemu/veloedge-3.4.3-07/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloedge-3.4.3-07/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloedge-3.4.3-07/user-data /opt/unetlab/addons/qemu/veloedge-3.4.3-07/meta-data

# - Build Edge Image 8

mkdir /opt/unetlab/addons/qemu/veloedge-3.4.3-08

ln /opt/unetlab/addons/qemu/template-veloedge-3.4.3/virtioa.qcow2 /opt/unetlab/addons/qemu/veloedge-3.4.3-08/virtioa.qcow2

echo \#cloud-config >> /opt/unetlab/addons/qemu/veloedge-3.4.3-08/user-data
echo password: password1  >> /opt/unetlab/addons/qemu/veloedge-3.4.3-08/user-data

echo instance-id: vce-08 >> /opt/unetlab/addons/qemu/veloedge-3.4.3-08/meta-data
echo local-hostname: vce-08 >> /opt/unetlab/addons/qemu/veloedge-3.4.3-08/meta-data

genisoimage -output /opt/unetlab/addons/qemu/veloedge-3.4.3-08/cdrom.iso -volid cidata -joliet -rock /opt/unetlab/addons/qemu/veloedge-3.4.3-08/user-data /opt/unetlab/addons/qemu/veloedge-3.4.3-08/meta-data

# Run standard eve-ng fixpermissions script to finish

/opt/unetlab/wrappers/unl_wrapper -a fixpermissions
