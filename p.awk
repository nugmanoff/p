# @usage: gawk -v param_name=param_value -f script_name source_file
# pod_name = "Alamofire"
# pattern = "(abstract_)?target .* do/"
# pod_options = "version=0.9;configurations=['Debug','Beta'];modular_headers=true"
# indent = true

BEGIN {
    split(pod_options, arr, ";")
    for (i in arr) {
        n = index(arr[i], "=")
        if (n) {
            options[substr(arr[i], 0, n - 1)] = substr(arr[i], n + 1)
        }
    }
}

$0 ~ pattern && !found {
    match($0, /^ */)
    print
    preceding_indentation = substr($0, RSTART, RLENGTH)
    indentation = indent == "true" ? preceding_indentation"  " : preceding_indentation
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
    found = 1
    next
}1
