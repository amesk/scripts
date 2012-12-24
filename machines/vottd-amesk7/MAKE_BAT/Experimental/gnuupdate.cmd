@echo off

set FORCE_UPDATE=
set QUIET_MODE=

call :GetOutRoot
echo OUT_ROOT=%OUT_ROOT%
goto :eof

if "%3." == "force." set FORCE_UPDATE=YES
rem if "%3." == "quiet." set QUIET_MODE=YES

if "%4." == "force." set FORCE_UPDATE=YES
rem if "%4." == "quiet." set QUIET_MODE=YES

set GNU_DST=%1
set GNU_SRC=%2

if "%GNU_DST%." == "." set GNU_DST=%GNUdir%
if "%GNU_DST%." == "." set GNU_SRC=%GNUdir_Source%

rem These variables must be defined before proceeding

if "%GNU_DST%." == "." set GNU_DST=C:\Win32App\GnuMake1
if "%GNU_SRC%." == "." set GNU_SRC=\\coup\nsdata\GNU\4.00.001

if not exist %GNU_DST% mkdir %GNU_DST%

call :GetVersion %GNU_DST%\VERSION.TXT
set LOCAL_VER=%VERS%
call :GetVersion %GNU_SRC%\VERSION.TXT
set REMOTE_VER=%VERS%

call :DumpStr Versions detected: %LOCAL_VER% (local) %REMOTE_VER%(remote)

rem force updating
if not "%FORCE_UPDATE%." == "YES." goto :noforce
    set LOCAL_VER=
    echo Update forced
:noforce

rem we don't have source for updating
if not "%REMOTE_VER%." == "none." goto :noremote
    call :DumpStr No remote data present
    goto :eof
:noremote

rem already OK
if not "%REMOTE_VER%." == "%LOCAL_VER%." goto :nomatch
    call :DumpStr Versions matched
    goto :eof
:nomatch

rem processing

pushd %GNU_DST%

call :DumpStr Cleaning destination...
del /F /S /Q *.* >nul
call :DumpStr Copying package content...
copy %GNU_SRC%\*.* %GNU_DST% >nul
call :DumpStr Installing...
if exist %GNU_DST%\InstallAll.cmd call %GNU_DST%\InstallAll.cmd>nul
call :DumpStr Cleaning...
if exist %GNU_DST%\PostInstall.cmd call %GNU_DST%\PostInstall.cmd>nul

popd

goto :eof

rem =============================================================================================
rem GetVersion subroutine
rem PURPOSE : Stores component version from %1 file in %VERS% variable
rem =============================================================================================

:GetVersion
set VERS=none
for /F "tokens=1,2,3,4,5,6* delims=." %%i in (%1) do call :getversion0 %%i %%j %%k %%l %%m %%n
:getversion0
if -%1==-Version: goto getversion1
goto :eof
:getversion1
set VERS=%2.%3.%4
goto :eof

rem =============================================================================================
rem DumpStr subroutine
rem PURPOSE dumps strings depending on verbose/quiet mode
rem =============================================================================================
:DumpStr
if "%QUIET_MODE%." == "YES." goto :eof
echo %1 %2 %3 %4 %5 %6 %7 %8 %9
goto :eof

rem =============================================================================================
rem GetOutRoot subroutine
rem PURPOSE : Reads OUT_ROOT location from .config. Stores it in %OUT_ROOT% variable
rem =============================================================================================
:GetOutRoot
set OUT_ROOT=none
set ORG=%~d0%~p0
set DOT_CONFIG=%ORG%.config
for /F "tokens=1,2,3,4,5,6* delims=." %%i in (%DOT_CONFIG%) do call :GetOutRoot0 %%i %%j %%k %%l %%m %%n
:GetOutRoot0
if -%1==-Version: goto GetOutRoot1
goto :eof
:getversion1
set OUT_ROOT=%2.%3.%4
goto :eof
