#!/bin/bash

# ------------------------------------------------------------------
# This script starts the ssh agent and loads all ssh keys in ~/.ssh/
# ------------------------------------------------------------------

get_password () {
    echo "Enter the universal passphrase"
    read -s -p "Password: " pass
    echo -e "\n"
}

check_keys () {
# This will check if there are any keys in ~/.ssh/
    num_of_keys=$(ls ~/.ssh/ | grep ".pub" | wc -l)
    case $((num_of_keys)) in
        0)
            echo "No keys were found."
            exit 1
            ;;
        1)
            echo "Found one key."
            ;;
        *)
            echo "Found a total of $num_of_keys keys."
            ;;
    esac
}

get_ssh_keys () {
# This function reads all files in ~/.ssh/ ending in .pub and uses it to find the corresponding private keys

    # Getting the .pub key files
    pub_keys=($(ls ~/.ssh/ | grep ".pub" ))
    prv_keys=()
    
    # Removing the .pub from the keys to get the private key filename
    for i in "${pub_keys[@]}"
    do
        prv_keys[${#prv_keys[@]}]=$(echo "${i%%.pub}")
    done
}

# ------------
#    Main
# ------------

# Starting ssh agent
echo "Starting ssh agent service"
eval "$(ssh-agent -s)"

# Checking for ssh keys
check_keys

# Getting ssh keys
get_ssh_keys

# Getting user password
get_password

for key in "${prv_keys[@]}"
do
    echo "Loading key for: $key"
    expect << EOF
    log_user 0
    spawn -noecho bash -c {ssh-add -- ~/.ssh/$key}
    expect { 
        "Enter passphrase" {send "$pass\r"}
    }
    expect eof
EOF
done

echo -e "\nSuccessfully added all ssh keys"
ssh-add -l
