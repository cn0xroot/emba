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

# Description:  Installs basic toole which are always needed for EMBA and currently have no dedicated installer module

I01_default_apps(){
  module_title "${FUNCNAME[0]}"

  if [[ "$LIST_DEP" -eq 1 ]] || [[ $IN_DOCKER -eq 1 ]] || [[ $DOCKER_SETUP -eq 0 ]] || [[ $FULL -eq 1 ]] ; then
    print_tool_info "make" 1
    print_tool_info "tree" 1
    print_tool_info "device-tree-compiler" 1
    print_tool_info "qemu-user-static" 0 "qemu-mips-static"
    #print_tool_info "pylint" 1 # not used anymore
    # libguestfs-tools is needed to mount vmdk images
    print_tool_info "libguestfs-tools" 1
    print_tool_info "ent" 1
    # needed for sshdcc:
    print_tool_info "tcllib" 1
    print_tool_info "metasploit-framework" 1
    print_tool_info "u-boot-tools" 1
    print_tool_info "python3-bandit" 1
    print_tool_info "iputils-ping" 1
    # john password cracker
    print_tool_info "john" 1
    print_tool_info "john-data" 1
  
    if [[ "$LIST_DEP" -eq 1 ]] || [[ $DOCKER_SETUP -eq 1 ]] ; then
      ANSWER=("n")
    else
      echo -e "\\n""$MAGENTA""$BOLD""These applications will be installed/updated!""$NC"
      ANSWER=("y")
    fi

    case ${ANSWER:0:1} in
      y|Y )
        echo
        apt-get install "${INSTALL_APP_LIST[@]}" -y
      ;;
    esac
  fi
}
