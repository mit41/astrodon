#!/bin/bash

set -ouex pipefail

rsync -rvK /ctx/system_files/ /

ARCH="$(rpm -E '%_arch')"
RELEASE="$(rpm -E '%fedora')"
KERNEL_VERSION="$(rpm -q kernel --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"

# TODO: switch to official packages after beta ends
## Install cosmic related stuff
dnf -y copr enable ryanabx/cosmic-epoch

## Remove gnome session
dnf -y remove gnome-session

## Install cosmic session instead of gnome
dnf -y install cosmic-session

dnf -y copr disable ryanabx/cosmic-epoch
