add_user() {
    printf "\n"

    read -p "Username: " username
    
    sudo useradd -m -s /bin/bash -U $username
    sudo passwd $username
}

edit_user() {
    echo ""
}

delete_user() {
    echo ""
}

manage_user() {
    while true; do
        echo "1. Add user"
        echo "2. Edit user"
        echo "3. Delete user"
        echo "4. Change password"
        printf "0. Exit \n\n"

        read -p "Option: " choice

        case $choice in
            "1")
                add_user
            ;;
            "0")
                break
            ;;
        esac
    done
}