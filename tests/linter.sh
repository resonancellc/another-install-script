#!/usr/bin/env bash
#
# @file linter.sh
# @brief shellcheck for all the bash script

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)/../src/utils.sh"

# @description install shellcheck
# https://github.com/koalaman/shellcheck
# @noargs
# @exitcode 0 If successfull.
# @exitcode 1 On failure
install_shellcheck(){
    if [[ ! $(command -v shellcheck) ]]; then
        aptinstall shellcheck
    fi
    return 0
}


# @description use shellcheck on all bash script in project
#
# @args $1
# @exitcode 0 If successfull.
# @exitcode 1 On failure
use_shellcheck(){
    names=$(find ../ -type d \( -path ../tests/coverage -o -path ../tests/bin -o -path ../etc -o -path /tmp -o -path ../docs/scripts -o -path vm -o -path src/containers \) -prune -o -iname "*.sh" -print)

    SAVEIFS=$IFS   # Save current IFS
    IFS=$'\n'      # Change IFS to new line
    names=($names) # split to array $names
    IFS=$SAVEIFS   # Restore IFS
    install_shellcheck
    for (( i=0; i<${#names[@]}; i++ )); do
        echo "$i: ${names[$i]}"
        shellcheck "${names[$i]}"
    done

    return 0
}

use_shellcheck