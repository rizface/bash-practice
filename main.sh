set -euo pipefail
trap 'echo "Something went wrong. Exit code: $?."' ERR

parent_dir="/var/log/bootstrap-server"

source ./log.sh
source ./init_server.sh
source ./manage_user.sh
source ./manage_firewall.sh

main() {
    if ! [ -d $parent_dir ]; then
        printf "📂 Creating $parent_dir directory \n"
        sudo mkdir $parent_dir

        printf "📂 Creating $parent_dir/error.log file \n"
        sudo touch $parent_dir/error.log

        sudo chown $(whoami) $parent_dir/*
 
        if [[ $? > 0 ]]; then
                printf "❌ Failed creating $parent_dir directory \n"
                exit $?
        fi
    fi
    
    
    for command in "$@"; do
        if [[ $command == "init_server" ]]; then
            local args=($@)
            local command=("${args[@]:1}")

            init_server <<< "${command[@]}"
        elif [[ $command == "add_host" ]]; then
            add_host $2
        elif [[ $command == "manage_user" ]]; then
            manage_user
        elif [[ $command == "manage_firewall" ]]; then
            manage_firewall
        fi    
    done
}

main "$@"