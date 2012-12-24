@echo off

pushd
set ORG=%~d0%~p0
call %ORG%_make_common.cmd
popd

set GNUdir=E:\NSData\GNUMake
set PerlPath=D:\Perl\bin
set ECDTMP=%__ROOT__:\=/%
set ECDdir=%ECDTMP:/Mak=%
rem set ECDdir=%ECDdir:/Src=%

echo =%__ROOT__%
echo =%ECDTMP%
echo =%ECDdir%

echo set GNUdir=%GNUdir%>%ORG%__sets__.bat
echo set PerlPath=%PerlPath%>>%ORG%__sets__.bat
echo set ECDdir=%ECDdir%>>%ORG%__sets__.bat
set ECD_MKSETS=%ORG%__sets__.bat

echo ============================================================================================
echo ==== ROOT: %OUT_ROOT%
echo ==== MODE: %DEBREL%
echo ============================================================================================

%__ROOT__%\make_.bat %1 %2 %3 %4 %5 %6 %7 %8 %9

