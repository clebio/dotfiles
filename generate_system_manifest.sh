#/bin/bash
#dpkg -l | tail -n +6 | cut -d ' ' -f 3 | xargs
(zcat $(ls -tr /var/log/apt/history.log*.gz); cat var/log/apt/history.log) | \
    egrep '^(Start-Date:|Commandline:)' | \
    grep -v aptdaemon | \
    egrep '^Commandline:' | \
    sed 's/--\w* //g' |\
    cut -d ' ' -f 4 | \
    sort -u 
