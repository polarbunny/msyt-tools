@echo off
rem Set working launguage for msyt-tools - by polarbunny

:Start
if EXIST lock.file (
echo Lock file detected.
echo Stopping.
echo/
pause
goto :eof )

:Lock
copy NUL lock.file > NUL


:Choose_Language
echo/
echo Languages:
echo/
echo 0  - CNzh
echo 1  - EUde
echo 2  - EUes
echo 3  - EUfr
echo 4  - EUit
echo 5  - EUnl
echo 6  - EUru
echo 7  - JPja
echo 8  - KRko
echo 9  - TWzh
echo 10 - USes
echo 11 - USfr
echo 12 - XXen 
echo/
set /p input="Enter Selection: "

:Process_Selection
del /q *.i18n > NUL
if "%input%"=="0" (
copy NUL CNzh.i18n > NUL
goto Done
)
if "%input%"=="1" (
copy NUL EUde.i18n > NUL
goto Done
)
if "%input%"=="2" (
copy NUL EUes.i18n > NUL
goto Done
)
if "%input%"=="3" (
copy NUL EUfr.i18n > NUL
goto Done
)
if "%input%"=="4" (
copy NUL EUit.i18n > NUL
goto Done
)
if "%input%"=="5" (
copy NUL EUnl.i18n > NUL
goto Done
)
if "%input%"=="6" (
copy NUL EUru.i18n > NUL
goto Done
)
if "%input%"=="7" (
copy NUL JPja.i18n > NUL
goto Done
)
if "%input%"=="8" (
copy NUL KRko.i18n > NUL
goto Done
)
if "%input%"=="9" (
copy NUL TWzh.i18n > NUL
goto Done
)
if "%input%"=="10" (
copy NUL USes.i18n > NUL
goto Done
)
if "%input%"=="11" (
copy NUL USfr.i18n > NUL
goto Done
)
if "%input%"=="12" (
copy NUL XXen.i18n > NUL
goto Done
)
cls
goto Choose_Language

:Done
echo/
echo Done.
echo/
del lock.file /Q
@echo %CMDCMDLINE% | FIND /I /C "/C" > NUL && pause
