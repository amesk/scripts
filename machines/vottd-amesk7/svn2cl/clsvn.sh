#!/bin/sh
# clsvn - frontend shell script for SVN changelog generation based on standard
# trunk/tags/branches structure
# 
# Copyright (C) 2007 Alexei M. Eskenazi.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in
#    the documentation and/or other materials provided with the
#    distribution.
# 3. The name of the author may not be used to endorse or promote
#    products derived from this software without specific prior
#    written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
# GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
# IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


# exit on any failures
set -e
# report unset variables
set -u

# version
VERSION="0.2"

SVN_URL=
PATTERN=
ENTRIES=100
CHANGELOG=-
ORIGINAL_ENCODING=cp866
ENCODING=cp866
WIDTH=75
SVN_DIR_ARGS=
TAG_PREFIX=version-

prog=`basename $0`

function show_version() {
cat<<-EOT
	$prog $VERSION
	Written by Alexei M. Eskenazi.
    
	Copyright (C) 2007 Alexei M. Eskenazi.
	This is free software; see the source for copying conditions.  There is NO
	warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
EOT
}

function show_help() {
cat<<-EOT
	Usage: $prog [OPTION]... PATH ...
    
	Generate a ChangeLog from a subversion repository.
    
	PATH				 SVN URL
    
	Options:
	  -o, --output=FILE    output to FILE instead of stdout (by default)
	  -f, --file=FILE      alias for -o, --output
	  -w, --width=NUM      make report lines no longer than NUM
	  --entries=NUM 	     dump no more than NUM tags
	  --pattern=TAG 	     dump only tags that match TAG pattern
	  --encoding=CODE      set output encoding ad CODE
						             acceptable: utf-8, cp866, windows-1251
    --no-tag-prefix      removes "version-" prefix for non-NavTech tags
	  -h, --help		       display this help and exit
	  -V, --version 	     output version information and exit
    
	PATH arguments and the following options are passed to the svn log
	command: --stop-on-copy, --username,
	--password, --no-auth-cache, --non-interactive, --config-dir and
	--limit (see \`svn help log' for more information).
    
	Examples:
		$prog --encoding=cp866 --pattern=1.11.005 --entries=5 \
		https://svn.transas.com/navtech-primary/htibs/branches/release-1.11.005
EOT
}

if [ $# -eq 0 ] ; then
	show_help
	exit 1
fi

# do command line checking
while [ $# -gt 0 ]
do
  case "$1" in
	-d|--debug)
	  set -x
	  shift
	  ;;
	-w|--width)
	  WIDTH="$2"
	  shift 2 || { echo "$prog: option requires an argument -- $1";exit 1; }
	  ;;
	--WIDTH=*)
	  PATTERN=`echo "$1" | sed 's/^--[a-z-]*=//'`
	  shift
	  ;;
	--pattern)
	  PATTERN="$2"
	  shift 2 || { echo "$prog: option requires an argument -- $1";exit 1; }
	  ;;
	--pattern=*)
	  PATTERN=`echo "$1" | sed 's/^--[a-z-]*=//'`
	  shift
	  ;;
	--entries)
	  ENTRIES="$2";
	  shift 2 || { echo "$prog: option requires an argument -- $1";exit 1; }
	  ;;
	--entries=*)
	  ENTRIES=`echo "$1" | sed 's/^--[a-z-]*=//'`
	  shift
	  ;;
	-f|--file|-o|--output)
	  CHANGELOG="$2"
	  shift 2 || { echo "$prog: option requires an argument -- $1";exit 1; }
	  ;;
	--file=*|--output=*)
	  CHANGELOG=`echo "$1" | sed 's/^--[a-z-]*=//'`
	  shift
	  ;;
	--encoding)
	  ENCODING="$2"
	  shift 2 || { echo "$prog: option requires an argument -- $1";exit 1; }
	  ;;
	--encoding=*)
	  ENCODING=`echo "$1" | sed 's/^--[a-z-]*=//'`
	  shift
	  ;;
	--username=*|--password=*|--config-dir=*)
	  # these are single argument versions of the above
	  arg=`echo "$1" | sed "s/'/'\"'\"'/g"`
	  SVN_DIR_ARGS="$SVNLOGCMD '$arg'"
	  # also add to svn info command
	  SVNINFOCMD="$SVNINFOCMD '$arg'"
	  shift
	  ;;
	--limit)
	  # add these as extra options to the command (with argument)
	  arg=`echo "$2" | sed "s/'/'\"'\"'/g"`
	  SVN_DIR_ARGS="$SVNLOGCMD $1 '$arg'"
	  shift 2 || { echo "$prog: option requires an argument -- $1";exit 1; }
	  ;;
	--limit=*)
	  # these are single argument versions of the above
	  arg=`echo "$1" | sed "s/'/'\"'\"'/g"`
	  SVN_DIR_ARGS="$SVNLOGCMD '$arg'"
	  shift
	  ;;
	--stop-on-copy)
	  # add these as simple options
	  SVN_DIR_ARGS="$SVNLOGCMD $1"
	  shift
	  ;;

	--no-auth-cache|--non-interactive)
	  # add these as simple options
	  SVN_DIR_ARGS="$SVNLOGCMD $1"
	  shift
	  ;;
	--no-tag-prefix)
	  # add these as simple options
	  TAG_PREFIX=
	  shift
	  ;;
	-V|--version)
	  show_version
	  exit 0
	  ;;
	-h|--help)
	  show_help
	  exit 0
	  ;;
	-*)
	  echo "$prog: invalid option -- $1"
	  echo "Try \`$prog --help' for more information."
	  exit 1
	  ;;
	*)
	  arg=`echo "$1" | sed "s/'/'\"'\"'/g"`
	  SVN_URL=$arg
	  shift
	  ;;
  esac
done 

# find the directory that this script resides in
prog="$0"
while [ -h "$prog" ]
do
	dir=`dirname "$prog"`
	prog=`ls -ld "$prog" | sed "s/^.*-> \(.*\)/\1/;/^[^/]/s,^,$dir/,"`
done
dir=`dirname "$prog"`
dir=`cd "$dir" && pwd`

REV_TEMP_FILE="$dir/tags.txt"

rm -f "$REV_TEMP_FILE"

svn $SVN_DIR_ARGS -v ls "$SVN_URL/tags" \
| sed "s/  \([0-9]\+\).\+$TAG_PREFIX\(.\+\)\//\2 \1/" \
| sort -r | grep "$PATTERN" | head -n $ENTRIES>"$REV_TEMP_FILE"

NEXTREV=
NEXTTAG=
REVRANGE=

# redirect stdout to the changelog file if needed
if [ "x$CHANGELOG" != "x-" ]
then
	exec > "$CHANGELOG"
fi 

AWK_SCRIPT='BEGIN { ignore=0; start=0; }
/^-+$/ { ignore=1 }
/^r[0-9]+ \| [a-zA-Z_]+/ { ignore=1; start=1; }
{ 
	if(ignore == 0) { 
		if(start == 1) print "* "$0 
		else print "  " $0; 
		start=0; 
	} 
	ignore=0
}'

while read TAG REV; do
	if [ ! -z "$NEXTREV" ] ; then
		REVRANGE="$((REV+1)):$NEXTREV"
		BDATE=`svn info $SVN_URL/tags/$TAG_PREFIX$NEXTTAG\
		       | grep "Date" | gawk '{print substr($0,20,20) }'`
		BUILD_SIGN="Build $NEXTTAG ($REVRANGE) at $BDATE"
		echo $BUILD_SIGN
		echo $BUILD_SIGN | sed 's/./-/g'
		echo ""

		svn log $SVN_DIR_ARGS -r $REVRANGE "$SVN_URL/trunk" \
		| sed '/^ *$/d; /\.\.\.\.\.\.\.\./d' \
		| gawk "$AWK_SCRIPT" \
		| fold -s -w $WIDTH \
		| gawk '/^[^ *B\-]/ { printf("  ")} {print}' \
		| iconv -f $ORIGINAL_ENCODING -t $ENCODING

		echo ""
	fi
	NEXTREV=$REV
	NEXTTAG=$TAG
done < "$REV_TEMP_FILE"

rm -f "$REV_TEMP_FILE"

