#!/bin/bash

# IronClean: The Shield of Your System ⚔️
# =====================================================

# CONFIGURATION FILE
CONFIG_FILE="$HOME/.ironclean.conf"
USER_EMAIL=""
LOG_FILE="/dev/null"  # Suppress logs

# Load configuration or prompt for email
load_config() {
    if [[ -f "$CONFIG_FILE" ]]; then
        source "$CONFIG_FILE"
    else
        echo -e "\e[1;36mWelcome to IronClean!\e[0m"
        echo -e "\e[1;33mFirst time? Let's configure your email address!\e[0m"
        read -p "Enter your email address for notifications (optional, press Enter to skip): " user_email
        if [[ -n "$user_email" ]]; then
            echo "USER_EMAIL=\"$user_email\"" > "$CONFIG_FILE"
            echo "Configuration saved."
        else
            echo "No email provided. You can set it later using --email."
        fi
    fi
}

# Helper function: Print success messages with color
print_success() {
    echo -e "\e[1;32m[✔] $1\e[0m"
}

# Helper function: Print error messages with color
print_error() {
    echo -e "\e[1;31m[✘] $1\e[0m"
}

# Helper function: Print warning messages with color
print_warning() {
    echo -e "\e[1;33m[!] $1\e[0m"
}

# ASCII Banner
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

# Clean memory cache
clear_memory_cache() {
    print_warning "Clearing memory cache..."
    sudo sync > $LOG_FILE 2>&1
    sudo sh -c "echo 3 > /proc/sys/vm/drop_caches" > $LOG_FILE 2>&1
    print_success "Memory cache cleared."
}

# Clean junk files using regex matching
clean_junk_files() {
    print_warning "Cleaning junk files..."
    sudo find /var/log -type f -regex ".*\.\(log\|gz\|1\)$" -exec rm -f {} > $LOG_FILE 2>&1
    sudo find /tmp -type f -exec rm -f {} > $LOG_FILE 2>&1
    sudo find /var/tmp -type f -exec rm -f {} > $LOG_FILE 2>&1
    sudo find ~/.cache -type f -exec rm -f {} > $LOG_FILE 2>&1
    print_success "Junk files cleaned."
}

# Clean temporary files
clean_temp_files() {
    print_warning "Cleaning temporary files..."
    sudo rm -rf /tmp/* > $LOG_FILE 2>&1
    sudo rm -rf /var/tmp/* > $LOG_FILE 2>&1
    sudo rm -rf ~/.cache/* > $LOG_FILE 2>&1
    print_success "Temporary files cleaned."
}

# Clean old packages
clean_old_packages() {
    print_warning "Cleaning old software packages..."
    if command -v apt >/dev/null 2>&1; then
        sudo apt autoremove -y > $LOG_FILE 2>&1 && sudo apt clean > $LOG_FILE 2>&1
    elif command -v yum >/dev/null 2>&1; then
        sudo yum autoremove -y > $LOG_FILE 2>&1 && sudo yum clean all > $LOG_FILE 2>&1
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf autoremove -y > $LOG_FILE 2>&1 && sudo dnf clean all > $LOG_FILE 2>&1
    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -Rns $(pacman -Qtdq) --noconfirm > $LOG_FILE 2>&1 && sudo pacman -Sc --noconfirm > $LOG_FILE 2>&1
    else
        print_warning "Unsupported package manager. Skipping package cleanup."
    fi
    print_success "Old software packages cleaned."
}

# Clean Docker (if installed)
clean_docker() {
    if command -v docker >/dev/null 2>&1; then
        print_warning "Cleaning Docker..."
        sudo docker system prune -af > $LOG_FILE 2>&1
        print_success "Docker cleaned."
    fi
}

# Show disk usage before and after
disk_usage_analysis() {
    print_warning "Disk Usage Analysis"
    df -h
}

# Send email notification after cleanup
send_email_notification() {
    if [[ -n "$USER_EMAIL" ]]; then
        if command -v mail >/dev/null 2>&1; then
            print_warning "Sending email notification..."
            mail -s "IronClean: System Cleanup Summary" "$USER_EMAIL" < "$LOG_FILE"
            print_success "Email sent to $USER_EMAIL."
        else
            print_error "'mail' command not found. Email notification skipped."
        fi
    else
        print_warning "No email configured. Skipping email notification."
    fi
}

# Interactive mode for user-friendly operation
interactive_mode() {
    show_banner
    echo -e "\e[1;32mChoose an option:\e[0m"
    echo -e "1. 🧹 Clear Memory Cache"
    echo -e "2. 🗑️ Clean Junk Files"
    echo -e "3. ♻️ Clean Temporary Files"
    echo -e "4. 📦 Clean Old Software Packages"
    echo -e "5. 🐳 Clean Docker (if installed)"
    echo -e "6. 📊 Disk Usage Analysis"
    echo -e "7. 📧 Send Email Notification"
    echo -e "8. ❌ Exit"

    read -p "Enter the number of the operation: " choice
    case $choice in
        1) clear_memory_cache ;;
        2) clean_junk_files ;;
        3) clean_temp_files ;;
        4) clean_old_packages ;;
        5) clean_docker ;;
        6) disk_usage_analysis ;;
        7) send_email_notification ;;
        8) exit 0 ;;
        *) print_error "Invalid option! Please try again." ;;
    esac
}

# Show help menu
show_help() {
    show_banner
    echo -e "\e[1;36mIronClean Usage\e[0m"
    echo -e "\e[1;32mOptions:\e[0m"
    echo -e "  --help            Show this help menu."
    echo -e "  --interactive     Launch interactive mode."
    echo -e "  --schedule        Schedule weekly cleanup via cron."
    echo -e "  --email           Update or configure email for notifications."
    echo -e "\nFor more details, visit: https://github.com/intrepidDev101/IronClean 🛡️.git"
}

# Main logic and CLI interface
main() {
    load_config

    case "$1" in
        --help)
            show_help
            ;;
        --interactive)
            interactive_mode
            ;;
        --schedule)
            crontab -l | { cat; echo "0 3 * * 0 $(realpath $0)"; } | crontab -
            print_success "Scheduled weekly cleanup."
            ;;
        --email)
            read -p "Enter new email address (leave empty to skip): " user_email
            if [[ -n "$user_email" ]]; then
                echo "USER_EMAIL=\"$user_email\"" > "$CONFIG_FILE"
                print_success "Email updated to $user_email."
            else
                print_warning "Email update skipped."
            fi
            ;;
        *)
            show_banner
            echo -e "\e[1;33mNo valid option passed. Use --help for instructions.\e[0m"
            ;;
    esac
}

main "$@"
