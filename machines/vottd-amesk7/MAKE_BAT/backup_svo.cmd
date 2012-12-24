@echo off
rem
rem  Copyright   (C) 1991-2001  Transas Marine LTD, St.Petersburg.
rem  Transas Software House.    Navigation  Technology Department.
rem
rem  Project : <none>
rem
rem  File    : <backup_svo.cmd>
rem  Creation: 20.11.01, Amesk
rem
rem  Description: This file provides numbered and "dated" backup for the specified file
rem
rem  Params:
rem           %1 - is a name of the file being backed up
rem           %2 - is a target directory name (without trailing slash)
rem

rem -------------------------------- Checking parameters -----------------------------------------
if "%1." == "." goto usage
if "%2." == "." goto usage


rem --------------------------- Checking parameters validity -------------------------------------
if not exist %1 (
echo Source file %1 not found
goto end
)

if not exist %2 (
echo Target directory %1 not found
goto end
)

rem -------------------------------- Creating backup name ----------------------------------------
FOR /F "tokens=2,3,4 delims=. " %%i in ('date /T') do set BDATE=%%i.%%j.%%k
FOR /F %%i in ("%1") do set ARCNAME=%2\%%~ni-%BDATE%%%~xi

if exist %ARCNAME% (
set /A index=0
:next_try
FOR /F %%i in ("%1") do set ARCNAME=%2\%%~ni-%BDATE%-%index%%%~xi
set /A index=index+1
if exist %ARCNAME% goto next_try
)
rem ------------------------------------- Working ------------------------------------------------
echo Copying %1 to %ARCNAME%...
copy %1 %ARCNAME% >nul
echo Done
goto end
rem ----------------------------------------------------------------------------------------------
:usage
echo Usage:
echo %0 name backup_directory
echo where:
echo name              - is a name of the file being backed up
echo backup_directory  - is a target directory name (without trailing slash)
echo Example:
echo                     %0 test.mpp c:\backups 

:end


