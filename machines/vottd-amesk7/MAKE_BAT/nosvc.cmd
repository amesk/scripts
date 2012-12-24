@echo off
set ORG=%~d0%~p0
call %ORG%_make_common.cmd
set BIN=%OUT_ROOT%\%DEBREL%\BIN

net stop "transas ibs network"
call notrsvr.cmd

del %BIN%\config\default-db\database.dat




