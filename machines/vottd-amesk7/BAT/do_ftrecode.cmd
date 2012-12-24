@echo off
if not exist ftrecode.exe (
    echo ftrecode.exe not found. Please, run me from ^$(BIN_DIR^)
    goto :eof
)

if "-%1-" == "--" (
    echo application name is required
    goto :eof
)

if not exist %1-ftre.dat (
    echo %1-ftre.dat not found
    goto :eof
)

echo Please, do not close this window until Notedpad.exe exits....
ftrecode decode %1-ftre.dat %1-ftre.txt
notepad %1-ftre.txt
ftrecode encode %1-ftre.txt %1-ftre.dat


