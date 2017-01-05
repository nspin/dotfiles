(
    cat env.head env.sh
    (
        while read var; do
            if [[ -n "$var" ]]; then
                printf 'launchctl setenv %s $%s\n' "$var" "$var"
            fi
        done
    ) < vars.txt
    cat env.tail
) > my.env.plist
