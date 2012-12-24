@echo off
setlocal
set PATH=%~d0%~p0;H:\OUT_ROOT\htibs-trunk\GNUUtil;H:\OUT_ROOT\htibs-trunk\GNUUtil\local;C:\Program Files\Subversion
sh %~d0%~p0%1.sh %2 %3 %4 %5 %6 %7 %8 %9

