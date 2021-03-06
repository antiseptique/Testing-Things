@echo off

:setpcname
cls
echo Nom actuel du PC:
hostname
@echo.
set /p pcnewname=Saisir le nouveau nom du PC:
@echo.

REM Récupération du nom du PC et incrémentation du nom souhaité.
set nameincrementation=%COMPUTERNAME%%pcnewname%
wmic computersystem where name="%COMPUTERNAME%" call rename name="%nameincrementation%"
echo Le nouveau nom du PC est "%nameincrementation%"
@echo.

:rebootconfirmation
set /p rebootvalidation=Confimez-vous le nouveau nom ? (Y)es, (N)o, (B)ack:

if /i "%rebootvalidation%" EQU "Y" goto :rebootok
if /i "%rebootvalidation%" EQU "N" goto :setpcname
if /i "%rebootvalidation%" EQU "B" goto :back
goto :rebootconfirmation

:rebootok
shutdown -r -t 10
del %0

:back
REM Call au label start pour éviter de recharger le contrôle des droits admin.
call "../Start.bat" %start%