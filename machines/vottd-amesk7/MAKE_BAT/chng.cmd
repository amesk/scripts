@echo off

SET MYDIR=%CD%
SET MYMAK=%MYDIR:Src=Mak%
set MYSRC=%MYDIR:Mak=Src%

rem �� � ������ ����������?
if not "%MYDIR%." == "%MYSRC%." goto skip
    if not exist %MYMAK% goto tryelse
    cd %MYMAK%
    goto :eof
:tryelse
    if exist %MYMAK%\.. cd %MYMAK%\..
:skip

rem �� � ������ Makefile'��?
if not "%MYDIR%." == "%MYMAK%." goto skip2
    if not exist %MYSRC% goto tryelse2
    cd %MYSRC%
    goto :eof
:tryelse2
    if exist %MYSRC%\.. cd %MYSRC%\..
:skip2

