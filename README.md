# GnuPG 25519 Unattended Master and Sub Keys Generator
(simpler README)


Overview
This repository provides a set of scripts for generating GPG Master and subkeys using a USB key with LUKS encryption. The scripts are designed for non-root users but require root access for certain operations. This setup is tailored for Debian Trixie and is intended for users who may be working on older hardware without internet access during the process.


Important Notes
 * Execution Order: The scripts must be run in the specified order: FIRST, SECOND, and THIRD. Do not skip any steps, even if a step fails.
 * Environment: Ensure you have the necessary files in your Downloads directory before starting.


Steps to Follow

Step 1: Run the First Script
 1. Open a terminal.
 2. Execute the following command as the root user or with sudo:

 bash /home/$USER/Downloads/FIRST.sh

Step 2: Create the USB Key with LUKS
 1. Start this step in root mode:

 bash /home/$USER/Downloads/SECOND.sh

Step 3: Save GPG Master and Subkeys on the USB Device
 1. Start this step in root mode. You may need to change the permissions of the script to make it executable.
 Use the following command:

 chmod +x /home/$USER/Downloads/THIRD.sh

 2. Then, run the script:

 /home/$USER/Downloads/THIRD.sh



# ALTERNATIVE FOR BATCH PRODUCTION

 * If you have multiple email addresses for which you want to generate GPG keys, consider downloading THIRD.sh AND batchproduction_ofTHIRD.sh, then using the command:
 
 /home/$USER/Downloads/batchproduction_ofTHIRD.sh

This script allows you to input lists of emails and their respective owners, producing individual bash scripts for each email address.
 * When you run the generated individual scripts, they will create GPG keys stored on your LUKS-encrypted USB key. Important: OpenGPG recommends that you immediately use and then delete any self-unencrypted private keys to avoid storing sensitive information.


Final Step: Safely Unmount the USB Device
After successfully completing all steps, ensure you safely unmount your USB LUKS device to prevent potential issues when reconnecting it:

sudo umount "/mnt/usb_gpg"
sudo cryptsetup luksClose myusb_key

or the next time you plug your device, you potentially would experience difficulties.


Conclusion
By following these steps, you can securely generate and store your GPG Master and subkeys on a LUKS-encrypted USB key. Always remember to handle your private keys with care and follow best practices for security. If you have any questions or issues, please refer to the documentation or seek assistance from the community.




