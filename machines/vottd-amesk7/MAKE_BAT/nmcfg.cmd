rem @echo off
echo on

set ORG=%~d0%~p0
call %ORG%nmcfg_common.cmd

set ALMCFG=%BIN%\alarmserver.cfg

%PATCHER% %NMCFG% OPTIONS     ExternalWatchDog   OFF
%PATCHER% %NMCFG% DEVELOPMENT WatchDog           OFF

%PATCHER% %NMCFG% DEVELOPMENT InfoPanelDesign    ON
%PATCHER% %NMCFG% DEVELOPMENT ShowWarnings       OFF
%PATCHER% %NMCFG% PATHS       CHART_1            E:\NSData\Charts\TX97
%PATCHER% %NMCFG% PATHS       HYDRO              E:\NSData\DATABASES\HYDRO
rem %PATCHER% %NMCFG% PATHS       ARC                E:\NSData\CHARTS\ARCS
rem %PATCHER% %NMCFG% PATHS       DXCHART            E:\NSData\CHARTS\DXCHARTS
%PATCHER% %NMCFG% PATHS       ROUTE              E:\NSData\DATABASES\Routes
%PATCHER% %NMCFG% PATHS       SHIP               E:\NSData\Databases\Ship
%PATCHER% %NMCFG% OPTIONS     ChangeSystemColors OFF
%PATCHER% %NMCFG% OPTIONS     SkinDLLName        Plastic50
%PATCHER% %NMCFG% OPTIONS     AlarmSound         OFF
%PATCHER% %NMCFG% OPTIONS     MayBeVirtPortInput ON
%PATCHER% %NMCFG% OPTIONS     PerfMon            ON
%PATCHER% %NMCFG% PINS        ArcPin             9884
%PATCHER% %NMCFG% PINS        SfrPin             9884
%PATCHER% %NMCFG% SECURITY    DefaultPassword    TRANSASCO
%PATCHER% %NMCFG% SECURITY    ExpirationPeriod   -1

%PATCHER% %NMCFG%  Network     BcastPortNum      1373
%PATCHER% %ALMCFG% AlarmServer PortNum           1873

%PATCHER% %NMCFG% OPTIONS     Enable1024x768     ON

%PATCHER% --delkey %NMCFG% OPTIONS GoodByeApp

