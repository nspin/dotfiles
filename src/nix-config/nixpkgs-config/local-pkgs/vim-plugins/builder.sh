touch $out
(
    echo -n "let g:pluginList = ["
    cont___="                 \ "
    first=1
    for plugin in $plugins; do
        echo -n $cont___
        if test -z $first; then
            echo -n ", "
        fi
        first=""
        echo "\"$plugin\""
    done
    echo $cont___ "]"
) > $out
