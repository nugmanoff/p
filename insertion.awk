#!/bin/awk -f 
# patterns
# target: /(abstract_)?target .* do/  
# ws amount: /^\ */

BEGIN {
    print "START\n"
}
/(abstract_)?target .* do/   {
    match($0, /^\ */)
    print 
    print substr($0, RSTART, RLENGTH)"  pod '"pod_name"'"
    next
}1

END {
    print "\nEND"
}