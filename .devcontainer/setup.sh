#!/bin/bash

# Install for Standard Python (GIL)
echo "-------------------------------------------"
echo "--- Installing Standard Python Packages ---"
echo "-------------------------------------------"
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt

# Install for Freethreaded Python (No-GIL)
echo "-----------------------------------------"
echo "--- Installing No-GIL Python Packages ---"
echo "-----------------------------------------"
python3.13t -m pip install --upgrade pip
python3.13t -m pip install -r requirements-nogil.txt

echo "--- Setup Complete ---"

echo "------------------------------------------"
echo "--- Registering Gil Kernel for Jupyter ---"
echo "------------------------------------------"
# Register GIL Kernel
python3 -m ipykernel install --user --name python3-gil --display-name "Python 3.13 (GIL)"

echo "---------------------------------------------"
echo "--- Registering No-Gil Kernel for Jupyter ---"
echo "---------------------------------------------"

# Register No-GIL Kernel
python3.13t -m ipykernel install --user --name python3-nogil --display-name "Python 3.13 (No-GIL)"

echo "--- Setting up oh-my-zsh ---"

# Define the custom plugins directory
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# Clone plugins if they don't exist
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi