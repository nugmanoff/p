#!/bin/bash

usage() {
  echo "Usage: shugar [ -a pod_name | -p pattern | -g group | -t target ]"
  exit 2
}

set_pattern() {
  if [[ ! -z "${pattern}" ]]; then
    echo "Pattern is already set"
    usage
  fi

  local varname=$1
  shift

  if [[ $varname == "pattern" ]]; then
    pattern="$@"
  elif [[ $varname == "group" ]]; then
    pattern="((def)|(#)) $@"
  elif [[ $varname == "target" ]]; then
    pattern="(abstract_)?target '$@' do"
  else
    echo "Unkown variable name passed"
  fi
}

while getopts 'a:p:g:t:?h' c
do
  case $c in
    a) pod_name=$OPTARG ;;
    p) set_pattern pattern $OPTARG ;;
    g) set_pattern group $OPTARG ;;
    t) set_pattern target $OPTARG ;;
    h|?) usage ;; esac
done

if [[ -z "${pod_name}" ]]; then
    usage
    exit
fi

output=$(gawk -v pod_name="$pod_name" -v pattern="$pattern" -v indent=true -f processor.awk test/podfile-githawk)
echo "$output" > test/podfile-githawk