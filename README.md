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
 bash /home/$USER/Downloads/FIRST_GnuPG_upgrade.sh
Step 2: Create the USB Key with LUKS
 1. Start this step in root mode:
 bash /home/$USER/Downloads/SECOND_create_usbkey_LUKS_toKeepGnuPGKeys.sh
Step 3: Save GPG Master and Subkeys on the USB Device
 1. Start this step in root mode. You may need to change the permissions of the script to make it executable. Use the 
following command:
 chmod +x /home/$USER/Downloads/THIRD_GnuPG_MASTER_and_subkeys_save_on_USBdevice_LUKS.sh
 2. Then, run the script:
 /home/$USER/Downloads/THIRD_GnuPG_MASTER_and_subkeys_save_on_USBdevice_LUKS.sh

ALTERNATIVE FOR BATCH PRODUCTION
 * If you have multiple email addresses for which you want to generate GPG keys, consider using the batchproduction_ofTHIRD.sh script. This script allows you to input lists of emails and their respective owners, producing individual bash scripts for each email address.
 * The generated scripts will create GPG keys stored on your LUKS-encrypted USB key. Important: OpenGPG recommends that you immediately use and then delete any self-unencrypted private keys to avoid storing sensitive information.

Final Step: Safely Unmount the USB Device
After successfully completing all steps, ensure you safely unmount your USB LUKS device to prevent potential issues when reconnecting it:
sudo umount "/mnt/usb_gpg"
sudo cryptsetup luksClose myusb_key

Conclusion
By following these steps, you can securely generate and store your GPG Master and subkeys on a LUKS-encrypted USB key. Always remember to handle your private keys with care and follow best practices for security. If you have any questions or issues, please refer to the documentation or seek assistance from the community.




# README more ADVANCED users

Root-orchestrated_USB-key_LUKS-storage_reader_or_encryptor_4_non-root_User_GPG_Master-_sub-_keys_Generator.
Root-orchestrated, USB-key LUKS-storage, 25519-family, reader or encryptor, for non-root User GPG Master- & sub-, keys Generator. 

this code is transitory and untidy, humble.

build with Debian trixie in mind, root access.


a) The scripts have to be run in the order lister : FIRST, then SECOND, then THIRD (do not skip when a step fails)


b) step FIRST, if you eg. have these 3 files in your    Downloads    directory, root user or sudo :

bash /home/$USER/Downloads/FIRST_GnuPG_2p5+_required.sh


c) step SECOND is started in root mode with : 

bash /home/$USER/Downloads/SECOND_create_usbkey_LUKS_toKeepGnuPGKeys.sh


d1) step THIRD is started in root mode with :
(You could have to chmod higher like 777. Remember, theoretically you run all these on a old hardware fresh debian install without internet during the process. 
chmod 777 /home/$USER/Downloads/THIRD_GnuPG_MASTER_and_subkeys_save_on_USBdevice_LUKS.sh; 
/home/$USER/Downloads/THIRD_GnuPG_MASTER_and_subkeys_save_on_USBdevice_LUKS.sh or restrictive:.. ).

chmod +x /home/$USER/Downloads/THIRD_GnuPG_MASTER_and_subkeys_save_on_USBdevice_LUKS.sh; 
/home/$USER/Downloads/THIRD_GnuPG_MASTER_and_subkeys_save_on_USBdevice_LUKS.sh

d2) A better practice and batch production alternative (for d1) is to list your emails and their owners in repsctive files used by running the batchproduction_ofTHIRD.sh bash script.

This batch (requires THIRD to be downloaded) produces THIRD-modeled bash scripts when you have long lists of emails addresses to produce your gpg keys for. This file takes emails and owners (or in the absence of, a blank) -files, in input. 
In this version, to avoid hardware storage of sensible information, this script has default directory your Luks-encrypted USBkey (from running bash script FIRST and SECOND): feel free to modify at your own risk.
You will have to run individually these produced bash scripts by the name of your every email address.
Then you will obtain on the Luks-encrypted USBkey your .gnupgEMAIL directory AND self-unencrypted private and public keys for immediate use: 
WARNING: !!! OpenGPG do recommend you immediately use and then delete this private key, in practice, from anywhere (your Luks-encrypted Device) !!!
in short: self-unencrypted private keys ** Should never be stored **


e) When all went succesfully, at the very end last step and at the end of every use of the completed creation (FIRST + SECOND + THIRD), 
close the use of your USB luks Device with the command : 

sudo umount "/mnt/usb_gpg"; sudo cryptsetup luksClose myusb_key" 

or the next time you plug your device, you potentially would experience difficulties.
