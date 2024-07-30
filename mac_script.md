#make desktop shortcut
echo -e "$(tput setaf 3)Creating Desktop shortcut...$(tput sgr 0)"
echo "[Desktop Entry]
Version=1.0
Type=Application
Name=MacOS 9.2.1 
Comment=macos 9.2.1 qemu VM
Exec=qemu-system-ppc -M mac99 -m 1000 -cpu g4 -name \"MacOS 9.2.1\" -L pc-bios -g 1024x768x32 -hda macos921.qcow2
Icon=$HOME/macos921/macos9.png
Path=$HOME/macos921
Terminal=false
StartupNotify=true" > ~/Desktop/macos9.desktop
sudo chmod +x ~/Desktop/macos9.desktop