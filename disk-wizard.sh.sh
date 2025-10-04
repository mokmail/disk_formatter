#!/bin/bash
# ──────────────────────────────────────────────────────────────
# ⚠️  Disk Partition Wizard by Mohammed
# Description: Safe, interactive & animated disk formatter
# ──────────────────────────────────────────────────────────────

# ──────────────────────────────────────────────────────────────
# Define ANSI color codes for enhanced terminal output formatting.
# These variables are used to colorize and style the script's messages.
GREEN="\033[1;32m"   # Bright green for success messages
CYAN="\033[1;36m"    # Bright cyan for headers and info
YELLOW="\033[1;33m"  # Bright yellow for warnings and actions
RED="\033[1;31m"     # Bright red for errors and critical warnings
BOLD="\033[1m"       # Bold text style
NC="\033[0m"         # Reset all attributes (No Color)

# ──────────────────────────────────────────────────────────────
# Spinner animation function
# Purpose: Visually indicate progress while a background process runs.
# Arguments:
#   $1 - PID of the background process to monitor.
# The spinner cycles through characters while the process is active,
# and displays a checkmark when done.
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    # Loop while the process with $pid exists
    while ps -p $pid > /dev/null 2>&1; do
        # Animate spinner by cycling through characters
        for i in $(seq 0 3); do
            printf "\r${CYAN}[%c]${NC} Working..." "${spinstr:$i:1}"
            sleep $delay
        done
    done
    # Print completion message when process ends
    printf "\r${GREEN}[✔] Done!${NC}\n"
}

# ──────────────────────────────────────────────────────────────
# Clear the terminal for a clean start and print the script header.
# The header includes the script name, author, and contact info.
clear
echo -e "${CYAN}"
echo "───────────────────────────────────────────────"
echo "   ✨ Disk Partition Wizard by Mohammed ✨"
echo "   If you have any issues, contact me on:"
echo "   GitHub: https://github.com/mokmail"
echo "   LinkedIn: https://www.linkedin.com/in/kmailmo"
echo "───────────────────────────────────────────────"
echo -e "${NC}"

diskutil list | grep 'external' | awk '
BEGIN {
    red = "\033[31m"
    green = "\033[32m"
    yellow = "\033[33m"
    blue = "\033[34m"
    cyan = "\033[36m"
    reset = "\033[0m"
}
{print green $1 reset, $2, red $3 reset, $4, $5, $6}'


# Ask for details
read -p "Enter the name of the new volume: " volume_name
read -p "Enter the disk identifier (e.g. disk2): " disk_identifier
echo ""

# ──────────────────────────────────────────────
# 🚨 SAFETY WARNING
# ──────────────────────────────────────────────
echo -e "${RED}${BOLD}⚠️  WARNING: You are about to ERASE ALL DATA on /dev/${disk_identifier}!${NC}"
echo -e "${YELLOW}This operation will permanently delete all partitions and files on the selected disk.${NC}"
echo ""
echo -e "${CYAN}If you are not absolutely sure, press Ctrl+C now to cancel.${NC}"
echo ""

# Countdown to give time to cancel

read -p "Press Enter to confirm you want to proceed... [Y/N]" confirm 

if [[ "$confirm" != "Y" && "$confirm" != "y" ]]; then
    echo -e "${RED}Operation cancelled by user.${NC}"
    exit 1
fi

echo -e "${GREEN}Proceeding with disk formatting...${NC}"
echo ""

# ──────────────────────────────────────────────
# Disk Operations
# ──────────────────────────────────────────────


echo -e "${YELLOW}⚙️  Zeroing out first 1MB of /dev/${disk_identifier} ...${NC}"

(dd if=/dev/zero of=/dev/${disk_identifier} bs=1024 count=1024 >/dev/null 2>&1) &
spinner $!

echo ""
echo -e "${YELLOW}⚙️  Creating new partition and formatting as JHFS+ ...${NC}"
(diskutil partitionDisk /dev/${disk_identifier} GPT JHFS+ "$volume_name" 0g >/dev/null 2>&1) &
spinner $!

# ──────────────────────────────────────────────
# Completion Message
# ──────────────────────────────────────────────
echo ""
echo -e "${GREEN}🎉 Success!${NC}"
echo -e "${GREEN}💾 New volume: ${CYAN}${volume_name}${NC}"
echo -e "${GREEN}🔖 Disk identifier: ${CYAN}${disk_identifier}${NC}"
echo ""
echo -e "${CYAN}───────────────────────────────────────────────${NC}"
echo -e "${YELLOW}✨ All operations completed safely. ✨${NC}"
echo -e "${CYAN}───────────────────────────────────────────────${NC}"
echo ""


