@echo off
set ORG=%~d0%~p0
call %ORG%nmcfg_common.cmd
start notepad %NMCFG%

