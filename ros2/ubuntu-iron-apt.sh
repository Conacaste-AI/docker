sudo apt update && sudo apt install -y locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
export TZ=America/Los_Angeles

sudo apt install software-properties-common -y
sudo add-apt-repository universe -y

sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

apt update
apt install -y ros-dev-tools



# Install ROS 2 from source
mkdir -p /ros2_iron/src && cd /ros2_iron/
vcs import --input https://raw.githubusercontent.com/ros2/ros2/iron/ros2.repos src

sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src -y --skip-keys "fastcdr rti-connext-dds-6.0.1 urdfdom_headers libopencv-dev" --os=ubuntu:jammy


pip3 install setuptools
# Not sure why python3.9 is installed, but it's causing issues with colcon
sudo apt autoremove python3.9* -y
cd /ros2_iron/ && colcon build --symlink-install

sudo apt clean && sudo rm -rf /var/lib/apt/lists/*