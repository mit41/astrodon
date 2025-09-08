#!/bin/bash

set -ouex pipefail

## Install cosmic related stuff
dnf -y copr enable ryanabx/cosmic-epoch

## We just install cosmic session, because we run it alongside gnome for now
dnf -y install cosmic-session

dnf -y copr disable ryanabx/cosmic-epoch
