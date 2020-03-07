# !!! patterns
# target: /(abstract_)?target .* do/  
# ws amount: /^\ */ or /^ */
# !!! execution
# gawk -v pod_name="" -v pattern="" -f script.awk source-file
# !!! key-value passing (delimeter is ;)
# -v pod_options="version=0.9;configurations=['Debug','Beta'];modular_headers=true"

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
    base = substr($0, RSTART, RLENGTH)"  pod '"pod_name"'"
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