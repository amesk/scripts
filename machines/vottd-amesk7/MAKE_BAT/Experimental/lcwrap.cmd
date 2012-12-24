@echo off
rem
rem  Copyright   (C) 1999-2003  Transas Marine LTD, St.Petersburg.
rem  Transas Software House.    Navigation  Technology Department.
rem
rem  Project : LcWrap package creation script
rem
rem  File    :    lcwrap.cmd
rem  Creation:    08.08.2003, Amesk
rem
rem  Params:      <none>
rem

rem ==============================================================================================
rem Paths

set OUT_ROOT=E:\OUT_ROOT
set ECDdir=E:\Projects\NavyV

set RARPATH=C:\Progra~1\WinRAR
set VERSION=1.01.02
set OUT= %OUT_ROOT%\LcWrap

rem ==============================================================================================
rem Prepare place

if not exist %OUT% mkdir %OUT%

rmdir /S /Q %OUT%

rem ==============================================================================================
rem Copying sources

mkdir %OUT%\Src
mkdir %OUT%\Include

copy %ECDdir%\Src\Util\LcWrap\1_0\LcWrap\*.* %OUT%\Src

copy %ECDdir%\Src\Util\LcWrap\1_0\LcWrap\GetDefaultMappingName.cpp %OUT%\Src
copy %ECDdir%\Src\Util\LcWrap\1_0\LcWrap\GetLicenseRootDir.cpp     %OUT%\Src
copy %ECDdir%\Src\Util\LcWrap\1_0\LcWrap\LcHelp.cpp                %OUT%\Src
copy %ECDdir%\Src\Util\LcWrap\1_0\LcWrap\LcHelp.h                  %OUT%\Src
copy %ECDdir%\Src\Util\LcWrap\1_0\LcWrap\lcwrap.cmd                %OUT%\Src
copy %ECDdir%\Src\Util\LcWrap\1_0\LcWrap\LcWrap.cpp                %OUT%\Src
copy %ECDdir%\Src\Util\LcWrap\1_0\LcWrap\permits.h                 %OUT%\Src
copy %ECDdir%\Src\Util\LcWrap\1_0\LcWrap\StdAfx.cpp                %OUT%\Src
copy %ECDdir%\Src\Util\LcWrap\1_0\LcWrap\StdAfx.h                  %OUT%\Src
copy %ECDdir%\Src\Util\LcWrap\1_0\LcWrap\TS100Wrap.cpp             %OUT%\Src

copy %ECDdir%\Src\Util\LcWrap\1_0\LcWrap\LcWrap.h                  %OUT%\Include

copy %ECDdir%\Lib\Protect\Include\cipherio.h                       %OUT%\Src
copy %ECDdir%\Lib\Protect\Include\license.h                        %OUT%\Src
copy %ECDdir%\Lib\Protect\Include\LsErrors.h                       %OUT%\Src

del %OUT%\Src\vssver.scc

rem ==============================================================================================
rem Copying Makefile

mkdir %OUT%\Mak
mkdir %OUT%\Mak\LcWrapBO
mkdir %OUT%\Mak\LcWrapMS

copy %ECDdir%\Mak\Util\LcWrap\1_0\LcWrap\Makefile %OUT%\Mak
copy %ECDdir%\Mak\Util\LcWrap\1_0\LcWrap\LcWrapMS\Makefile %OUT%\Mak\LcWrapMS
copy %ECDdir%\Mak\Util\LcWrap\1_0\LcWrap\LcWrapBO\Makefile %OUT%\Mak\LcWrapBO

copy %ECDdir%\Mak\Util\LcWrap\1_0\LcWrap\LcWrapCommon.mak %OUT%\Mak

rem ==============================================================================================
rem Copying binaries

mkdir %OUT%\Lib
mkdir %OUT%\Lib\Debug
mkdir %OUT%\Lib\Debug\MS
mkdir %OUT%\Lib\Debug\BO
mkdir %OUT%\Obj
mkdir %OUT%\Obj\Debug
mkdir %OUT%\Obj\Debug\MS
mkdir %OUT%\Obj\Debug\BO

copy %OUT_ROOT%\Debug\lib\LcWrap10lib.lib     %OUT%\Lib\Debug\MS

copy %ECDdir%\Lib\Protect\w32md\ciosx.lib     %OUT%\Lib\Debug\MS
copy %ECDdir%\Lib\Protect\w32md\acio.lib      %OUT%\Lib\Debug\MS
copy %ECDdir%\Lib\Protect\w32md\acios.lib     %OUT%\Lib\Debug\MS
copy %ECDdir%\Lib\Protect\w32md\aciosx.lib    %OUT%\Lib\Debug\MS
copy %ECDdir%\Lib\Protect\w32md\cios.lib      %OUT%\Lib\Debug\MS
copy %ECDdir%\Lib\Protect\w32md\ciosx.lib     %OUT%\Lib\Debug\MS
copy %ECDdir%\Lib\Protect\w32md\cipherio.lib  %OUT%\Lib\Debug\MS
copy %ECDdir%\Lib\Protect\w32md\crypt.lib     %OUT%\Lib\Debug\MS
copy %ECDdir%\Lib\Protect\w32md\dlb.lib       %OUT%\Lib\Debug\MS
copy %ECDdir%\Lib\Protect\w32md\lcfile.lib    %OUT%\Lib\Debug\MS
copy %ECDdir%\Lib\Protect\w32md\nlicense.lib  %OUT%\Lib\Debug\MS
copy %ECDdir%\Lib\Protect\w32md\ppclc.lib     %OUT%\Lib\Debug\MS
copy %ECDdir%\Lib\Protect\w32md\sprow32m.lib  %OUT%\Lib\Debug\MS
copy %ECDdir%\Lib\Protect\w32md\ssicm32n.lib  %OUT%\Lib\Debug\MS
copy %ECDdir%\Lib\Protect\w32md\ssocm32.lib   %OUT%\Lib\Debug\MS

copy %OUT_ROOT%\Debug\Util\LcWrap\1_0\LcWrap\LcWrapMS\LcHelp.obj %OUT%\Obj\Debug\MS

rem Borland version

copy %OUT_ROOT%\Debug\lib\LcWrap10libb.lib    %OUT%\Lib\Debug\BO

copy %ECDdir%\Lib\Protect\w32b5\ciosx.lib     %OUT%\Lib\Debug\BO
copy %ECDdir%\Lib\Protect\w32b5\acio.lib      %OUT%\Lib\Debug\BO
copy %ECDdir%\Lib\Protect\w32b5\acios.lib     %OUT%\Lib\Debug\BO
copy %ECDdir%\Lib\Protect\w32b5\aciosx.lib    %OUT%\Lib\Debug\BO
copy %ECDdir%\Lib\Protect\w32b5\cios.lib      %OUT%\Lib\Debug\BO
copy %ECDdir%\Lib\Protect\w32b5\ciosx.lib     %OUT%\Lib\Debug\BO
copy %ECDdir%\Lib\Protect\w32b5\cipherio.lib  %OUT%\Lib\Debug\BO
copy %ECDdir%\Lib\Protect\w32b5\crypt.lib     %OUT%\Lib\Debug\BO
copy %ECDdir%\Lib\Protect\w32b5\dlb.lib       %OUT%\Lib\Debug\BO
copy %ECDdir%\Lib\Protect\w32b5\lcfile.lib    %OUT%\Lib\Debug\BO
copy %ECDdir%\Lib\Protect\w32b5\nlicense.lib  %OUT%\Lib\Debug\BO
copy %ECDdir%\Lib\Protect\w32b5\ppclc.lib     %OUT%\Lib\Debug\BO
copy %ECDdir%\Lib\Protect\w32b5\sprow32b.lib  %OUT%\Lib\Debug\BO
copy %ECDdir%\Lib\Protect\w32b5\ssicb32n.lib  %OUT%\Lib\Debug\BO
copy %ECDdir%\Lib\Protect\w32b5\ssocb32.lib   %OUT%\Lib\Debug\BO

copy %OUT_ROOT%\Debug\Util\LcWrap\1_0\LcWrap\LcWrapBO\LcHelp.obj %OUT%\Obj\Debug\BO

mkdir %OUT%\Lib\Release
mkdir %OUT%\Lib\Release\MS
mkdir %OUT%\Lib\Release\BO
mkdir %OUT%\Obj\Release
mkdir %OUT%\Obj\Release\MS
mkdir %OUT%\Obj\Release\BO

copy %OUT_ROOT%\Release\lib\LcWrap10lib.lib %OUT%\Lib\Release\MS

copy %ECDdir%\Lib\Protect\w32md\ciosx.lib     %OUT%\Lib\Release\MS
copy %ECDdir%\Lib\Protect\w32md\acio.lib      %OUT%\Lib\Release\MS
copy %ECDdir%\Lib\Protect\w32md\acios.lib     %OUT%\Lib\Release\MS
copy %ECDdir%\Lib\Protect\w32md\aciosx.lib    %OUT%\Lib\Release\MS
copy %ECDdir%\Lib\Protect\w32md\cios.lib      %OUT%\Lib\Release\MS
copy %ECDdir%\Lib\Protect\w32md\ciosx.lib     %OUT%\Lib\Release\MS
copy %ECDdir%\Lib\Protect\w32md\cipherio.lib  %OUT%\Lib\Release\MS
copy %ECDdir%\Lib\Protect\w32md\crypt.lib     %OUT%\Lib\Release\MS
copy %ECDdir%\Lib\Protect\w32md\dlb.lib       %OUT%\Lib\Release\MS
copy %ECDdir%\Lib\Protect\w32md\lcfile.lib    %OUT%\Lib\Release\MS
copy %ECDdir%\Lib\Protect\w32md\nlicense.lib  %OUT%\Lib\Release\MS
copy %ECDdir%\Lib\Protect\w32md\ppclc.lib     %OUT%\Lib\Release\MS
copy %ECDdir%\Lib\Protect\w32md\sprow32m.lib  %OUT%\Lib\Release\MS
copy %ECDdir%\Lib\Protect\w32md\ssicm32n.lib  %OUT%\Lib\Release\MS
copy %ECDdir%\Lib\Protect\w32md\ssocm32.lib   %OUT%\Lib\Release\MS

copy %OUT_ROOT%\Release\Util\LcWrap\1_0\LcWrap\LcWrapMS\LcHelp.obj %OUT%\Obj\Release\MS

rem Borland version

copy %OUT_ROOT%\Release\lib\LcWrap10libb.lib %OUT%\Lib\Release\BO

copy %ECDdir%\Lib\Protect\w32b5\ciosx.lib     %OUT%\Lib\Release\BO
copy %ECDdir%\Lib\Protect\w32b5\acio.lib      %OUT%\Lib\Release\BO
copy %ECDdir%\Lib\Protect\w32b5\acios.lib     %OUT%\Lib\Release\BO
copy %ECDdir%\Lib\Protect\w32b5\aciosx.lib    %OUT%\Lib\Release\BO
copy %ECDdir%\Lib\Protect\w32b5\cios.lib      %OUT%\Lib\Release\BO
copy %ECDdir%\Lib\Protect\w32b5\ciosx.lib     %OUT%\Lib\Release\BO
copy %ECDdir%\Lib\Protect\w32b5\cipherio.lib  %OUT%\Lib\Release\BO
copy %ECDdir%\Lib\Protect\w32b5\crypt.lib     %OUT%\Lib\Release\BO
copy %ECDdir%\Lib\Protect\w32b5\dlb.lib       %OUT%\Lib\Release\BO
copy %ECDdir%\Lib\Protect\w32b5\lcfile.lib    %OUT%\Lib\Release\BO
copy %ECDdir%\Lib\Protect\w32b5\nlicense.lib  %OUT%\Lib\Release\BO
copy %ECDdir%\Lib\Protect\w32b5\ppclc.lib     %OUT%\Lib\Release\BO
copy %ECDdir%\Lib\Protect\w32b5\sprow32b.lib  %OUT%\Lib\Release\BO
copy %ECDdir%\Lib\Protect\w32b5\ssicb32n.lib  %OUT%\Lib\Release\BO
copy %ECDdir%\Lib\Protect\w32b5\ssocb32.lib   %OUT%\Lib\Release\BO

copy %OUT_ROOT%\Release\Util\LcWrap\1_0\LcWrap\LcWrapBO\LcHelp.obj %OUT%\Obj\Release\BO

cd /D %OUT%
%RARPATH%\WinRar m -r LcWrap *.*
cd /D %ORG%

copy %RARPATH%\UnRar.exe %OUT%
echo set ORG=%%~d0%%~p0>%OUT%\InstallAll.cmd
echo "%%ORG%%unrar" x "%%ORG%%LcWrap.rar">>%OUT%\InstallAll.cmd

echo Product Name:   LcWrap>%OUT%\Version.txt
echo Version:        %VERSION%>>%OUT%\Version.txt
echo Release Date:   %DATE%>>%OUT%\Version.txt

copy %~f0 %OUT%\create.cmd

echo @echo off >%OUT%\PostInstall.cmd
echo del LcWrap.rar ^>nul>>%OUT%\PostInstall.cmd
echo del InstallAll.cmd ^>nul>>%OUT%\PostInstall.cmd
echo del UnRAR.exe ^>nul>>%OUT%\PostInstall.cmd


