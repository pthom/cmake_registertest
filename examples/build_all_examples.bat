REM for /f %%f in (`dir /b example*`) do echo %%f
ECHO off
for /D %%d in (example*) do ( echo %%d & cd %%d & build.bat & cd .. )