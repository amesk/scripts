set ORG=%~d0%~p0
call %ORG%_make_common.cmd

set BIN=%OUT_ROOT%\%DEBREL%\BIN
set PATCHER=%ORG%\PatchIni.EXE
set BIN=%OUT_ROOT%\%DEBREL%\bin
set NMCFG=%BIN%\nm.cfg

