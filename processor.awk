# @descriptoin: podfile contents processor
# @usage: gawk -v param_name=param_value -f script_name source_file
# @params
# pod_name = "Alamofire"
# pattern = "(abstract_)?target .* do/"
# pod_options = "version=0.9;configurations=['Debug','Beta'];modular_headers=true"
# indent = true

# regexpr: 
# /(abstract_)?target .* do/  
# /^\ */ or /^ */

BEGIN {
    print "START\n"
    split(pod_options, arr, ";")
    for (i in arr) {
        n = index(arr[i], "=")
        if (n) {
            options[substr(arr[i], 0, n - 1)] = substr(arr[i], n + 1)
        }
    }
}

$0 ~ pattern {
    match($0, /^ */)
    print
    indentation = indent == "true" ? substr($0, RSTART, RLENGTH)"  " : ""
    base = indentation"pod '"pod_name"'"
    for (key in options) {
        if (key == "version") 
            base = base", '"options[key]"'";
        else if (key == "configurations" || key == "modular_headers" || key == "subspecs" || key == "testspecs") 
            base = base", :"key" => "options[key];
        else 
            base = base", :"key" => '"options[key]"'";
    }
    print base
    next
}

END {
    print "\nEND"
}