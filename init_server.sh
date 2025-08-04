update_server() {
    printf "Upgrade server is running \n\n"
    
    sudo apt update
    sudo apt upgrade
    
    printf "\n\nUpgrade server is finished\n\n"
    
}

install_curl() {
    printf "Installing curl\n\n"

    sudo apt install curl

    printf "\n\nSuccessfully install curl\n\n"
}

install_git() {
    printf "Installing git\n\n"

    sudo apt install git

    printf "\n\nSuccessfully install git\n\n"
}

install_vim() {
    printf "Installing vim\n\n"

    sudo apt install vim

    printf "\n\nSuccessfully install vim\n\n"
}

install_ufw() {
    if sudo command -v sudo ufw > /dev/null;then
        info "UFW already installed ✅"
    else
        info "Installing ufw"
        sudo apt install ufw
        info "Successfully install ufw ✅"
        info "Enabling ufw"
        sudo ufw enable
        info "UFW enabled ✅"
        enable_defualt_policies
        info "Reloading firewall..."
        info $(sudo ufw reload)
        info "Firewall setup complete 🔒"
    fi
}

init_server() {
    printf "Init server started \n\n"

    while read -a commands; do
        for command in "${commands[@]}"; do
            case "$command" in
                update)
                    update_server
                ;;
                curl)
                    install_curl
                ;;
                git)
                    install_git
                ;;
                vim)
                    install_vim
                ;;
                ufw)
                    install_ufw
                ;;
            esac
        done
    
        break
    done
}

add_host() {
    printf "\n%s %s\n" "127.0.1.1 $1" | sudo tee -a /etc/hosts
}