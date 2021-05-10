#!/usr/bin/env zsh

mkpasswd() {
    local num=${1:-12}
    openssl rand -base64 $num | fold -w $num | head -1
}
