@echo off
REM Contrôle des droits admin.
REM Revoir toute cette partie pour mise en place sur masterisation.
REM La gestion des droits est differente sur les PC X.
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
@echo - Infos -
@echo Nom PC : %computername%
@echo Domaine : %userdomain%
@echo.
REM Contrôle du log d'installation.
@echo - Post Master Check -
if exist Masterisation.log (
    for /f "tokens=*" %%i in (Masterisation.log) do @echo %%i
) else (
    @echo Aucun fichier log.
	@echo > nul
)

REM Afficher les choix d'installation.
@echo.
@echo - Commandes -
@echo Reboot (R), Eteindre (E), Fermer session (F), GPResult (G)
@echo.
@echo - Choisir une installation -
@echo Rename (1), Domain (2), Profile (3), GPUpdate (4)
@echo Kace (5), Sophos (6), Clearlog (7), Quitter (8)
set /p installchoice=Saisir une action (Chiffre ou Lettre):

if /i "%installchoice%" EQU "1" goto :rename
if /i "%installchoice%" EQU "2" goto :jdomain
if /i "%installchoice%" EQU "3" goto :profile
if /i "%installchoice%" EQU "4" goto :gpupdate
if /i "%installchoice%" EQU "5" goto :kace
if /i "%installchoice%" EQU "6" goto :sophos
if /i "%installchoice%" EQU "7" goto :deletelog
if /i "%installchoice%" EQU "8" exit

if /i "%installchoice%" EQU "R" goto :rebootcmd
if /i "%installchoice%" EQU "E" goto :shutdowncmd
if /i "%installchoice%" EQU "F" goto :closecmd
if /i "%installchoice%" EQU "G" goto :gpresultcmd

REM Si la saisie ne correspond a aucun choix, relancer le menu.
goto :start

REM Commandes.
:rebootcmd
@echo.
@echo Le pc va maintenant reboot dans 10 secondes.
shutdown -r -t 10
pause
REM Securité.
goto :start

:shutdowncmd
@echo.
@echo Le pc va maintenant se couper dans 10 secondes.
shutdown -s -t 10
pause
REM Securité.
goto :start

:closecmd
@echo.
@echo Le pc va maintenant fermer la session dans 10 secondes.
shutdown -l -t 10
pause
REM Securité.
goto :start

:gpresultcmd
@echo.
gpresult /h %userprofile%\Desktop\gpresult.html /f
start %userprofile%\Desktop\gpresult.html
@echo Fichier gpresult ouvert et disponible sur le bureau.
pause
goto :start

REM Etapes masterisation.
:rename
@echo Rename >> "Masterisation.log"
:setpcname
cls
echo Nom actuel du PC:
hostname
@echo.
set /p pcnewname=Saisir le nouveau nom du PC:
@echo.

REM Renommer le PC avec la variable pcnewname.
wmic computersystem where name="%computername%" call rename name="%pcnewname%"
echo Le nouveau nom du PC est "%pcnewname%"
@echo.

:rebootconfirmation
REM Cette étape ne permet pas d'annuler la saisie précédente,
REM Uniquement de la recommencer s'il y a une erreur.
set /p rebootvalidation=Confimez-vous le nouveau nom ? (Y)es, (N)o:

if /i "%rebootvalidation%" EQU "Y" goto :rebootok
if /i "%rebootvalidation%" EQU "N" goto :setpcname
goto :rebootconfirmation

:rebootok
@echo.
@echo Le pc va maintenant reboot dans 10 secondes.
shutdown -r -t 10
pause
goto :start

:jdomain
@echo DJoin >> "Masterisation.log"
start "path" file.exe
@echo.
@echo Le pc va maintenant rejoindre le domaine puis reboot dans 30 secondes.
shutdown -r -t 30
pause
goto :start

:profile
@echo Profile >> "Masterisation.log"
start "path" file.exe
@echo.
@echo Lancement du gestionnaire de profiles, le PC fera un reboot apres la selection.
pause
goto :start

:gpupdate
@echo GPUpdate >> "Masterisation.log"
@echo.
gpupdate /force
@echo.
@echo Fin du gpupdate.
pause
goto :start

:kace
@echo Kace >> "Masterisation.log"
start "path" file.exe
goto :start

:sophos
@echo Sophos >> "Masterisation.log"
start "path" file.exe
goto :start

:deletelog
if exist Masterisation.log (
    del Masterisation.log
    @echo.
    @echo Supression du fichier log
    pause
    goto :start
) else (
    goto :start
)
REM Securité.
goto :start
