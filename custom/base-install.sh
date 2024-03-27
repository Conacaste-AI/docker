# Set up steps
apt update

# Clone repositories
git clone git@github.com:git@github.com:Conacaste-AI/robocar.git
make vsc-import


make rosdep-install

# Delete apt cache
apt clean && rm -rf /var/lib/apt/lists/*