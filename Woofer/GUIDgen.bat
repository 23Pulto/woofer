@echo off
setlocal EnableDelayedExpansion
title Online GUID / UUID Generator - Batch Version
color 0B

:: Default settings
set "COUNT=1"
set "HYPHENS=ON"
set "BRACES=OFF"
set "UPPERCASE=OFF"
set "QUOTES=OFF"
set "COMMAS=OFF"
set "BASE64=OFF"
set "AUTOCOPY=OFF"
set "OUTPUT_FILE=guids_output.txt"

:MENU
cls
echo ==================================================
echo        Free Online GUID / UUID Generator
echo              Batch File Version
echo ==================================================
echo.
echo Current Settings:
echo.
echo   [1] Amount:        %COUNT%
echo   [2] Hyphens:       %HYPHENS%
echo   [3] Braces {}:     %BRACES%
echo   [4] Uppercase:     %UPPERCASE%
echo   [5] Quotes "":     %QUOTES%
echo   [6] Commas:        %COMMAS%
echo   [7] Base64:        %BASE64%
echo   [8] Auto Copy:     %AUTOCOPY%
echo.
echo   [9] Generate GUIDs
echo   [10] Copy Last Results To Clipboard
echo   [11] Open Results File
echo   [12] Clear Results File
echo   [0] Exit
echo.
set /p "choice=Choose an option: "

if "%choice%"=="1" goto SET_COUNT
if "%choice%"=="2" goto TOGGLE_HYPHENS
if "%choice%"=="3" goto TOGGLE_BRACES
if "%choice%"=="4" goto TOGGLE_UPPERCASE
if "%choice%"=="5" goto TOGGLE_QUOTES
if "%choice%"=="6" goto TOGGLE_COMMAS
if "%choice%"=="7" goto TOGGLE_BASE64
if "%choice%"=="8" goto TOGGLE_AUTOCOPY
if "%choice%"=="9" goto GENERATE
if "%choice%"=="10" goto COPY_RESULTS
if "%choice%"=="11" goto OPEN_RESULTS
if "%choice%"=="12" goto CLEAR_RESULTS
if "%choice%"=="0" exit

goto MENU

:SET_COUNT
cls
echo Enter how many GUIDs you want.
echo Minimum: 1
echo Maximum: 1000
echo.
set /p "newcount=Amount: "

:: Check if number
for /f "delims=0123456789" %%A in ("%newcount%") do (
    echo Invalid number.
    pause
    goto MENU
)

if "%newcount%"=="" goto MENU

if %newcount% LSS 1 (
    echo Amount too low.
    pause
    goto MENU
)

if %newcount% GTR 1000 (
    echo Amount too high.
    pause
    goto MENU
)

set "COUNT=%newcount%"
goto MENU

:TOGGLE_HYPHENS
if "%HYPHENS%"=="ON" (
    set "HYPHENS=OFF"
) else (
    set "HYPHENS=ON"
)
goto MENU

:TOGGLE_BRACES
if "%BRACES%"=="ON" (
    set "BRACES=OFF"
) else (
    set "BRACES=ON"
)
goto MENU

:TOGGLE_UPPERCASE
if "%UPPERCASE%"=="ON" (
    set "UPPERCASE=OFF"
) else (
    set "UPPERCASE=ON"
)
goto MENU

:TOGGLE_QUOTES
if "%QUOTES%"=="ON" (
    set "QUOTES=OFF"
) else (
    set "QUOTES=ON"
)
goto MENU

:TOGGLE_COMMAS
if "%COMMAS%"=="ON" (
    set "COMMAS=OFF"
) else (
    set "COMMAS=ON"
)
goto MENU

:TOGGLE_BASE64
if "%BASE64%"=="ON" (
    set "BASE64=OFF"
) else (
    set "BASE64=ON"
)
goto MENU

:TOGGLE_AUTOCOPY
if "%AUTOCOPY%"=="ON" (
    set "AUTOCOPY=OFF"
) else (
    set "AUTOCOPY=ON"
)
goto MENU

:GENERATE
cls
echo Generating %COUNT% GUID(s)...
echo.

if exist "%OUTPUT_FILE%" del "%OUTPUT_FILE%"

for /L %%i in (1,1,%COUNT%) do (
    for /f %%G in ('powershell -NoProfile -Command "[guid]::NewGuid().ToString()"') do (
        set "GUID=%%G"

        if "%HYPHENS%"=="OFF" (
            set "GUID=!GUID:-=!"
        )

        if "%UPPERCASE%"=="ON" (
            for /f %%U in ('powershell -NoProfile -Command "'!GUID!'.ToUpper()"') do set "GUID=%%U"
        )

        if "%BRACES%"=="ON" (
            set "GUID={!GUID!}"
        )

        if "%QUOTES%"=="ON" (
            set "GUID="!GUID!""
        )

        if "%BASE64%"=="ON" (
            for /f "delims=" %%B in ('powershell -NoProfile -Command "[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes('!GUID!'))"') do set "GUID=%%B"
        )

        if "%COMMAS%"=="ON" (
            set "GUID=!GUID!,"
        )

        echo !GUID!
        echo !GUID!>>"%OUTPUT_FILE%"
    )
)

echo.
echo Results saved to: %OUTPUT_FILE%

if "%AUTOCOPY%"=="ON" (
    type "%OUTPUT_FILE%" | clip
    echo Auto copied to clipboard.
)

echo.
pause
goto MENU

:COPY_RESULTS
cls
if not exist "%OUTPUT_FILE%" (
    echo No results file found. Generate GUIDs first, genius.
    pause
    goto MENU
)

type "%OUTPUT_FILE%" | clip
echo Results copied to clipboard.
pause
goto MENU

:OPEN_RESULTS
cls
if not exist "%OUTPUT_FILE%" (
    echo No results file found.
    pause
    goto MENU
)

notepad "%OUTPUT_FILE%"
goto MENU

:CLEAR_RESULTS
cls
if exist "%OUTPUT_FILE%" del "%OUTPUT_FILE%"
echo Results file cleared.
pause
goto MENU