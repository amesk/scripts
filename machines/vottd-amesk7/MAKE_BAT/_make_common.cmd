pushd
set ORG=%~d0%~p0
if exist "%ORG%app_paths.cmd" call "%ORG%app_paths.cmd"
if exist "%ORG%dirstore.cmd" call "%ORG%dirstore.cmd"
if "%__ROOT__%."=="." set __ROOT__=E:\OUT_ROOT
if exist %ORG%debrel.cmd call %ORG%debrel.cmd
if "%DEBREL%."=="." set DEBREL=DEBUG
rem if exist %__ROOT__%\out_root.cmd call %__ROOT__%\out_root.cmd
call :GetOutRoot %__ROOT__%
popd

goto :eof

rem =============================================================================================
rem GetOutRoot subroutine
rem PURPOSE : Reads OUT_ROOT location from .config. Stores it in %OUT_ROOT% variable
rem =============================================================================================
:GetOutRoot
set OUT_ROOT=none
set DOT_CONFIG=%1\.config
for /F "tokens=1,2*" %%i in (%DOT_CONFIG%) do call :GetOutRoot0 %%i %%j
:GetOutRoot0
if -%1==-OUT_ROOT: goto GetOutRoot1
if -%1==-OUT_ROOT goto GetOutRoot1
goto :eof
:GetOutRoot1
set OUT_ROOT=%2
set OUT_ROOT=%OUT_ROOT:/=\%

goto :eof

