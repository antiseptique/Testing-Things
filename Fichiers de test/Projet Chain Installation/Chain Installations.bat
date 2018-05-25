@echo off
:start
cls
REM Définir les "path" vers les fichiers d'installation
@echo - Installations Check -
for /f "tokens=*" %%i in (Chain_Installations.log) do @echo %%i

@echo.
@echo - Choisir une installation -
@echo Rename (1), Domain (2), Profile (3)
set /p installchoice=Kace (4), Sophos (5), Clearlog (6), Quitter (7):

if /i "%installchoice%" EQU "1" goto :rename
if /i "%installchoice%" EQU "2" goto :jdomain
if /i "%installchoice%" EQU "3" goto :profile
if /i "%installchoice%" EQU "4" goto :kace
if /i "%installchoice%" EQU "5" goto :sophos
if /i "%installchoice%" EQU "6" call "Delete log.bat"
if /i "%installchoice%" EQU "7" exit
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

:kace
start "path" file.exe
@echo Kace >> "Chain_Installations.log"
goto :start

:sophos
start "path" file.exe
@echo Sophos >> "Chain_Installations.log"
goto :start