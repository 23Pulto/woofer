@echo off
setlocal EnableDelayedExpansion
title Change Windows MachineGuid
color 0B

:: Check admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This needs to be run as Administrator.
    echo Right-click this file and choose "Run as administrator".
    pause
    exit /b
)

set "REG_PATH=HKLM\SOFTWARE\Microsoft\Cryptography"
set "VALUE_NAME=MachineGuid"
set "BACKUP_FILE=%USERPROFILE%\Desktop\MachineGuid_Backup.reg"

cls
echo ==================================================
echo              MachineGuid Changer
echo ==================================================
echo.
echo Current MachineGuid:
reg query "%REG_PATH%" /v "%VALUE_NAME%"
echo.

echo A backup will be saved here:
echo %BACKUP_FILE%
echo.

reg export "%REG_PATH%" "%BACKUP_FILE%" /y >nul
if %errorlevel% neq 0 (
    echo Failed to create backup. Not changing anything.
    pause
    exit /b
)

echo Backup created.
echo.
echo Enter your new GUID in this format:
echo xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
echo.
echo Example:
echo 12345678-1234-1234-1234-123456789abc
echo.

set /p "NEW_GUID=New MachineGuid: "

if "%NEW_GUID%"=="" (
    echo No GUID entered. Cancelled.
    pause
    exit /b
)

:: Validate GUID format using PowerShell
powershell -NoProfile -Command "if ('%NEW_GUID%' -match '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$') { exit 0 } else { exit 1 }"

if %errorlevel% neq 0 (
    echo.
    echo Invalid GUID format, bro. You typed it wrong.
    echo Use this format:
    echo xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    pause
    exit /b
)

echo.
echo Changing MachineGuid...
reg add "%REG_PATH%" /v "%VALUE_NAME%" /t REG_SZ /d "%NEW_GUID%" /f >nul

if %errorlevel% neq 0 (
    echo Failed to change MachineGuid.
    echo You can restore using:
    echo %BACKUP_FILE%
    pause
    exit /b
)

echo.
echo Done.
echo.
echo New MachineGuid:
reg query "%REG_PATH%" /v "%VALUE_NAME%"
echo.
echo Restart your PC for everything to fully apply.
echo.
echo If something breaks, double-click this backup file:
echo %BACKUP_FILE%
echo.
pause