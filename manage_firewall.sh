enable_defualt_policies() {
    local ports=(22 80 443)

    info "Enabling 22 (SSH), 80 (HTTP), 443 (HTTPS)"
    
    for port in "${ports[@]}"; do
        if ! sudo ufw allow "$port" 2>> $parent_dir/error.log 1> /dev/null; then
            error Failed enable port $port
            exit 1
        fi
    done

    info "Enabled ports: 22 (SSH), 80 (HTTP), 443 (HTTPS) ✅"
}

backup_current_rule() {
    read -p "Enter path: " path

    info "Backup current rule to $path started"
    sudo ufw status verbose > $path
    info "Backed-up rule stored in $path ✅"
}

manage_firewall() {
    while true; do
        printf "\n1. Enable basic policies: 22 (SSH), 80 (HTTP), 443(HTTPS)"
        printf "\n2. Backup current rule"
        printf "\n0. Exit\n"

        read -p "Option: " choice

        case $choice in
            "1")
                enable_defualt_policies
            ;;
            "2")
                backup_current_rule
            ;;
            "0")
                echo "Goodbye"
                break
            ;;
        esac
    done
}