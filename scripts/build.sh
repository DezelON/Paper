#!/usr/bin/env bash

(
set -e
basedir="$(cd "$1" && pwd -P)"
gitcmd="git -c commit.gpgsign=false"

if [ "$2" != "--gravit" ]; then
    ($gitcmd submodule update --init && ./scripts/remap.sh "$basedir" && ./scripts/decompile.sh "$basedir" && ./scripts/init.sh "$basedir" && ./scripts/applyPatches.sh "$basedir") || (
        echo "Failed to build Paper"
        exit 1
    ) || exit 1
fi
if [ "$2" == "--jar" ] || [ "$2" == "--gravit" ]; then
    mvn clean install && ./scripts/paperclip.sh "$basedir"
fi
) || exit 1
