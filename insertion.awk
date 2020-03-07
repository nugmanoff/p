# patterns
# target: /(abstract_)?target .* do/  
# ws amount: /^\ */

# execution
# gawk -v pod_name="" -v pattern="" -f script.awk source-file

BEGIN {
    print "START\n"
}
$0 ~ pattern {
    match($0, /^\ */)
    print 
    print substr($0, RSTART, RLENGTH)"  pod '"pod_name"'"
    next
}1

END {
    print "\nEND"
}