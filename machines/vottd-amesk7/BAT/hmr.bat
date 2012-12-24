@echo off
pushd .
set err = 0
:cycle
if exist hammer.cmd (
    echo Invoking hammer....
    call hammer.cmd %*
    if errorlevel 1 set err=%errorlevel%
    popd
    exit /B %err%
)
set go_upper=N
for /f "tokens=1,2,3,4" %%i in ('dir') do if "%%l"==".." set go_upper=Y
if "%go_upper%"=="N" (
    echo No hammer found. Exiting...
    popd
    exit /B 1
)
cd ..
goto cycle



