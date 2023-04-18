#!/bin/sh

cd .config
folders=$(ls -1I .)
for folder in $folders
do
    ln -sf .config/$folder ~/.config/$folder
done
