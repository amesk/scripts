@echo off
set ORG=%~d0%~p0
call %ORG%_make_common.cmd
call %ORG%nosvc.cmd
call %ORG%svc.cmd

