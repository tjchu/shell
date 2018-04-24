#!/bin/bash
set -euo pipefail

usage="$(basename "$0") [-h] [-s n] -- program to calculate the directories in your Macbook with the highest disk usage

where:
    -h  show this help text
    -n  find top # of directories with highest disk usage (default: 5)"

files=5
while getopts ':hn:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    n) files=$OPTARG
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

echo "Finding the top $files files with the highest disk usage in your MacBook..."


userdir=`whoami`
echo "Here are the results..."
du -hs /Users/$userdir/* | sort -rh | head -$files

echo " " && echo "Thank you."