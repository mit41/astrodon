#!/bin/bash

set -ouex pipefail

rsync -rvK /ctx/system_files/ /

ARCH="$(rpm -E '%_arch')"
RELEASE="$(rpm -E '%fedora')"
KERNEL_VERSION="$(rpm -q kernel --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"

## Remove gnome stuff except for keyring libs
dnf -y remove gnome-* --exclude gnome-keyring,gnome-keyring-pam

## Install cosmic session instead of gnome
dnf -y install cosmic-session
