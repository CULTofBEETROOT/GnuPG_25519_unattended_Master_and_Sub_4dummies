#!/bin/bash

# Function to process input files
process_files() {
    ownername_file=$1
    mlddrss_file=$2

    # Check if both files exist
    if [[ ! -f "$ownername_file" ]] || [[ ! -f "$mlddrss_file" ]]; then
        echo "Both input files must exist."
        exit 1
    fi

    # Read each line from both files and process them
    paste "$ownername_file" "$mlddrss_file" | while IFS=$'\t' read -r ownername mlddrss; do
        # Ensure both values are non-empty
        if [[ -z "$ownername" ]] || [[ -z "$mlddrss" ]]; then
            echo "Skipping invalid entry (either ownername or mlddrss is empty)."
            continue
        fi

        # Create a script for the current ownername
        sed "s/someUserRealName/${ownername}/" /home/$USER/Downloads/THIRD_GnuPG_MASTER_and_subkeys_save_on_USBdevice_LUKS.sh > /home/vzv/Downloads/$ownername.sh
        
        # Update the file with user-specific gnupg path
        sed -i "s/\$USER_HOME\/.gnupg/\$USER_HOME\/.gnupg${ownername}/" /home/$USER/Downloads/$ownername.sh
        
        # Set the permissions for the script
        chmod 777 /home/$USER/Downloads/"$ownername.sh"

        # Update the email in the file
        sed "s/some.body@example.com/${mlddrss}/" /home/$USER/Downloads/$ownername.sh > /home/vzv/Downloads/$mlddrss.sh
        
        # Remove the temporary file
        rm /home/$USER/Downloads/$ownername.sh

        # Set the permissions for the new email-linked script
        chmod 777 /home/$USER/Downloads/"$mlddrss.sh"
        
        # Export Keys locally
        mkdir -p /home/$USER/Downloads/myKeys;
        chmod 777 /home/$USER/Downloads/myKeys;
        sed -i 's/exit//' /home/$USER/Downloads/"$mlddrss.sh"
        echo "gpg --homedir /root/gpg/.gnupg$ownername --export --armor $mlddrss > /home/$USER/Downloads/myKeys/$mlddrss_public.asc" >>  /home/$USER/Downloads/"$mlddrss.sh"
        echo "gpg --homedir /root/gpg/.gnupg$ownername --export-secret-keys --armor $mlddrss > /home/$USER/Downloads/myKeys/$mlddrss_secret.asc" >>  /home/$USER/Downloads/"$mlddrss.sh"
        echo "exit" >> /home/$USER/Downloads/"$mlddrss.sh"

        echo "Processed owner: $ownername, email: $mlddrss"
        echo "use your keys form /home/$USER/Downloads/myKeys and eventually delete this directory!"
    done
}

# Call the function with the two input files
process_files "$1" "$2"
