@echo off
if -%1-==-- (
     echo branch name needed
     goto :eof
)
set NAME=%1
mkdir %NAME%
cd %NAME%
svn --depth=empty co https://svn.transas.com/packages/lcwrap/branches .
mkdir %NAME%
svn add %NAME%
cd %NAME%
mkdir tags
svn add tags
mkdir branches
svn add branches
svn cp https://svn.transas.com/navtech-primary/packages/lcwrap/trunk trunk

