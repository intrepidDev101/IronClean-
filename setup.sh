#!/bin/bash

# IronClean Setup Script
# =====================================================

# Program name and location
PROGRAM_NAME="ironcl.sh"
PROGRAM_DIR="/usr/local/bin"
PROGRAM_PATH="$PROGRAM_DIR/$PROGRAM_NAME"
CONFIG_FILE="$HOME/.ironclean.conf"

# Display ASCII Art and Introduction
show_banner() {
    echo -e "\e[1;35m"
    echo "██╗██████╗  ██████╗ ███╗   ██╗ ██████╗██╗     ███████╗ █████╗ ███╗   ██╗    "
    echo "██║██╔══██╗██╔═══██╗████╗  ██║██╔════╝██║     ██╔════╝██╔══██╗████╗  ██║    "
    echo "██║██████╔╝██║   ██║██╔██╗ ██║██║     ██║     █████╗  ███████║██╔██╗ ██║    "
    echo "██║██╔══██╗██║   ██║██║╚██╗██║██║     ██║     ██╔══╝  ██╔══██║██║╚██╗██║    "
    echo "██║██║  ██║╚██████╔╝██║ ╚████║╚██████╗███████╗███████╗██║  ██║██║ ╚████║    "
    echo "╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝    "
    echo -e "\e[1;33m              The Shield of Your System! ⚔️\e[0m"
}

# Check if user has sudo permissions
check_sudo() {
    if [ "$(id -u)" -ne 0 ]; then
        echo -e "\e[1;31m[ERROR] This script requires sudo privileges.\e[0m"
        exit 1
    fi
}

# Install the program globally
install_program() {
    echo -e "\e[1;32mInstalling IronClean globally...\e[0m"
    cp "$PROGRAM_NAME" "$PROGRAM_PATH"
    chmod +x "$PROGRAM_PATH"
    echo -e "\e[1;32mIronClean installed successfully to $PROGRAM_PATH\e[0m"
    echo -e "\e[1;33mYou can now run IronClean globally by typing: $PROGRAM_NAME\e[0m"
}

# Check if the program is already installed
check_existing_install() {
    if [ -f "$PROGRAM_PATH" ]; then
        echo -e "\e[1;33mIronClean is already installed at $PROGRAM_PATH.\e[0m"
        read -p "Do you want to overwrite it? (y/n): " choice
        if [[ "$choice" =~ ^[Yy]$ ]]; then
            echo -e "\e[1;32mOverwriting existing installation...\e[0m"
            rm -f "$PROGRAM_PATH"
            install_program
        else
            echo -e "\e[1;31mInstallation aborted.\e[0m"
            exit 1
        fi
    else
        install_program
    fi
}

# Set up configuration file
setup_config() {
    if [ ! -f "$CONFIG_FILE" ]; then
        echo -e "\e[1;33mNo configuration file found. Let's set up your email address.\e[0m"
        read -p "Enter your email address for notifications: " user_email
        echo "USER_EMAIL=\"$user_email\"" > "$CONFIG_FILE"
        echo -e "\e[1;32mConfiguration saved successfully.\e[0m"
    else
        echo -e "\e[1;32mConfiguration already exists.\e[0m"
    fi
}

# Provide a CLI interface for the user
cli_interface() {
    show_banner
    echo -e "\e[1;32mChoose an option to proceed:\e[0m"
    echo -e "1. 🧹 Install IronClean globally"
    echo -e "2. 🔄 Overwrite existing installation"
    echo -e "3. ✉️ Set up your email notification"
    echo -e "4. 🛠️ Exit"

    read -p "Enter the number of the operation: " choice
    case $choice in
        1) install_program ;;
        2) check_existing_install ;;
        3) setup_config ;;
        4) exit 0 ;;
        *) echo -e "\e[1;31mInvalid option, please try again.\e[0m"; cli_interface ;;
    esac
}

# Main installation process
main() {
    check_sudo
    cli_interface
}

# Run the main function
main
