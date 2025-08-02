# SmartDiag OS Installation Guide

This guide explains how to create a bootable SmartDiag OS USB drive.

## Prerequisites

*   A USB drive with at least 4GB of storage.
*   The SmartDiag OS ISO file.
*   A tool to create a bootable USB drive, such as [Rufus](https://rufus.ie/) or [balenaEtcher](https://www.balena.io/etcher/).

## Installation

1.  Download the SmartDiag OS ISO file.
2.  Use your chosen tool to flash the ISO file to your USB drive.
3.  Boot your computer from the USB drive.

## Building the ISO (for developers)

This section outlines the process for building the `smartdiag.iso` from scratch using `live-build`. This is an advanced process for developers who want to customize the OS.

### 1. Setting up the Build Environment

You will need a Debian or Ubuntu-based system to build the ISO.

```bash
# Install live-build
sudo apt-get update
sudo apt-get install live-build

# Create a directory for the build
mkdir live-build
cd live-build
```

### 2. Configuring the Live System

Now, you'll configure the specifics of the live system.

```bash
# Start a new configuration
lb config

# Configure the packages to be installed
# This includes a minimal desktop environment (LXDE), the diagnostic tools, and other utilities.
cat <<EOF > config/package-lists/my.list.chroot
lxde-core
lightdm
zenity
pandoc
texlive-xetex
smartmontools
lm-sensors
memtester
neofetch
inxi
glxinfo
lshw
hwinfo
gparted
partclone
testdisk
foremost
# Add any other tools you need
EOF

# Copy the SmartDiag OS scripts and assets into the live system
mkdir -p config/includes.chroot/home/user/smartdiag-os
cp -r ../smartdiag-os/* config/includes.chroot/home/user/smartdiag-os/
```

### 3. Setting up Autostart

To automatically launch the SmartDiag GUI on boot, you'll need to create a desktop entry for it.

```bash
# Create the autostart directory
mkdir -p config/includes.chroot/etc/xdg/autostart

# Create the desktop entry
cat <<EOF > config/includes.chroot/etc/xdg/autostart/smartdiag.desktop
[Desktop Entry]
Name=SmartDiag OS
Exec=bash /home/user/smartdiag-os/start_diag.sh
Type=Application
Terminal=false
EOF
```

### 4. Building the ISO

Now you are ready to build the ISO.

```bash
# Build the ISO
sudo lb build
```

After the build process is complete, you will find the `live-image-amd64.hybrid.iso` file in the `live-build` directory. This is your `smartdiag.iso`.

### 5. Customizing the Build

You can further customize the build by modifying the files in the `config` directory. For example, you can change the bootloader, add more packages, or change the desktop environment. Refer to the [live-build manual](https://live-team.pages.debian.net/live-manual/html/live-manual/index.en.html) for more information.
