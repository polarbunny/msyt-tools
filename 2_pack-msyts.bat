@echo off
rem Create msyt files from Bootup_XXxx.pack (Switch + WiiU) - by polarbunny

:Start
if EXIST lock.file (
echo/
echo Lock file detected.
echo Stopping.
echo/
pause
goto :eof )

:Lock
copy NUL lock.file > NUL

:Check_Sarc
for %%X in (sarc.exe) do ( set FOUND=%%~$PATH:X)
if defined FOUND goto Check_Rstbtool
echo/
echo Could not find sarc.
echo/
echo Install with `pip install sarc`
echo/
del lock.file /Q
pause
goto :eof

:Check_Rstbtool
for %%X in (rstbtool.exe) do ( set FOUND=%%~$PATH:X)
if defined FOUND goto Check_Rstb
echo/
echo Could not find rstbtool.
echo/
echo Install with `pip install rstb`
echo/
del lock.file /Q
pause
goto :eof

:Check_Rstb
if NOT EXIST resources\switch\ResourceSizeTable.product.srsizetable goto Check_RstbPANIC
if NOT EXIST resources\wiiu\ResourceSizeTable.product.srsizetable goto Check_RstbPANIC
goto Check_Msbt

:Check_RstbPANIC
echo/
echo Can't find vanilla ResourceSizeTable.product.srsizetable.
echo/
echo Run setup-files.bat or place vanilla ResourceSizeTable.product.srsizetable files into .\resources\[switch+wiiu]\ folders.
echo Example: .\resources\wiiu\ResourceSizeTable.product.srsizetable
echo/
echo Stopping.
echo/
del lock.file /Q
pause
goto :eof

:Check_Msbt
if EXIST ActorType\*.msbt goto Check_MsbtPANIC
if EXIST DemoMsg\*.msbt goto Check_MsbtPANIC
if EXIST EventFlowMsg\*.msbt goto Check_MsbtPANIC
if EXIST LayoutMsg\*.msbt goto Check_MsbtPANIC
if EXIST QuestMsg\*.msbt goto Check_MsbtPANIC
if EXIST ShoutMsg\*.msbt goto Check_MsbtPANIC
if EXIST StaticMsg\*.msbt goto Check_MsbtPANIC
if EXIST Tips\*.msbt goto Check_MsbtPANIC
goto Check_Language

:Check_MsbtPANIC
echo/
echo Warning. Existing msbt files detected.
echo/
echo This script assumes no msbt files in working folders.
echo Remove msbt files before continuing.
echo/
echo Stopping.
echo/
del lock.file /Q
pause
goto :eof

:Check_Language
for %%i in (*.i18n) do set i18n=%%~ni
if "%i18n%" == "" (
echo i18n file not detected!
echo Run 0_set_language.bat first.
echo/
pause
del lock.file /Q
goto :eof )

:Make_Directories
echo/
echo Making Directories...
mkdir !output\switch\Bootup_%i18n%\Message
mkdir !output\wiiu\Bootup_%i18n%\Message
mkdir temp\switch\ActorType
mkdir temp\switch\DemoMsg
mkdir temp\switch\EventFlowMsg
mkdir temp\switch\LayoutMsg
mkdir temp\switch\QuestMsg
mkdir temp\switch\ShoutMsg
mkdir temp\switch\StaticMsg
mkdir temp\switch\Tips
mkdir temp\wiiu\ActorType
mkdir temp\wiiu\DemoMsg
mkdir temp\wiiu\EventFlowMsg
mkdir temp\wiiu\LayoutMsg
mkdir temp\wiiu\QuestMsg
mkdir temp\wiiu\ShoutMsg
mkdir temp\wiiu\StaticMsg
mkdir temp\wiiu\Tips

:Switch-Msyt_Create
echo/
echo Creating switch msbts...
bin\msyt.exe create -dBp switch -o temp\switch msyt

:WiiU-Msyt_Create
echo/
echo Creating wiiu msbts...
bin\msyt.exe create -dBp wiiu -o temp\wiiu msyt

:Switch-Build_Sarc
echo/
echo Building and compressing Switch Msg_XXxx.product.ssarc...
echo/
sarc create temp\switch Msg_%i18n%.product.ssarc

:Switch-Fix_Rstb
echo/
echo Patching Switch ResourceSizeTable...
copy resources\switch\ResourceSizeTable.product.srsizetable ResourceSizeTable.product.srsizetable
rstbtool ResourceSizeTable.product.srsizetable set Message/Msg_%i18n%.product.sarc Msg_%i18n%.product.ssarc > rstb-changes.txt

echo/
echo Copying to !output\switch:
move ResourceSizeTable.product.srsizetable !output\switch\
move rstb-changes.txt !output\switch\
move Msg_%i18n%.product.ssarc !output\switch\Bootup_%i18n%\Message\

:WiiU-Build_Sarc
echo/
echo Building and compressing WiiU Msg_XXxx.product.ssarc...
echo/
sarc create -b temp\wiiu Msg_%i18n%.product.ssarc

:WiiU-Fix_Rstb
echo/
echo Patching WiiU ResourceSizeTable...
copy resources\wiiu\ResourceSizeTable.product.srsizetable ResourceSizeTable.product.srsizetable
rstbtool -b ResourceSizeTable.product.srsizetable set Message/Msg_%i18n%.product.sarc Msg_%i18n%.product.ssarc > rstb-changes.txt

echo/
echo Copying to !output\wiiu:
move ResourceSizeTable.product.srsizetable !output\wiiu\
move rstb-changes.txt !output\wiiu\
move Msg_%i18n%.product.ssarc !output\wiiu\Bootup_%i18n%\Message\

:Build_Packs
echo/
echo Building Switch Bootup_XXxx.pack...
echo/
cd !output\switch\
sarc create Bootup_%i18n% Bootup_%i18n%.pack

echo/
echo Building WiiU Bootup_XXxx.pack...
echo/
cd ..\wiiu\
sarc create -b Bootup_%i18n% Bootup_%i18n%.pack
cd ..

:Restructure_Output
echo/
echo Restructuring output dir...
mkdir switch\Pack
mkdir switch\System\Resource
mkdir wiiu\Pack
mkdir wiiu\System\Resource

move switch\Bootup_%i18n%.pack switch\Pack\Bootup_%i18n%.pack
move switch\ResourceSizeTable.product.srsizetable switch\System\Resource\ResourceSizeTable.product.srsizetable
move wiiu\Bootup_%i18n%.pack wiiu\Pack\Bootup_%i18n%.pack
move wiiu\ResourceSizeTable.product.srsizetable wiiu\System\Resource\ResourceSizeTable.product.srsizetable

:Delete_Mess
echo/
echo Deleting mess...
rmdir ..\temp\ /S /Q
rmdir switch\Bootup_%i18n%\ /S /Q
rmdir wiiu\Bootup_%i18n%\ /S /Q
cd..

:Done
echo/
echo Done. Check for errors.
echo/
del lock.file /Q
@echo %CMDCMDLINE% | FIND /I /C "/C" > NUL && pause
