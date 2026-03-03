#!/bin/bash
set -euo pipefail

# -----------------------------------
# Install prerequisites
# -----------------------------------
echo "Installing prerequisites..."
apt update
apt install -y \
    gnupg \
    dirmngr \
    ca-certificates \
    curl \
    apt-transport-https

# -----------------------------------
# Import the GnuPG.org repo signing key
# -----------------------------------
echo "Importing GnuPG.org repository signing key..."
curl -fsSL https://repos.gnupg.org/deb/gnupg/trixie-devel/gnupg-signing-key.gpg \
    | gpg --dearmor --yes \
    | sudo tee /usr/share/keyrings/gnupg-org-keyring.gpg > /dev/null

# Make key readable by all so APT can use it
chmod a+r /usr/share/keyrings/gnupg-org-keyring.gpg

# -----------------------------------
# Add the upstream GnuPG repository
# -----------------------------------
echo "Adding GnuPG.org upstream repository..."
cat <<EOF | sudo tee /etc/apt/sources.list.d/gnupg-org.list
deb [signed-by=/usr/share/keyrings/gnupg-org-keyring.gpg] https://repos.gnupg.org/deb/gnupg/trixie-devel/ trixie main
EOF

# -----------------------------------
# Update APT and install GnuPG
# -----------------------------------
echo "Updating package lists..."
apt update

echo "Installing latest GnuPG from upstream..."
apt install -y gnupg2 gpg gpg-agent scdaemon

# -----------------------------------
# Restart GPG related services
# -----------------------------------
echo "Restarting any existing GPG agent processes..."
gpgconf --kill all || true

# -----------------------------------
# Report version
# -----------------------------------
echo "GnuPG installation complete! Version now installed:"
gpg --version
