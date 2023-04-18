#!/bin/sh

folders=$(ls .config)
for folder in $folders
do
    ln -sf .config/$folder ~/.config/$folder
done
