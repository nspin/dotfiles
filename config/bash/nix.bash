build() {
    local argAction="$1"
    shift
    local argPhase="$1"

    if [ -z "${argAction:-}" -o -z "${argPhase:-}" ]; then
        echo "error: args"
        return 1
    fi

    if [ "$argAction" == only ]; then
        local phases="$argPhase"
    fi

    if [ -z "${phases:-}" ]; then
        phases="${prePhases:-} unpackPhase patchPhase ${preConfigurePhases:-} \
            configurePhase ${preBuildPhases:-} buildPhase checkPhase \
            ${preInstallPhases:-} installPhase ${preFixupPhases:-} fixupPhase installCheckPhase \
            ${preDistPhases:-} distPhase ${postPhases:-}";
    fi

    for curPhase in $phases; do
        if [ "$argAction" == until -a "$curPhase" == "$argPhase" ]; then
            break
        fi
        if [[ "$curPhase" = buildPhase && -n "${dontBuild:-}" ]]; then continue; fi
        if [[ "$curPhase" = checkPhase && -z "${doCheck:-}" ]]; then continue; fi
        if [[ "$curPhase" = installPhase && -n "${dontInstall:-}" ]]; then continue; fi
        if [[ "$curPhase" = fixupPhase && -n "${dontFixup:-}" ]]; then continue; fi
        if [[ "$curPhase" = installCheckPhase && -z "${doInstallCheck:-}" ]]; then continue; fi
        if [[ "$curPhase" = distPhase && -z "${doDist:-}" ]]; then continue; fi

        if [[ -n $NIX_LOG_FD ]]; then
            echo "@nix { \"action\": \"setPhase\", \"phase\": \"$curPhase\" }" >&$NIX_LOG_FD
        fi

        showPhaseHeader "$curPhase"
        dumpVars

        # Evaluate the variable named $curPhase if it exists, otherwise the
        # function named $curPhase.
        local oldOpts="$(shopt -po nounset)"
        set +u
        eval "${!curPhase:-$curPhase}"
        eval "$oldOpts"

        if [ "$curPhase" = unpackPhase ]; then
            cd "${sourceRoot:-.}"
        fi
    done
}
