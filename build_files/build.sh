#!/bin/bash

set -ouex pipefail

### Install packages
dnf -y install @cosmic-desktop
