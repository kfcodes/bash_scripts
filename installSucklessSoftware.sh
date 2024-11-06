# Download the application to the downloads folder so that I can delete it easier
mkdir ~/.sucklessSoftware
cd ~/.sucklessSoftware
# This script will download the applications and install them
# Downloads the files moves to the folder and installs each application 
git clone https://git.suckless.org/dmenu
cd dmenu
sudo make clean install
cd ..
git clone https://git.suckless.org/st
cd st
sudo make clean install
cd ..
git clone https://git.suckless.org/dwm
cd dwm
sudo make clean install
cd 
