#!/bin/bash

set -ouex pipefail

rsync -rvK /ctx/system_files/ /

ARCH="$(rpm -E '%_arch')"
RELEASE="$(rpm -E '%fedora')"
KERNEL_VERSION="$(rpm -q kernel --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"

## Install tuxedo drivers
# TODO: Remove this once https://github.com/ublue-os/akmods/pull/329 is merged
dnf -y copr enable gladion136/tuxedo-drivers-kmod
dnf -y install akmods \
    "akmod-tuxedo-drivers-*.fc${RELEASE}.${ARCH}"

akmods --force --kernels "${KERNEL_VERSION}" --kmod "tuxedo-drivers-kmod"

for file in /usr/lib/modules/${KERNEL_VERSION}/extra/tuxedo-drivers/*.ko.xz; do
    modinfo "$file" > /dev/null \
    || (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)
done

userdel akmods
dnf -y remove akmods
dnf -y copr disable gladion136/tuxedo-drivers-kmod

## Install cosmic related stuff
dnf -y copr enable ryanabx/cosmic-epoch

## We just install cosmic session, because we run it alongside gnome for now
dnf -y install cosmic-session

dnf -y copr disable ryanabx/cosmic-epoch
