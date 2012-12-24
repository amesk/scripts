rem @echo off
echo on

set ORG=%~d0%~p0
call %ORG%nmcfg_common.cmd

set IBSPATCHER=%BIN%\IBSConfig.exe
set HOST=ameskxpnew
set APP=NS3000EI

%IBSPATCHER% set %HOST% %APP% OPTIONS     ExternalWatchDog   boolean  0
%IBSPATCHER% set %HOST% %APP% DEVELOPMENT WatchDog           boolean  0
                                                                       
%IBSPATCHER% set %HOST% %APP% DEVELOPMENT InfoPanelDesign    string    test

%IBSPATCHER% set %HOST% %APP% DEVELOPMENT InfoPanelDesign    boolean   1
%IBSPATCHER% set %HOST% %APP% DEVELOPMENT ShowWarnings       boolean   0
%IBSPATCHER% set %HOST% global PATHS       CHART_1            string    E:\NSData\Charts\TX97
%IBSPATCHER% set %HOST% global PATHS       HYDRO              string    E:\NSData\DATABASES\HYDRO
%IBSPATCHER% set %HOST% global PATHS       ROUTE              string    E:\NSData\DATABASES\Routes
%IBSPATCHER% set %HOST% global PATHS       SHIP               string    E:\NSData\Databases\Ship
%IBSPATCHER% set %HOST% %APP% OPTIONS     ChangeSystemColors boolean   0
%IBSPATCHER% set %HOST% global OPTIONS     ChangeSystemColors boolean   0
%IBSPATCHER% set %HOST% %APP% OPTIONS     SkinDLLName        string    Plastic50
%IBSPATCHER% set %HOST% %APP% OPTIONS     AlarmSound         boolean   0
%IBSPATCHER% set %HOST% %APP% OPTIONS     MayBeVirtPortInput boolean   1
%IBSPATCHER% set %HOST% %APP% OPTIONS     PerfMon            boolean   0
%IBSPATCHER% set %HOST% %APP% PINS        ArcPin             string    9884
%IBSPATCHER% set %HOST% %APP% PINS        SfrPin             string    9884
%IBSPATCHER% set %HOST% %APP% SECURITY    DefaultPassword    string    TRANSASCO
%IBSPATCHER% set %HOST% %APP% SECURITY    ExpirationPeriod   integer   -1
                                                                       
%IBSPATCHER% set %HOST% %APP% OPTIONS     Enable1024x768     boolean   1

%IBSPATCHER% set %HOST% %APP% OPTIONS     GoodByeApp         string    ""

