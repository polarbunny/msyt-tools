@echo off
rem Extract / fetch msyt files - by polarbunny

:Start
if EXIST lock.file (
echo Lock file detected.
echo Stopping.
echo/
pause
goto :eof )

:Lock
copy NUL lock.file > NUL

:Check_Rstb
if NOT EXIST resources\switch\ResourceSizeTable.product.srsizetable goto Get_Rstbs
if NOT EXIST resources\wiiu\ResourceSizeTable.product.srsizetable goto Get_Rstbs
echo/
echo Existing rstb files detected.
echo/
goto Check_Msyts

:Get_Rstbs
echo/
echo Can't find any existing ResourceSizeTable.product.srsizetable files.
echo/
echo Fetching rstbs...
echo/
mkdir resources\switch
mkdir resources\wiiu
mkdir temp
cd temp
..\bin\curl.exe -LJO https://github.com/polarbunny/vanilla-msyts/raw/master/resources/switch/ResourceSizeTable.product.srsizetable
move ResourceSizeTable.product.srsizetable ..\resources\switch
echo/
..\bin\curl.exe -LJO https://github.com/polarbunny/vanilla-msyts/raw/master/resources/wiiu/ResourceSizeTable.product.srsizetable
move ResourceSizeTable.product.srsizetable ..\resources\wiiu
cd ..
rmdir temp

:Check_Msyts
if EXIST msyt\ActorType\*.msyt goto Existing_Msyts
if EXIST msyt\DemoMsg\*.msyt goto Existing_Msyts
if EXIST msyt\EventFlowMsg\*.msyt goto Existing_Msyts
if EXIST msyt\LayoutMsg\*.msyt goto Existing_Msyts
if EXIST msyt\QuestMsg\*.msyt goto Existing_Msyts
if EXIST msyt\ShoutMsg\*.msyt goto Existing_Msyts
if EXIST msyt\StaticMsg\*.msyt goto Existing_Msyts
if EXIST msyt\Tips\*.msyt goto Existing_Msyts
echo/
echo Can't find any existing 'msyt' files.
goto Check_Msbts

:Existing_Msyts
echo/
echo Existing msyt files detected.
echo/
echo Skipping.
goto Done

:Check_Msbts
if EXIST msbt\ActorType\*.msbt goto Extract_Msbts
if EXIST msbt\DemoMsg\*.msbt goto Extract_Msbts
if EXIST msbt\EventFlowMsg\*.msbt goto Extract_Msbts
if EXIST msbt\LayoutMsg\*.msbt goto Extract_Msbts
if EXIST msbt\QuestMsg\*.msbt goto Extract_Msbts
if EXIST msbt\ShoutMsg\*.msbt goto Extract_Msbts
if EXIST msbt\StaticMsg\*.msbt goto Extract_Msbts
if EXIST msbt\Tips\*.msbt goto Extract_Msbts
goto Check_Language

:Extract_Msbts
echo/
echo Existing msbt files detected. Attempting to export.
echo/
bin\msyt.exe export -do msyt msbt
echo/
echo Extracted msbts.
goto Done

:Check_Language
for %%i in (*.i18n) do set i18n=%%~ni
if "%i18n%" == "" (
echo i18n file not detected!
echo Run 0_set_language.bat first.
echo/
pause
del lock.file /Q
goto :eof )

:Get_Msyts
echo/
echo Fetching msyts...
echo/
bin\curl.exe -LJO https://github.com/polarbunny/vanilla-msyts/releases/download/v1.6/Msg_%i18n%.product.7z
bin\7za.exe x Msg_%i18n%.product.7z
del Msg_%i18n%.product.7z /Q

:Done
echo/
echo Done. Check for errors.
echo/
del lock.file /Q
@echo %CMDCMDLINE% | FIND /I /C "/C" > NUL && pause
