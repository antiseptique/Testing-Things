@echo off
:setpcname
cls
echo Nom actuel du PC:
hostname
@echo.
set /p pcnewname=Saisir le nouveau nom du PC:
@echo.

set nameincrementation=%COMPUTERNAME%%pcnewname%
wmic computersystem where name="%COMPUTERNAME%" call rename name="%nameincrementation%"
echo Le nouveau nom du PC est "%nameincrementation%"
@echo.

:rebootconfirmation
set /p rebootvalidation=Confimez-vous le nouveau nom (Entraine le reboot) (y/n):

if /i "%rebootvalidation%" EQU "Y" goto :rebootok
if /i "%rebootvalidation%" EQU "N" goto :setpcname
goto :rebootconfirmation

:rebootok
shutdown -r -t 10
del %0

boulou
end