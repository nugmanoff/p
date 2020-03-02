#!/bin/awk -f
# reports which file is being read
BEGIN {
    print "START\n"
}
/target .* do/{
    print
    print "pod 'somestuff'"
    next
}1
END {
    print "\nEND"
}