# How To Use: Disk Partition Wizard by Kmail

This guide explains how to safely use the interactive, animated Bash script for formatting and partitioning disks on macOS.

---

## Prerequisites

- **macOS** system
- **Admin privileges** (run with `sudo`)
- **Backup** any important data from the target disk

---

## Steps

1. **Download or copy the script** to your machine (e.g., `disk-wizard.sh`).

2. **Make the script executable:**
    ```bash
    chmod +x disk-wizard.sh
    ```

3. **Run the script with sudo:**
    ```bash
    sudo ./disk-wizard.sh
    ```

4. **Script Overview:**
    - The script lists all external disks.
    - You will be prompted to enter:
      - The **name** for the new volume.
      - The **disk identifier** (e.g., `disk2`).

5. **Safety Warning:**
    - The script will display a warning before erasing the disk.
    - You must confirm by pressing `Y` and Enter to proceed.

6. **Disk Formatting:**
    - The script will:
      - Zero out the first 1MB of the disk.
      - Create a new partition and format it as JHFS+ (Mac OS Extended).

7. **Completion:**
    - On success, you’ll see a summary with the new volume name and disk identifier.

---

## Example Session

```shell
───────────────────────────────────────────────
   ✨ Disk Partition Wizard by Mohammed ✨
   If you have any issues, contact me on:
   GitHub: https://github.com/mokmail
   LinkedIn: https://www.linkedin.com/in/kmailmo
───────────────────────────────────────────────

/dev/disk5 (external, physical):   

    ********************************
    ********************************
    ********************************
    ********************************
    ********************************
    ********************************
    ********************************
    ********************************
    ********************************

Enter the name of the new volume: Palestine
Enter the disk identifier (e.g. disk2): disk5 

⚠️  WARNING: You are about to ERASE ALL DATA on /dev/disk5!
This operation will permanently delete all partitions and files on the selected disk.

If you are not absolutely sure, press Ctrl+C now to cancel.

Press Enter to confirm you want to proceed... [Y/N]y
Proceeding with disk formatting...

⚙️  Zeroing out first 1MB of /dev/disk5 ...
[✔] Done!ng...

⚙️  Creating new partition and formatting as JHFS+ ...
[✔] Done!ng...
./disk-wizard.sh.sh: line 134: r: command not found

🎉 Success!
💾 New volume: Palestine
🔖 Disk identifier: disk5

───────────────────────────────────────────────
✨ All operations completed safely. ✨
───────────────────────────────────────────────


    ********************************
    ********************************
    ********************************
    ********************************
    ********************************
    ********************************
    ********************************
    ********************************
    ********************************

 free free Palestine 🇵🇸 

```

---

## Notes

- **Double-check** the disk identifier to avoid data loss.
- For support, contact [mokmail on GitHub](https://github.com/mokmail) or [LinkedIn](https://www.linkedin.com/in/kmailmo).


