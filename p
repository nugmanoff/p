#!/usr/bin/env sh
# @TODO \n are missing in the resulting podfile when command is run

# configuration keywords:
# install!
# platform
# project
# inhibit_all_warnings!
# use_modular_headers!
# use_frameworks!
# supports_swift_versions
# source

DEFAULT_PFILE_NAME="PODFILE"

usage() {
  echo "Usage: p [ -a pod_name | -p pattern | -g group | -t target | -f filepath ]"
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

while getopts 'a:f:p:g:t:?h' c
do
  case $c in
    a) pod_name=$OPTARG ;;
    f) filepath=$OPTARG ;;
    p) set_pattern pattern $OPTARG ;;
    g) set_pattern group $OPTARG ;;
    t) set_pattern target $OPTARG ;;
    h|?) usage ;; esac
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

output=$(gawk -v pod_name="$pod_name" -v pattern="$pattern" -v indent=true -e "BEGIN {

    split(pod_options, arr, \";\")
    for (i in arr) {
        n = index(arr[i], \"=\")
        if (n) {
            options[substr(arr[i], 0, n - 1)] = substr(arr[i], n + 1)
        }
    }
}

\$0 ~ pattern && !found {
    match(\$0, /^ */)
    print
    preceding_indentation = substr(\$0, RSTART, RLENGTH)
    indentation = indent == \"true\" ? preceding_indentation\"  \" : preceding_indentation
    base = indentation\"pod '\"pod_name\"'\"
    for (key in options) {
        if (key == \"version\") 
            base = base\", '\"options[key]\"'\";
        else if (key == \"configurations\" || key == \"modular_headers\" || key == \"inhibit_warnings\" || key == \"subspecs\" || key == \"testspecs\") 
            base = base\", :\"key\" => \"options[key];
        else 
            base = base\", :\"key\" => '\"options[key]\"'\";
    }
    print base
    found = 1
    next
}1" $filepath)

echo "$output" > $filepath