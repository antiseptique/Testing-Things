@echo off

REM Contrôle des droits admin.
goto admin_check

:admin_check
echo Droits admin requis. Detection des droits...
net session >nul 2>&1

if %errorLevel% == 0 (
echo OK: Confirmation des droits admin.
pause
) else (
echo KO: Merci de relancer le programme en admin.
echo.
echo Le programme va maintenant se fermer.
pause
exit
)

REM Chemin relatif (contrer l'exécution de Windows\System32) pour attribution des droits admin.
cd /d %~dp0

:start
cls
REM Contrôle du log d'installation.
@echo - Post Master Check -
if exist Files\Chain_Installations.log (
    for /f "tokens=*" %%i in (Files\Chain_Installations.log) do @echo %%i
) else (
    @echo Aucun fichier log. 
	@echo > nul
)

REM Afficher les choix d'installation.
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
if /i "%installchoice%" EQU "7" goto :deletelog
if /i "%installchoice%" EQU "8" exit
goto :start

REM Définir les "path" vers les fichiers d'installation
:rename
@echo Rename >> "Files/Chain_Installations.log"
call "Files/Computer_Name.bat"
REM Securité, théoriquement inutile.
goto :start

:jdomain
start "path" file.exe
@echo DJoin >> "Files/Chain_Installations.log"
goto :start

:profile
start "path" file.exe
@echo Profile >> "Files/Chain_Installations.log"
goto :start

:gpupdate
@echo GPUpdate >> "Files/Chain_Installations.log"
@echo.
gpupdate /force
goto :start

:kace
start "path" file.exe
@echo Kace >> "Files/Chain_Installations.log"
goto :start

:sophos
start "path" file.exe
@echo Sophos >> "Files/Chain_Installations.log"
goto :start

:deletelog
if exist Files\Chain_Installations.log (
    call "Files/Delete_Log.bat"
) else (
    goto :start
)
REM Securité, théoriquement inutile.
goto :start