#!/bin/bash

# Purpose: Support next-generation Alpine Linux apk package manager
# Author : Carl X. Su <bcbcarl@gmail.com>
#          Cuong Manh Le <cuong.manhle.vn@gmail.com>
# License: Fair license (http://www.opensource.org/licenses/fair)
# Source : http://github.com/icy/pacapt/

# Copyright (C) 2016 CuongLM
#
# Usage of the works is permitted provided that this instrument is
# retained with the works, so that any entity that uses the works is
# notified of this instrument.
#
# DISCLAIMER: THE WORKS ARE WITHOUT WARRANTY.

_apk_init() {
  :
}

# apk_Q may _not_implemented
apk_Q() {
  case "$_TOPT" in
  "")
    apk info --all $(apk info -dws) \
    | grep 'installed size' \
    | awk '{ print $1}'
    ;;
  "q")
    apk info
    ;;
  *)
    _not_implemented
    ;;
  esac
}

apk_Qi() {
  apk info --all -- "$@"
}

apk_Ql() {
  apk info --contents -- "$@"
}

apk_Qo() {
  if cmd="$(command -v -- "$@")"; then
    apk info --who-owns -- "$cmd"
  else
    apk info --who-owns -- "$@"
  fi
}

apk_Qs() {
  apk_Q | grep -Ee ".*${*}.*"
}

apk_Qu() {
  apk version -l '<'
}

apk_R() {
  apk del $_TOPT -- "$@"
}

apk_Rn() {
  apk del --purge $_TOPT -- "$@"
}

apk_Rns() {
  apk del --purge -r $_TOPT -- "$@"
}

apk_Rs() {
  apk del -r $_TOPT -- "$@"
}

apk_S() {
  case ${_EOPT} in
    # Download only
    ("fetch") shift
              apk fetch $_TOPT -- "$@" ;;
          (*) apk add   $_TOPT -- "$@" ;;
  esac
}

apk_Sc() {
  apk cache -v clean
}

apk_Scc() {
  rm -rf /var/cache/apk/*
}

apk_Sccc() {
  apk_Scc
}

apk_Si() {
  apk_Qi "$@"
}

apk_Sii() {
  apk info -r -- "$@"
}

apk_Sl() {
  apk search -v -- "$@"
}

apk_Ss() {
  apk_Sl "$@"
}

apk_Su() {
  apk upgrade
}

apk_Suy() {
  if [ "$#" -gt 0 ]; then
    apk add -U -u -- "$@"
  else
    apk upgrade -U -a
  fi
}

apk_Sy() {
  apk update
}

apk_Sw() {
  apk fetch $_TOPT -- "$@"
}

apk_U() {
  apk add --allow-untrusted $_TOPT -- "$@"
}
