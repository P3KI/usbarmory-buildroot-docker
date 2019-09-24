#
# Debian env to build usbarmory images
# https://github.com/inversepath/usbarmory-debian-base_image
#
#
FROM debian:9
MAINTAINER Gregor Jehle <hadez@p3ki.com>

# Combined depdencies
RUN apt-get update && apt-get install -y bc binfmt-support bzip2 fakeroot gcc gcc-arm-linux-gnueabihf git gnupg make parted qemu-user-static wget xz-utils zip debootstrap sudo dirmngr bison flex libssl-dev kmod apt-transport-https ca-certificates curl gnupg2 software-properties-common libusb-dev apt-get install -y udev pkg-config libusb-1.0-0-dev vim

# Docker-ception
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io


# IMX installer tool for writing to eMMC
RUN git clone https://github.com/boundarydevices/imx_usb_loader.git && cd imx_usb_loader && make && cd /

# Build environment for usbarmory images
RUN gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 38DBBDC86092693E && gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 87F9F635D31D7652
RUN git clone https://github.com/inversepath/usbarmory-debian-base_image.git&& cd usbarmory-debian-base_image && cat Makefile | sed 's/loop0/loop2/g' > Makefile2 && mv Makefile2 Makefile

