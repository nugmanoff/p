#!/bin/bash

usage()
{
  echo "Usage: shugar [ -a pod_name | -p pattern | -g group ]"
  exit 2
}

while getopts 'a:p:g:?h' c
do
  case $c in
    a) pod_name=$OPTARG ;;
    p) pattern=$OPTARG ;;
    g) group=$OPTARG ;;
    h|?) usage ;; esac
done

if [[ -z "${pod_name}" ]]; then
    usage
    exit
fi

if [[ -z "${!pattern}" ]]; then
    pattern="(abstract_)?target .* do"
fi

if [[ -z "${!group}" ]]; then
    pattern=".* $group"
    echo $group
fi

gawk -v pod_name="$pod_name" -v pattern="$pattern" -v indent=false -f processor.awk test/podfile-githawk