set -euo pipefail
trap 'echo "Something went wrong. Exit code: $?."' ERR

source ./init_server.sh
source ./manage_user.sh

main() {
    for command in "$@"; do
        if [[ $command == "init_server" ]]; then
            local args=($@)
            local command=("${args[@]:1}")

            init_server <<< "${command[@]}"
        elif [[ $command == "add_host" ]]; then
            add_host $2
        elif [[ $command == "manage_user" ]]; then
            manage_user
        fi    
    done
}

main "$@"