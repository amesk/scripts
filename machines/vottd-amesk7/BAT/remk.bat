@echo off

if "%1"=="" (
    mk clean && mk
    exit /B
)

set LOC=%1
set LOC=%LOC:/=\%
pushd %LOC%
mk clean && mk
popd

