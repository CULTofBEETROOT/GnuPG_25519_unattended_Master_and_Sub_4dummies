#!/bin/bash

# Function to process input files
process_files() {
    ownername_file=$1
    mlddrss_file=$2

rm -R /home/$USER/Downloads/runEmails;
rm -R /home/$USER/Downloads/batchgpgtmp;
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
	mkdir -p /home/$USER/Downloads/batchgpgtmp
        sed "s/someUserRealName/${ownername}/" /home/$USER/Downloads/THIRD.sh > /home/$USER/Downloads/batchgpgtmp/$ownername.sh
        
        # Update the file with user-specific gnupg path
        sed -i "s/\$USER_HOME\/.gnupg/\$USER_HOME\/.gnupg${ownername}/" /home/$USER/Downloads/batchgpgtmp/$ownername.sh
        
        # Set the permissions for the script
        chmod 777 /home/$USER/Downloads/batchgpgtmp/"$ownername.sh"

        # Update the email in the file
        sed "s/some.body@example.com/${mlddrss}/" /home/$USER/Downloads/batchgpgtmp/$ownername.sh > /home/$USER/Downloads/batchgpgtmp/$mlddrss.sh
        
        # Remove the temporary file
        rm /home/$USER/Downloads/batchgpgtmp/$ownername.sh

        # Set the permissions for the new email-linked script
        chmod 777 /home/$USER/Downloads/batchgpgtmp/"$mlddrss.sh"
        
        # Export Keys locally
        mkdir -p /home/$USER/Downloads/myKeys;
        chmod -R 777 /home/$USER/Downloads/myKeys;
        mkdir -p /home/$USER/Downloads/runEmails;
        chmod -R 777 /home/$USER/Downloads/runEmails;
        sed -i 's/exit 1/exitOne/' /home/$USER/Downloads/batchgpgtmp/"$mlddrss.sh" 
        sed 's/exit//' /home/$USER/Downloads/batchgpgtmp/"$mlddrss.sh" > /home/$USER/Downloads/runEmails/"$mlddrss.sh"
	sed -i 's/exitOne/exit 1/' /home/$USER/Downloads/runEmails/"$mlddrss.sh"
        echo "gpg --homedir \"/root/gpg/.gnupg$ownername\" --export --armor \"$mlddrss\" > \"/home/$USER/Downloads/myKeys/${mlddrss}_public.asc\"" >>  /home/$USER/Downloads/runEmails/"$mlddrss.sh"
        echo "gpg --homedir \"/root/gpg/.gnupg$ownername\" --export-secret-keys --armor \"$mlddrss\" > \"/home/$USER/Downloads/myKeys/${mlddrss}_secret.asc\"" >>  /home/$USER/Downloads/runEmails/"$mlddrss.sh"
        echo "exit" >> /home/$USER/Downloads/runEmails/"$mlddrss.sh"
        echo "Processed owner: $ownername, email: $mlddrss"
        echo "use your keys from /home/$USER/Downloads/myKeys and eventually delete this directory!"
    done

    chmod 777 /home/$USER/Downloads/runEmails/*.sh;

    for f in /home/$USER/Downloads/runEmails/*.sh; do 
	"$f" ; 
    done
    mv /root/gpg/.gnupg* /mnt/usb_gpg/
}

# Call the function with the two input files
process_files "$1" "$2"
