#!/bin/sh
svn info $@ | grep \^Last\ Changed\ Rev: | sed 's/^.*\ \([[:digit:]]\+\)$/\1/'

