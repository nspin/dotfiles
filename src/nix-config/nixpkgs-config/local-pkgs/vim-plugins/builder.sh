(
    echo -n "let g:pluginList = ["
    cont="                 \ "
    first=1
    for plugin in $plugins; do
        if test -z $first; then
            echo -n "$cont,"
        fi
        first=""
        echo " \"$plugin\""
    done
    echo "$cont]"
) > $out
