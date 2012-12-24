@echo off

set ORG=%~d0%~p0
set old_path=%PATH%
set PATH=C:\PROGRA~1\SUBVER~1;H:\OUT_ROOT\htibs-trunk\GNUUtil

pushd %ORG%

sh clsvn.sh %1 %2 %3 %4 %5 %6 %7 %8 %9

popd

set PATH=%old_path%