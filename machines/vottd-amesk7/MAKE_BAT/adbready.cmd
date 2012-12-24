rem @echo off
set ORG=%~d0%~p0
call %ORG%_make_common.cmd
set BIN=%OUT_ROOT%\%DEBREL%\BIN

echo Setting AtomDB ready flag...
%BIN%/ibsconfig set ameskxpnew configuration database ready boolean 1

