@echo off
rem Extract / fetch msyt files - by polarbunny

:Start
if EXIST lock.file (
echo Lock file detected.
echo Stopping.
echo.
pause
goto :eof )

:Lock
copy NUL lock.file > NUL

:Check_Msyts
if EXIST msyt\ActorType\*.msyt goto Existing_Msyts
if EXIST msyt\DemoMsg\*.msyt goto Existing_Msyts
if EXIST msyt\EventFlowMsg\*.msyt goto Existing_Msyts
if EXIST msyt\LayoutMsg\*.msyt goto Existing_Msyts
if EXIST msyt\QuestMsg\*.msyt goto Existing_Msyts
if EXIST msyt\ShoutMsg\*.msyt goto Existing_Msyts
if EXIST msyt\StaticMsg\*.msyt goto Existing_Msyts
if EXIST msyt\Tips\*.msyt goto Existing_Msyts
goto Check_Rstb

:Existing_Msyts
echo.
echo Existing msyt files detected.
echo.
echo Stopping.
echo.
pause
del lock.file /Q
goto :eof

:Check_Rstb
if NOT EXIST resources\switch\ResourceSizeTable.product.srsizetable goto Get_Rstbs
if NOT EXIST resources\wiiu\ResourceSizeTable.product.srsizetable goto Get_Rstbs
goto Check_Msbts

:Get_Rstbs
echo.
echo Can't find vanilla ResourceSizeTable.product.srsizetable files.
echo.
echo Making rstb dirs.
mkdir resources\switch
mkdir resources\wiiu
mkdir temp
echo.
echo Fetching rstbs...
cd temp
..\bin\curl.exe -LJO https://github.com/polarbunny/vanilla-1.5.0/raw/master/resources/switch/ResourceSizeTable.product.srsizetable
move ResourceSizeTable.product.srsizetable ..\resources\switch
..\bin\curl.exe -LJO https://github.com/polarbunny/vanilla-1.5.0/raw/master/resources/wiiu/ResourceSizeTable.product.srsizetable
move ResourceSizeTable.product.srsizetable ..\resources\wiiu
cd ..
rmdir temp

:Check_Msbts
if EXIST msbt\ActorType\*.msbt goto Extract_Msbts
if EXIST msbt\DemoMsg\*.msbt goto Extract_Msbts
if EXIST msbt\EventFlowMsg\*.msbt goto Extract_Msbts
if EXIST msbt\LayoutMsg\*.msbt goto Extract_Msbts
if EXIST msbt\QuestMsg\*.msbt goto Extract_Msbts
if EXIST msbt\ShoutMsg\*.msbt goto Extract_Msbts
if EXIST msbt\StaticMsg\*.msbt goto Extract_Msbts
if EXIST msbt\Tips\*.msbt goto Extract_Msbts
goto Get_Msyts

:Extract_Msbts
echo.
echo Existing msbt files detected. Attempting to export.
bin\msyt.exe export -do msyt msbt
echo.
echo Extracted msbts.
goto Done

:Get_Msyts
echo.
echo Fetching Msyt files.
bin\curl.exe -LJO https://github.com/polarbunny/vanilla-1.5.0/releases/download/v1.0/msyt.7z
bin\7za.exe x msyt.7z
del msyt.7z /Q

:Done
echo.
echo Done. Check for errors.
echo.
del lock.file /Q
@echo %CMDCMDLINE% | FIND /I /C "/C" > NUL && pause
