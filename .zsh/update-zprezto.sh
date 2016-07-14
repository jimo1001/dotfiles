#!/bin/bash

set -eux

pushd ${ZDOTDIR:-$HOME}/.zprezto
git pull && git submodule foreach git pull origin master
popd

