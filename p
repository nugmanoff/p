#!/usr/bin/env sh
# @TODO \n are missing in the resulting podfile when command is run

DEFAULT_PFILE_NAME="PODFILE"

usage() {
  echo "Usage: p [ -a pod_name | -p pattern | -g group | -t target | -f filepath | -d debug]"
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

while getopts 'a:f:p:g:t:?hd' c
do
  case $c in
    a) pod_name=$OPTARG ;;
    f) filepath=$OPTARG ;;
    p) set_pattern pattern $OPTARG ;;
    g) set_pattern group $OPTARG ;;
    t) set_pattern target $OPTARG ;;
    d) debug=true ;;
    h|?) usage ;;
 esac
done

if [[ -z "${pod_name}" ]]; then
    usage
    exit
fi

if [[ ! -z "$filepath" && -f "$filepath" ]]; then
  :
elif [[ -f $DEFAULT_PFILE_NAME ]]; then
  filepath=$DEFAULT_PFILE_NAME
else
  echo "No Podfile found"
  exit
fi

output=$(gawk -v pod_name="$pod_name" -v pattern="$pattern" -v indent=false -e "$(cat p.awk)" $filepath)

if [[ $debug ]]; then
    echo "$output"
else
    echo "$output" > $filepath
fi
