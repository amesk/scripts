@echo off

set ORG=%~d0%~p0
call %ORG%nmcfg_common.cmd

%PATCHER% %NMCFG% COM_PORT    PS1                41
%PATCHER% %NMCFG% COM_PORT    Compass            41
%PATCHER% %NMCFG% COM_PORT    Log                41
%PATCHER% %NMCFG% COM_PORT    Sounder            48
%PATCHER% %NMCFG% COM_PORT    ARPA-A             49

