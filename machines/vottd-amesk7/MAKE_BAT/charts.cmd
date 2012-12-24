rem @echo off
echo on

set ORG=%~d0%~p0
call %ORG%nmcfg_common.cmd

set IBSPATCHER=%BIN%\IBSConfig.exe
set HOST=ameskxpnew
set APP=NS3000EI

%IBSPATCHER% set %HOST% %APP% OPTIONS NetSynch string OFF
%IBSPATCHER% set %HOST% %APP% PATHS CHART_1 string E:\NSData\Charts\TX97


