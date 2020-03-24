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
    list="#;install!;platform;project;inhibit_all_warnings!;use_modular_headers!;use_frameworks!;supports_swift_versions;source"
    split(list, raw, ";")
    for (r in raw) {
        reserved[raw[r]] = 1;
    }
}

# if pattern is root, then we say that we have a match at line 1
pattern == "root" && !found {
    found = NR
}

# if match was at line 1 and current line is either a comment or whitespace we skip
/^\s*$/ || $1 == "#" && found == 1 {
    print
    next
}

# 
$0 ~ pattern && !found {
    found = NR
    print
    next
}

found && $1 in reserved && !inserted {
    print
    next
}

found {
    insert_pod_if_needed()
}

{
    print
}

END {
    insert_pod_if_needed()
}

function insert_pod_if_needed() {
    if (inserted) { return }
    inserted = 1
    match($0, /^ */)
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
}
