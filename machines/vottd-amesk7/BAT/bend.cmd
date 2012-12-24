@echo off
set PATH=%PATH%;H:\OUT_ROOT\NTE\GNUUtil;H:\OUT_ROOT\NTE\GNUUtil\local;E:\NSData\App\texmf\miktex\bin
if not exist H:\OUT_ROOT\NTE\GNUUtil\egrep.exe copy H:\OUT_ROOT\NTE\GNUUtil\grep.exe H:\OUT_ROOT\NTE\GNUUtil\egrep.exe > nul
start cmd /k "cd /d H:\OUT_ROOT\NTE\DEBUG\Sources\NTEDoc\docs\latex"


