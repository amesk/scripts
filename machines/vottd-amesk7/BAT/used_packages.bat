@echo off
echo Generating...
setlocal
set path=%PATH%;H:\OUT_ROOT\htibs-trunk\GNUUtil;H:\OUT_ROOT\htibs-trunk\GNUUtil\local
ls -lR |grep -E "^\./[^/]+/.+[0-9]:"|sed -r "s/.\/(.+)\/(.+):/\1;\2/"
endlocal
