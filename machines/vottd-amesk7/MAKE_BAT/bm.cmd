@echo off
set ORG=%~d0%~p0
call %ORG%_make_common.cmd
pushd %__ROOT__%
call %ORG%_make_ -s %2 %3 MODULES+%1
popd

