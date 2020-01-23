#!/usr/bin/env bash
#
# @file install.sh
# @brief install my favirote packages for ubuntu18.04 and tested 

# import

# shellcheck source=utils.sh
# shellcheck disable=SC1091
source utils.sh


# @description change the source.list with template in /etc 
#
# @noargs
# @exitcode 0 If successfull.
# @exitcode 1 On failure
function generate_apt_list_ubuntu(){
    ../etc/source.list | tee /etc/apt/source.list
    return 0
}

# @description install the basic package to ubuntu I personnally like
#
# @noargs
# @exitcode 0 If successfull.
# @exitcode 1 On failure
function install_basic(){
    # apt-get ubuntu 18.04
    apt-get update -qq 
    apt-get install -y bat nnn nmap wget curl bats mlocate mutt python3 python3-pip alsa-utils wireless-tools wpasupplicant zip unzip git cmake build-essential
    
    if [[ "$(checkWSL arg)" != "0" ]]; then
        # snap package
        snap install hub
    fi
    return 0
}


# @description install the cockpit to web 
# See your server in a web browser and perform system tasks with a mouse. It’s easy to start containers, administer storage, configure networks, and inspect logs.
# https://cockpit-project.org/
# @noargs
# @exitcode 0 If successfull.
# @exitcode 1 On failure
function install_cockpit(){
    apt-get -qq update
    apt-get -q -y install cockpit cockpit-docker cockpit-machines cockpit-packagekit
    if [[ "$(checkWSL arg)" != "0" ]]; then
        systemctl restart cockpit
    fi
    return 0
}

# @description install the cockpit to web
# 
# https://github.com/mrowa44/emojify
# @noargs
# @exitcode 0 If successfull.
# @exitcode 1 On failure
function install_emojify(){
    sh -c "curl https://raw.githubusercontent.com/mrowa44/emojify/master/emojify -o /usr/local/bin/emojify && chmod +x /usr/local/bin/emojify"
}