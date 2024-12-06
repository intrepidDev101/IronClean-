# IronClean 🛡️ : The Shield of Your System ⚔️

IronClean🛡️ is a powerful Linux system cleaning tool designed to remove unwanted files, clear memory cache, and clean old packages, all while ensuring the security and smooth performance of your system. It provides an easy-to-use command-line interface (CLI) with interactive options, email notifications, and global installation support.

## Features
- **Memory Cache Cleaning**: Frees up RAM by clearing the memory cache without needing to reboot.
- **Junk Files Cleanup**: Removes unnecessary files that clutter the system, such as temporary files, logs, and cache.
- **Old Software Packages Cleanup**: Uninstalls old software packages to free up disk space.
- **Disk Usage Analysis**: Displays disk space usage before and after the cleanup.
- **Interactive CLI**: Choose cleaning operations interactively with a simple terminal interface.
- **Email Notifications**: Get notified via email after the cleanup is completed.
- **Global Installation**: Install the program globally on your system with a single command.


## Table of Contents
1.[Installation](installation)

- [Install Dependencies](installdependencies)
- [Download and Install IronClean4](download&install)
- [Run IronClean4](runtheprogram)
2.[How to Use](usage)
- [Interactive Mode](interactivemode)
- [Basic Usage](basicusage)
3.[Features in Detail](featuredetails)
- [Memory Cache Cleaning](memoryclean)
- [Junk File Cleanup]()
- [Temporary File Cleanup]()
- [Old Software Package Cleanup]()
- [Disk Usage Analysis]()
- [Email Notifications]()
4.Setup
- [Setting Up Email Notifications](emailsetup)
- [Global Installation with setup.sh](executer)
5.[Troubleshooting](troubleshoot)

6.[License](license)

## Installation
**Install Dependencies**

IronClean🛡️ requires certain system utilities and tools to function. Make sure the following dependencies are installed:

- `sudo`: To run commands with root privileges.
- `mail` (for email notifications): Ensure your system has the `mail` command (e.g., `mailutils` or `msmtp`).
- `bash`: The script is written in bash and requires a bash shell to execute.

For **Debian/Ubuntu-based** systems, run:

```bash
sudo apt update
sudo apt install sudo mailutils
```

For **Red Hat/CentOS-based** systems, run:

```bash
sudo yum install sudo mailx
```

#### Download and Install IronClean🛡️
You can download and install IronClean🛡️ using the provided `setup.sh` script. This will install the program globally and make it executable from anywhere on your system.

1.Clone the repository or download the `ironcl.sh` and `setup.sh` files.

2.Make the `setup.sh` script executable:

```bash
chmod +x setup.sh
```

3.Run the setup script:

```bash
./setup.sh
```
---

The `setup.sh` script will:

- Install IronClean🛡️ globally in `/usr/local/bin/`.
- Set up email notifications (you will be prompted to enter your email address if not already configured).
- Provide an easy-to-use CLI interface for installation and configuration.

### Run IronClean🛡️
After installation, you can run the program globally from anywhere by typing:

```bash
ironcl.sh
```

## How to Use
IronClean🛡️ offers two main modes: **Interactive Mode** and **Basic Usage**.

#### Interactive Mode
IronClean🛡️ allows you to interactively choose which system cleanup operations to perform.

1.Run the program in interactive mode:

```bash
ironcl.sh --interactive
```

2.You will be presented with a simple menu. Use the number keys to choose the task:

- **1**: Install IronClean🛡️ globally
- **2**: Overwrite existing installation
- **3**: Set up email notifications
- **4**: Exit

3.Select the desired action by entering the corresponding number.

#### Basic Usage
In addition to interactive mode, you can execute all cleanup tasks in one go using the default mode.

```bash
ironcl.sh
```

This will:

- Display disk usage analysis.
- Clear memory cache.
- Clean junk files, temporary files, and old software packages.
- Display the disk usage analysis again after cleanup.

## Features in Detail
### Memory Cache Cleaning

IronClean🛡️ clears the memory cache, freeing up RAM without requiring a system reboot. This operation can help improve system performance by removing cached data from unused applications.

**How it works**:

- The script writes to `/proc/sys/vm/drop_caches` to clear the cache.

## Junk File Cleanup
Junk files include system logs, temporary files, and other unnecessary files that accumulate over time. IronClean🛡️ will clean them to recover disk space and reduce system clutter.

**Types of files cleaned**:

- Cache files
- Log files
- Temporary files from applications

## Temporary File Cleanup
IronClean🛡️ also cleans temporary files from system directories like `/tmp` and `/var/tmp`.

## Old Software Package Cleanup
Old software packages and dependencies that are no longer needed can take up valuable disk space. IronClean🛡️ removes these unnecessary packages to keep your system lean and efficient.

## Disk Usage Analysis
Before and after performing cleanup operations, IronClean🛡️ displays a disk usage analysis. This lets you see exactly how much space was recovered and where it was freed up.

## Email Notifications
IronClean🛡️ can send you email notifications after the cleanup process is complete. You will be prompted to enter your email address during the initial configuration (if not already configured).

# Setup
## Setting Up Email Notifications
During the first run or setup, you will be prompted to enter your email address for receiving notifications about system cleanups.

1.Run the `setup.sh` script, and it will ask for your email address.

2.The email address will be saved in `$HOME/.ironclean.conf`.

3.Ensure the `mail` utility is installed for email notifications.

**Note**: IronClean🛡️ uses the system's default mail program (`mail` or `mailx`). If you don't have one installed, you may need to install `mailutils` or another similar tool depending on your distribution.

## Global Installation with `setup.sh`
To install IronClean🛡️ globally, simply run the `setup.sh` script. This will:

- Copy the `ironcl.sh` script to `/usr/local/bin/`, making it executable globally.
- Set up the necessary configuration files.
- Provide a basic CLI interface for setting options.

To run the setup script:

```bash
chmod +x setup.sh
./setup.sh
```

# Troubleshooting
- **Permission Denied (when clearing memory cache)**: Ensure you have `sudo` privileges and are running the script with the appropriate permissions. Memory cache cleaning requires root privileges.

- **Email Not Sending**: Make sure the `mail` command is installed and configured correctly on your system. Check the configuration in `$HOME/.ironclean.conf` to ensure your email address is correct.

- **Not Enough Space Recovered**: If IronClean doesn't seem to recover enough space, try running the tool again after a longer period of usage. Old packages and junk files may accumulate over time.

# License
IronClean🛡️ is open-source software released under the MIT License. See the [LICENSE](license) file for more information.