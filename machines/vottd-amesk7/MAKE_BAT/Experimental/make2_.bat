@echo off

set GNUdir=C:\Win32App\GnuMake1
set PerlPath=C:\Win32App\perl\bin

if "%NS_BUILD_NUM%" == "" set NS_BUILD_NUM=4999

set ECDdir=D:/Projects/Transas/NavyV

if "%ECD_MKSETS%" == "" goto no_ECD_MKSETS
  echo .
  echo !! Found Env var ECD_MKSETS! Use config: %ECD_MKSETS% !!
  echo .
  call %ECD_MKSETS%
:no_ECD_MKSETS

set include=
set lib=

set OLD_PATH=%path%
set path=%GNUdir%\local;%GNUdir%;%PerlPath%

set MAKEFILES=%ECDdir%/Mak/_Mak_/_Startup.Mak

set GMAKE_SH_PARAM= -r %1 %2 %3 %4 %5 %6 %7 %8 %9

rem --- «десь нужно делать update tool'ов и _Mak_'ов

rem sh -c "%ECDdir%/Mak/_Mak_/Gmake_.sh"
%PerlPath%\perl -w -I%ECDdir%/Mak/_Mak_ %ECDdir%/Mak/_Mak_/Gmake_.pl

set err=%errorlevel%
set path=%OLD_PATH%
exit /B %err%