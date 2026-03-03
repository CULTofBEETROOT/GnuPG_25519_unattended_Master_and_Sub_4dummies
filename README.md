# GnuPG_25519_unattended_Master_and_Sub_4dummies
unattended GnuPG GPG 25519 series MASTER and ALL subkeys no RSA 

# this code is transitory and untidy, humble.

# build with Debian trixie in mind, root access.


a) The scripts have to be run in the order lister : FIRST, then SECOND, then THIRD (do not skip when a step fails)


b) if you eg. have these 3 files in your    Downloads    directory :

bash /home/$USER/Downloads/FIRST_GnuPG_2.5_required.sh


c) step to is started in root mode with : 

bash /home/$USER/Downloads/SECOND_create_usbkey_LUKS_toKeepGnuPGKeys.sh


d) step THIRD is started in root mode with :

chmod +x /home/$USER/Downloads/THIRD_GnuPG_MASTER_and_subkeys_save_on_USBdevice_LUKS.sh; /home/$USER/Downloads/THIRD_GnuPG_MASTER_and_subkeys_save_on_USBdevice_LUKS.sh


e) When all went succesfully, at the very end last step and at the end of every use of the completed creation (FIRST + SECOND + THIRD), 
close the use of your USB luks Device with the command : 

sudo umount "/mnt/usb_gpg"; sudo cryptsetup luksClose myusb_key" 

or the next time you plug your device, you potentially would experience difficulties.
