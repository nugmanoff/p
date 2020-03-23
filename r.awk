NR==FNR {
    A[$1]=1;
    next
}
{
    if ($1 in A) {
        next
    }
    print "linenumber is: "FNR" and "$1
}
