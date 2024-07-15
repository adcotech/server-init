#!/bin/bash
# Create new user "adcotech" with SSH key
useradd -m -s /bin/bash adcotech
mkdir -p /home/adcotech/.ssh
cp /root/.ssh/id_ed25519.pub /home/adcotech/.ssh/authorized_keys
chown -R adcotech:adcotech /home/adcotech/.ssh

# Add user "adcotech" to sudo and docker groups
usermod -aG sudo adcotech
usermod -aG docker adcotech

# Update and upgrade packages
apt-get update -y
apt-get upgrade -y

# Enable unattended upgrades
apt-get install -y unattended-upgrades
dpkg-reconfigure --priority=low unattended-upgrades

echo "Adcotech Cloud is containerizing your server... Please wait a moment."
# Install Docker and Docker Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker adcotech
systemctl enable docker
systemctl start docker
apt-get install -y docker-compose
echo "Adcotech Cloud is installing essential packages on your server... Please wait a moment."
apt-get install -y build-essential wget curl git
echo "Adcotech Cloud is installing Homebrew on your server... Please wait a moment."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "Adcotech Cloud is installing Dust on your server... Please wait a moment."
cargo install du-dust -y
echo "Adcotech Cloud is installing CTOP on your server... Please wait a moment."
sudo apt install ctop -y
echo "Your server is now ready. Welcome aboard Adcotech Cloud! Enjoy your new fast server. "
