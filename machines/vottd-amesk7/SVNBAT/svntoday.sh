#!/bin/sh
svn up $@ >/dev/null 2>&1
TODAY=`date +%Y-%m-%d`
svn log --revision {`date +%Y-%m-%d`}:HEAD $@
