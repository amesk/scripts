@echo off

set ORG=%~d0%~p0
call %ORG%_make_common.cmd

echo Installing patched files for %1...
set BIN=%OUT_ROOT%\%DEBREL%\BIN
copy /Y %BIN%\Patched\%1\*.* %BIN%

