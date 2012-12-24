#!/bin/sh
PTH=$1
if [ -z $PTH ] ; then
    PTH=.
fi
MYURL=`svn info $PTH | grep ^URL: | sed -r -s "s/^URL: (.+)\/trunk/\1\/tags/"`
BASICVER=`cat $PTH/application.config|grep PRODUCT_VERSION|sed 's/PRODUCT_VERSION=//'`
svn ls $MYURL|grep version-$BASICVER|sed -r -s 's/version-(.+)\//\1/'|sort|uniq|tail -n 1

