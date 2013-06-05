#!/usr/bin/env bash

## Update git submodules
echo ">> Updating all git submodules"
git submodule update --init --recursive

## Link all dotfiles from the current directory
echo ">> Creating all symlinks"

toDir=$(pwd)
fromDir=$HOME

for dir in $(ls -a1); do
    # Skip "." and ".."
    if [ "${dir}" == "." ] || [ "${dir}" == ".." ]; then
        continue
    fi

    # Skip some git files that are specific to this repository
    if [ "${dir}" == ".git" ] \
    || [ "${dir}" == ".gitmodules" ] \
    || [ "${dir}" == ".gitignore" ] \
    || [ "${dir}" == ".gitattributes" ]; then
        continue
    fi

    # Skip all "normal" (non hidden) files
    if [ "${dir:0:1}" != "." ]; then
        continue
    fi

    linkFrom="${fromDir}/${dir}"
    linkTo="${toDir}/${dir}"

    rm -rf "${linkFrom}"
    ln -s "${linkTo}" "${linkFrom}"
done
