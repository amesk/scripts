@echo off

set ORG=%~d0%~p0
call %ORG%nmcfg_common.cmd

%PATCHER% %NMCFG% COM_PORT    PS1                0
%PATCHER% %NMCFG% COM_PORT    Compass            0
%PATCHER% %NMCFG% COM_PORT    Log                0
%PATCHER% %NMCFG% COM_PORT    Sounder            0
%PATCHER% %NMCFG% COM_PORT    ARPA-A             0

