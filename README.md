# PulseDiag

![PulseDiag Logo](assets/logo.png)

**PulseDiag** is an advanced, bootable USB toolkit designed for IT professionals and laptop technicians. It provides a comprehensive suite of hardware diagnostics, performance testing tools, and AI-assisted troubleshooting capabilities, all integrated into a streamlined, automated reporting system.

## 🚀 Features

*   **Bootable Environment:** A lightweight, dedicated operating system for in-depth system analysis.
*   **Comprehensive Diagnostics:** Includes tools for CPU, memory, disk health (SMART), and general hardware inventory.
*   **Performance Testing:** Basic stress testing capabilities to assess system stability under load.
*   **AI-Assisted Troubleshooting:** Leverages AI to analyze diagnostic reports and provide intelligent suggestions for issue resolution. Supports both online (LLM-based) and offline (rule-based) modes.
*   **Automated Reporting:** Generates detailed, professional reports in an easy-to-read format.
*   **User-Friendly Interface:** Simple menu-driven system for quick access to diagnostic scans.

## 💻 Getting Started (For Users)

To use PulseDiag, you need to create a bootable USB drive:

1.  **Download the ISO:** Obtain the latest `smartdiag.iso` (will be renamed to `pulsediag.iso` in future releases) from the [releases page](https://github.com/HackRore/PulseDiag/releases) (or build it yourself, see Development).
2.  **Flash to USB:** Use a tool like [Rufus](https://rufus.ie/) (Windows) or [balenaEtcher](https://www.balena.io/etcher/) (Windows/macOS/Linux) to flash the ISO image to a USB drive (minimum 4GB).
3.  **Boot from USB:** Configure your target computer's BIOS/UEFI to boot from the USB drive.
4.  **Run Diagnostics:** Follow the on-screen menu to select and run diagnostic scans.
5.  **Access Reports:** Reports are saved to the `logs` directory on the USB drive.

## 🛠️ Development (For Contributors)

PulseDiag is built using `live-build` for creating the bootable ISO and a combination of Bash scripts and Python for its core functionality.

### Prerequisites

*   A Debian/Ubuntu-based system for building the ISO.
*   `live-build` package installed.
*   Python 3 and `pip`.

### Building the ISO

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/HackRore/PulseDiag.git
    cd PulseDiag
    ```
2.  **Install `live-build`:**
    ```bash
    sudo apt update
    sudo apt install -y live-build
    ```
3.  **Configure and Build:**
    ```bash
    mkdir live-build
    cd live-build
    lb config
    
    # Copy project files into the live system
    cp -r ../assets ../configs ../diagnostics ../docs ../iso ../tools ../start_diag.sh config/includes.chroot/home/user/pulsediag-os/

    # Configure packages
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
EOF

    # Setup autostart
    mkdir -p config/includes.chroot/etc/xdg/autostart
    cat <<EOF > config/includes.chroot/etc/xdg/autostart/pulsediag.desktop
[Desktop Entry]
Name=PulseDiag OS
Exec=bash /home/user/pulsediag-os/start_diag.sh
Type=Application
Terminal=false
EOF

    # Build the ISO
    sudo lb build
    ```
    The generated ISO will be `live-image-amd64.hybrid.iso` in the `live-build` directory.

### AI Troubleshooter Development

The `ai_troubleshooter.py` script uses Python 3. If you're using a cloud-based AI model, you may need to install the `requests` library:

```bash
pip install requests
```

## 📄 Licensing

PulseDiag is open-source software licensed under the MIT License. The diagnostic tools included are licensed under their respective terms.

---

*Built by HackRore (Ravindra Ahire).*
