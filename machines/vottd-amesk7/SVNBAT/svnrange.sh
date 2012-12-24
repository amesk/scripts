#!/bin/sh
REPOURL=`svnurl.sh $@`
HEADREV=`svn log --revision HEAD:1 --stop-on-copy $REPOURL | grep '^r[[:digit:]]\+' | sed 's/^r\([[:digit:]]\+\).*$/\1/' | sort -g | head -1`
TAILREV=`svn log --revision HEAD:1 --stop-on-copy $REPOURL | grep '^r[[:digit:]]\+' | sed 's/^r\([[:digit:]]\+\).*$/\1/' | sort -g | tail -1`
echo $HEADREV:$TAILREV
