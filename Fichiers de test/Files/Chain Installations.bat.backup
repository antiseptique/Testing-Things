@echo off
:start
cls
REM Définir les "path" vers les fichiers d'installation
@echo - Post Master Check -
for /f "tokens=*" %%i in (Chain_Installations.log) do @echo %%i

@echo.
@echo - Choisir une installation -
@echo Rename (1), Domain (2), Profile (3), GPUpdate (4)
set /p installchoice=Kace (5), Sophos (6), Clearlog (7), Quitter (8):

if /i "%installchoice%" EQU "1" goto :rename
if /i "%installchoice%" EQU "2" goto :jdomain
if /i "%installchoice%" EQU "3" goto :profile
if /i "%installchoice%" EQU "4" goto :gpupdate
if /i "%installchoice%" EQU "5" goto :kace
if /i "%installchoice%" EQU "6" goto :sophos
if /i "%installchoice%" EQU "7" call "Delete log.bat"
if /i "%installchoice%" EQU "8" exit
goto :start

:rename
start "path" file.exe
@echo Rename >> "Chain_Installations.log"
goto :start

:jdomain
start "path" file.exe
@echo DJoin >> "Chain_Installations.log"
goto :start

:profile
start "path" file.exe
@echo Profile >> "Chain_Installations.log"
goto :start

:profile
gpupdate /force
@echo GPUpdate >> "Chain_Installations.log"
goto :start

:kace
start "path" file.exe
@echo Kace >> "Chain_Installations.log"
goto :start

:sophos
start "path" file.exe
@echo Sophos >> "Chain_Installations.log"
goto :start