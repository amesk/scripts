@echo off
set ORG=%~d0%~p0
set ROOTDIR=%1
if "%ROOTDIR%."=="." set ROOTDIR=%CD%
echo set __ROOT__=%ROOTDIR%>%ORG%dirstore.cmd

