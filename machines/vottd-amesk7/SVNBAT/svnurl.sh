#!/bin/sh
svn info $@ | grep ^URL: | sed "s/^URL: //"

