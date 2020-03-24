 {
    split(pod_options, arr, ";")
    for (i in arr) {
        n = index(arr[i], "=")
        if (n) {
            options[substr(arr[i], 0, n - 1)] = substr(arr[i], n + 1)
        }
    }
    list = "#;inherit!;install!;platform;project;inhibit_all_warnings!;use_modular_headers!;use_frameworks!;supports_swift_versions;source"
    split(list, raw, ";")
    for (r in raw) {
        reserved[raw[r]] = 1;
    }
}

# if pattern is root, then we say that we have a match at line 1
pattern == "root" && !found {
    found_at_currentline()
}

# if match was at line 1 and current line is either a comment or whitespace we skip
(/^\s*$/ || $1 == "#") && found == 1 {
    print_and_next()
}

# if we have match and it is our first time, then we say that we have a match at current line
$0 ~ pattern && !found {
    found_at_currentline()
    print_and_next()
}

# if we have match (root or pattern) and pod was not yet inserted - then we skip reserved lines
found && $1 in reserved && !inserted {
    found_at_currentline()
    print_and_next()
}

# after all skipping and matching is done we insert pod
found {
    insert_pod_if_needed()
}

# fallthrough case if no expression gets triggered - just print the current line
{
    prev_line = $0
    print
}

# in case if we reached EOF and didn't yet inserted pod (rare case) - insert it right now
END {
    insert_pod_if_needed()
}

function print_and_next() {
    prev_line = $0
    print
    next
}

function found_at_currentline() {
    found = NR
}

function insert_pod_if_needed() {
    if (inserted) { return }
    inserted = 1
    prev_line = pattern == "root" ? "" : prev_line
    match(prev_line, /^ */)
    preceding_indentation = substr(prev_line, RSTART, RLENGTH)
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
