#!/bin/sh
svn info $@ |grep ^URL: | sed "s/^URL: //"
svn log -r 1:HEAD $@ | grep \^r[[:digit:]\+] | sed 's/^r\([[:digit:]]*\)\ |\ \([[:alnum:]]*\).*$/\2/' | sort | uniq --count | sort -g
