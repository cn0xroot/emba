#!/bin/bash

# EMBA - EMBEDDED LINUX ANALYZER
#
# Copyright 2020-2022 Siemens AG
# Copyright 2020-2022 Siemens Energy AG
#
# EMBA comes with ABSOLUTELY NO WARRANTY. This is free software, and you are
# welcome to redistribute it under the terms of the GNU General Public License.
# See LICENSE file for usage of this software.
#
# EMBA is licensed under GPLv3
#
# Author(s): Michael Messner, Pascal Eckmann
# Contributor(s): Stefan Haboeck, Nikolas Papaioannou

# Description:  Installs different open source tools from github

I199_default_tools_github() {
  module_title "${FUNCNAME[0]}"

  if [[ "$LIST_DEP" -eq 1 ]] || [[ $IN_DOCKER -eq 1 ]] || [[ $DOCKER_SETUP -eq 0 ]] || [[ $FULL -eq 1 ]]; then

    print_file_info "linux-exploit-suggester" "Linux privilege escalation auditing tool" "https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh" "external/linux-exploit-suggester.sh"
    print_file_info "checksec" "Check the properties of executables (like PIE, RELRO, PaX, Canaries, ASLR, Fortify Source)" "https://raw.githubusercontent.com/slimm609/checksec.sh/master/checksec" "external/checksec"
    print_file_info "sshdcc" "Check SSHd configuration files" "https://raw.githubusercontent.com/sektioneins/sshdcc/master/sshdcc" "external/sshdcc"
    print_file_info "sudo-parser.pl" "Parses and tests sudoers configuration files" "https://raw.githubusercontent.com/CiscoCXSecurity/sudo-parser/master/sudo-parser.pl" "external/sudo-parser.pl"
    print_file_info "pixd" "pixd is a tool for visualizing binary data using a colour palette." "https://github.com/FireyFly/pixd/pixd.c" "external/pixd"
    print_file_info "progpilot" "progpilot is a tool for static security tests on php files." "https://github.com/designsecurity/progpilot/releases/download/v0.8.0/progpilot_v0.8.0.phar" "external/progpilot"
    print_file_info "EnGenius decryptor" "Decrypts EnGenius firmware files." "https://gist.githubusercontent.com/ryancdotorg/914f3ad05bfe0c359b79716f067eaa99/raw/5600956a5bba4c674a010bf27e7eaad25a496b87/decrypt.py" "external/engenius-decrypt.py"
  
    print_pip_info "pillow"
  
    if [[ "$LIST_DEP" -eq 1 ]] || [[ $DOCKER_SETUP -eq 1 ]] ; then
      ANSWER=("n")
    else
      echo -e "\\n""$MAGENTA""$BOLD""These applications (if not already on the system) will be downloaded!""$NC"
      ANSWER=("y")
    fi
  
    case ${ANSWER:0:1} in
      y|Y )
        download_file "linux-exploit-suggester" "https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh" "external/linux-exploit-suggester.sh"
        download_file "checksec" "https://raw.githubusercontent.com/slimm609/checksec.sh/master/checksec" "external/checksec"
        download_file "sshdcc" "https://raw.githubusercontent.com/sektioneins/sshdcc/master/sshdcc" "external/sshdcc"
        download_file "sudo-parser.pl" "https://raw.githubusercontent.com/CiscoCXSecurity/sudo-parser/master/sudo-parser.pl" "external/sudo-parser.pl"
        download_file "progpilot" "https://github.com/designsecurity/progpilot/releases/download/v0.8.0/progpilot_v0.8.0.phar" "external/progpilot"
        download_file "EnGenius decryptor" "https://gist.githubusercontent.com/ryancdotorg/914f3ad05bfe0c359b79716f067eaa99/raw/5600956a5bba4c674a010bf27e7eaad25a496b87/decrypt.py" "external/engenius-decrypt.py"
  
        # pixd installation
        pip3 install pillow 2>/dev/null
        echo -e "\\n""$ORANGE""$BOLD""Downloading of pixd""$NC"
        git clone https://github.com/p4cx/pixd_image external/pixd
        cd ./external/pixd/ || ( echo "Could not install EMBA component pixd" && exit 1 )
        make
        mv pixd ../pixde
        mv pixd_png.py ../pixd_png.py
        cd "$HOME_PATH" || ( echo "Could not install EMBA component pixd" && exit 1 )
        rm -r ./external/pixd/
        # pixd installation finished
      ;;
    esac
  fi
} 
