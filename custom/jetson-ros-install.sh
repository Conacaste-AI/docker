# Newer cmake
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | sudo apt-key add -
sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main'
sudo apt update

# Install dependencies
sudo apt install cmake -y
sudo apt install libwebsocketpp-dev nlohmann-json3-dev -y
sudo apt install libboost-python-dev -y
sudo apt install libpcl-dev -y
sudo apt-get install libgps-dev -y

# Install dependencies for depthai-ros
sudo wget -qO- https://raw.githubusercontent.com/luxonis/depthai-ros/main/install_dependencies.sh | sudo bash

# Install Livox SDK
git clone https://github.com/Livox-SDK/Livox-SDK2.git
cd Livox-SDK2 && mkdir build
cd build && cmake ..
make -j
sudo make install
cd ../../ && rm -rf Livox-SDK2

# Delete apt cache
apt clean && rm -rf /var/lib/apt/lists/*