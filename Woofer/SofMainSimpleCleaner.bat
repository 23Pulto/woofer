@echo off
title SOFMAIN SIMPLE CLEANER ENHANCED
color 0B

:: ==========================================
:: 1. REQUEST ADMIN PRIVILEGES
:: ==========================================
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)
if '%errorlevel%' NEQ '0' (
    echo Requesting Admin Perms...
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
)
pushd "%CD%"
CD /D "%~dp0"

setlocal EnableDelayedExpansion

:: ==========================================
:: 2. KILL PROCESSES
:: ==========================================
echo [*] Killing game and launcher processes...
taskkill /f /im epicgameslauncher.exe > nul 2>&1
taskkill /f /im EpicWebHelper.exe > nul 2>&1
taskkill /f /im FortniteClient-Win64-Shipping_EAC.exe > nul 2>&1
taskkill /f /im FortniteClient-Win64-Shipping_EAC_EOS.exe > nul 2>&1
taskkill /f /im FortniteClient-Win64-Shipping_BE.exe > nul 2>&1
taskkill /f /im FortniteLauncher.exe > nul 2>&1
taskkill /f /im FortniteClient-Win64-Shipping.exe > nul 2>&1
taskkill /f /im UnrealCEFSubProcess.exe > nul 2>&1
taskkill /f /im CEFProcess.exe > nul 2>&1
taskkill /f /im EasyAntiCheat.exe > nul 2>&1
taskkill /f /im BEService.exe > nul 2>&1
taskkill /f /im BEServices.exe > nul 2>&1
taskkill /f /im BattleEye.exe > nul 2>&1
taskkill /f /im smartscreen.exe > nul 2>&1
taskkill /f /im dnf.exe > nul 2>&1
taskkill /f /im CrossProxy.exe > nul 2>&1
taskkill /f /im tensafe_1.exe > nul 2>&1
taskkill /f /im tensafe_2.exe > nul 2>&1
taskkill /f /im tencentdl.exe > nul 2>&1
taskkill /f /im TenioDL.exe > nul 2>&1
taskkill /f /im uishell.exe > nul 2>&1
taskkill /f /im BackgroundDownloader.exe > nul 2>&1
taskkill /f /im conime.exe > nul 2>&1
taskkill /f /im QQDL.EXE > nul 2>&1
taskkill /f /im qqlogin.exe > nul 2>&1
taskkill /f /im dnfchina.exe > nul 2>&1
taskkill /f /im dnfchinatest.exe > nul 2>&1
taskkill /f /im txplatform.exe > nul 2>&1
taskkill /f /im OriginWebHelperService.exe > nul 2>&1
taskkill /f /im Origin.exe > nul 2>&1
taskkill /f /im OriginClientService.exe > nul 2>&1
taskkill /f /im OriginER.exe > nul 2>&1
taskkill /f /im OriginThinSetupInternal.exe > nul 2>&1
taskkill /f /im OriginLegacyCLI.exe > nul 2>&1
taskkill /f /im Agent.exe > nul 2>&1
taskkill /f /im Client.exe > nul 2>&1
taskkill /f /im nvcontainer.exe > nul 2>&1
taskkill /f /im NVDisplay.Container.exe > nul 2>&1
taskkill /f /im "NVIDIA Web Helper.exe" > nul 2>&1
taskkill /f /im "NVIDIA Share.exe" > nul 2>&1
taskkill /f /im nvsphelper64.exe > nul 2>&1
taskkill /f /im OneDrive.exe > nul 2>&1

:: ==========================================
:: 3. STOP SERVICES
:: ==========================================
echo [*] Stopping Services...
Sc stop EasyAntiCheat > nul 2>&1
Sc stop FortniteClient-Win64-Shipping_EAC_EOS > nul 2>&1
Sc stop FortniteClient-Win64-Shipping_EAC > nul 2>&1
Sc stop FortniteClient-Win64-Shipping_BE > nul 2>&1
Sc stop BattleEye > nul 2>&1
Sc stop BEService > nul 2>&1
sc stop NvContainerLocalSystem > nul 2>&1
sc stop NVDisplay.ContainerLocalSystem > nul 2>&1
sc stop lltdsvc > nul 2>&1

sc config winmgmt start= disabled > nul 2>&1
net stop winmgmt /y > nul 2>&1

:: ==========================================
:: 4. NETWORK & IP RESET (INTEGRATED)
:: ==========================================
echo [*] Resetting and Optimizing Network Settings...

:: Advanced Network Config
netsh interface ipv6 uninstall > nul 2>&1
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=no > nul 2>&1
netsh advfirewall firewall set rule group="Network Discovery" new enable=no > nul 2>&1
netsh int tcp set global autotuninglevel=normal > nul 2>&1
netsh interface set interface "Microsoft Network Adapter Multiplexor Protocol" admin=disabled > nul 2>&1
sc config lltdsvc start=disabled > nul 2>&1

:: Registry Network Tweaks (ArpOffload, TCP Frequency, etc)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 0xFFFFFFFF /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v EEE /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v ArpOffload /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpAckFrequency /t REG_DWORD /d 1 /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpChecksumOffloadIPv4 /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v LargeSendOffloadv2IPv6 /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpChecksumOffloadIPv6 /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v UdpChecksumOffloadIPv6 /t REG_DWORD /d 0 /f > nul 2>&1

:: IP Reset commands
certutil -URLCache * delete > nul 2>&1
netsh int ip reset > nul 2>&1
netsh int ipv4 reset > nul 2>&1
netsh int ipv6 reset > nul 2>&1
ipconfig /release > nul 2>&1
ipconfig /renew > nul 2>&1
ipconfig /flushdns > nul 2>&1
ipconfig /registerdns > nul 2>&1
netsh advfirewall reset > nul 2>&1
netsh winsock reset > nul 2>&1

:: ==========================================
:: 5. REGISTRY CLEANING
:: ==========================================
echo [*] Cleaning Traces from Registry...
reg delete "HKEY_CURRENT_USER\Software\Epic Games" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\WOW6432Node\Epic Games" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Classes\com.epicgames.launcher" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Epic Games\Unreal Engine\Identifiers" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Epic Games\Unreal Engine\Hardware Survey" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Epic Games\EOS" /f >nul 2>&1
reg delete "HKEY_USERS\S-1-5-21-2097722829-2509645790-3642206209-1001\Software\Epic Games" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\com.epicgames.launcher" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Epic Games" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\EpicGames" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Epic Games" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\EpicGames" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\EasyAntiCheat" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\HardwareConfig" /f >nul 2>&1

reg delete "HKCU\Software\Electronic Arts\EA Core\Staging\194908\ergc" /f >nul 2>&1
reg delete "HKCU\Software\Electronic Arts" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Respawn\Apex\Product GUID" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Classes\origin" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Classes\origin2" /f >nul 2>&1
reg delete "HKCR\origin" /f >nul 2>&1
reg delete "HKCR\origin2" /f >nul 2>&1
reg delete "HKCR\Applications\Origin.exe" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Classes\Applications\Origin.exe" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs\.Origin" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\Services\Origin Client Service" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\Services\Origin Web Helper Service" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Origin Client Service" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Origin Web Helper Service" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\RADAR\HeapLeakDetection\DiagnosedApplications\Origin.exe" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\RADAR\HeapLeakDetection\DiagnosedApplications\FortniteClient-Win64-Shipping.exe" /f >nul 2>&1

reg delete "HKLM\SYSTEM\ControlSet001\Services\EasyAntiCheat" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\EasyAntiCheat" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\Services\BEService" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\BEService" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\Services\BEDaisy" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\BEDaisy" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\Services\EpicOnlineServices" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\bam\State\UserSettings" /f >nul 2>&1

reg delete "HKEY_CURRENT_USER\Software\Microsoft\Direct3D" /v WHQLClass /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\BagMRU" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Bags" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\BagMRU" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Persisted" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\ShellNoRoam\MUICache" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRULegacy" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSaveMRU" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist" /f >nul 2>&1

:: Xbox Game Overlay Traces
reg delete "HKLM\SOFTWARE\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\Microsoft.XboxGameOverlay_1.41.24001.0_x64__8wekyb3d8bbwe" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModel\StateRepository\Cache\Application\Data\93" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModel\StateRepository\Cache\Application\Index\Package\181" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModel\StateRepository\Cache\ApplicationUser\Data\ac" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModel\StateRepository\Cache\Package\Data\180" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModel\StateRepository\Cache\Package\Data\181" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModel\StateRepository\Cache\Package\Data\182" /f >nul 2>&1

:: ==========================================
:: 6. RANDOMIZE HARDWARE IDS & BINARY DNS
:: ==========================================
echo [*] Randomizing HWIDs, Machine GUIDs, and Binary Network Data...
set Hex1=%random:~0,1%
set Hex8=%random:~0,8%
set Hex10=%random:~0,10%

REG ADD "HKLM\SOFTWARE\Microsoft\Cryptography" /v MachineGuid /t REG_SZ /d %Hex8%-%Hex1%-%random%-%Hex1%-%Hex10% /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v BuildGUID /t REG_SZ /d %Hex8%-%Hex1%-%random%-%Hex1%-%Hex10% /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v InstallDate /t REG_SZ /d %random% /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductId /t REG_SZ /d %random%-%random%-%random%-%random% /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v RegisteredOwner /t REG_SZ /d FS%random% /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v RegisteredOrganization /t REG_SZ /d FS%random% /f >nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\SystemInformation" /v ComputerHardwareId /t REG_SZ /d {%Hex8%-%Hex1%-%random%-%Hex1%-%Hex10%} /f >nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName" /v ComputerName /t REG_SZ /d DESKTOP-%random% /f >nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName" /v ComputerName /t REG_SZ /d DESKTOP-%random% /f >nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\IDConfigDB\Hardware Profiles\0001" /v HwProfileGuid /t REG_SZ /d {%random%-%random%-%random%-%random%-%random%} /f >nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\IDConfigDB\Hardware Profiles\0001" /v GUID /t REG_SZ /d {%random%-%random%-%random%-%random%-%random%} /f >nul 2>&1
REG ADD "HKLM\SYSTEM\HardwareConfig" /v LastConfig /t REG_SZ /d {eac%random%} /f >nul 2>&1
REG ADD "HKLM\System\CurrentControlSet\Control\WMI\Security" /v 671a8285-4edb-4cae-99fe-69a15c48c0bc /t REG_SZ /d %random% /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /t REG_SZ /d {%random%-%random%-%random%-%random%-%random%} /f >nul 2>&1

:: Random Binary Registry Values for Tcpip6
set "RANDOM_DNS="
set "RANDOM_SEARCHLIST="
set "RANDOM_DUID="
for /l %%i in (1,1,14) do call :generateRandomByte RANDOM_DNS
for /l %%i in (1,1,14) do call :generateRandomByte RANDOM_SEARCHLIST
for /l %%i in (1,1,14) do call :generateRandomByte RANDOM_DUID

set "TCPIP6_KEY=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
reg add "%TCPIP6_KEY%" /v "Dhcpv6DNSServers" /t REG_BINARY /d !RANDOM_DNS! /f >nul 2>&1
reg add "%TCPIP6_KEY%" /v "Dhcpv6DomainSearchList" /t REG_BINARY /d !RANDOM_SEARCHLIST! /f >nul 2>&1
reg add "%TCPIP6_KEY%" /v "Dhcpv6DUID" /t REG_BINARY /d !RANDOM_DUID! /f >nul 2>&1

:: Mac Address Randomization
FOR /F "tokens=1" %%a IN ('wmic nic where physicaladapter^=true get deviceid ^| findstr [0-9]') DO (
 CALL :MAC
 FOR %%b IN (0 00 000) DO (
  REG QUERY HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\%%b%%a >NUL 2>NUL && REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\%%b%%a /v NetworkAddress /t REG_SZ /d !MAC_ADDR!  /f >NUL 2>NUL
 )
)
goto skipMacGen

:MAC
SET GEN=ABCDEF0123456789
SET GEN2=26AE
SET MAC_ADDR=
SET COUNT=0
:MACLOOP
SET /a COUNT+=1
SET /a RND=%RANDOM%%%16
SET /a RND2=%RANDOM%%%4
IF !COUNT! EQU 2 (SET MAC_ADDR=!MAC_ADDR!!GEN2:~%RND2%,1!) ELSE (SET MAC_ADDR=!MAC_ADDR!!GEN:~%RND%,1!)
IF !COUNT! LEQ 11 GOTO MACLOOP
goto :eof

:generateRandomByte
set /a "byte=!random! %% 256"
set "hexValue=00!byte!"
set "hexValue=!hexValue:~-2!"
set "%1=!%1!!hexValue!"
exit /b

:skipMacGen

:: ==========================================
:: 7. WIPE CACHE AND LOG DIRECTORIES
:: ==========================================
echo [*] Wiping AppData, LocalAppData, Temp, Logs, Prefetch, and Game Traces...

set "app_dirs=%localappdata%\EpicGamesLauncher %localappdata%\FortniteGame %localappdata%\UnrealEngine %localappdata%\UnrealEngineLauncher %programdata%\Epic %programdata%\Electronic Arts %appdata%\Origin %localappdata%\Origin %homepath%\.Origin %homepath%\.QtWebEngineProcess %programfiles%\Common Files\EAInstaller %appdata%\EasyAntiCheat %localappdata%\EasyAntiCheat %programdata%\Microsoft\Windows\WER\Temp %windir%\Temp %localappdata%\Temp %windir%\Prefetch %localappdata%\D3DSCache %localappdata%\NVIDIA %localappdata%\NVIDIA Corporation %programdata%\NVIDIA %programdata%\NVIDIA Corporation %localappdata%\AMD %programfiles(x86)%\AMD %localappdata%\Microsoft\Feeds %localappdata%\CrashReportClient %localappdata%\ConnectedDevicesPlatform %localappdata%\Microsoft\Windows\WebCache %localappdataLow%\Microsoft\CryptnetUrlCache %localappdata%\Comms %localappdata%\CEF %localappdata%\DBG %localappdata%\Publishers %localappdata%\Programs\Common %localappdata%\PlaceholderTileLogoFolder %localappdata%\Speech Graphics %programdata%\USOShared\Logs %windir%\SoftwareDistribution\DataStore\Logs %windir%\Logs %windir%\System32\LogFiles\WMI %windir%\System32\sru %windir%\System32\wbem\Performance"

for %%d in (%app_dirs%) do (
    if exist "%%d" (
        del /s /f /q "%%d\*.*" >nul 2>&1
        rmdir /s /q "%%d" >nul 2>&1
    )
)

:: Clear Recycle Bins and Drives Recovery / MSOCache
for %%D in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%D:\" (
        rd /q /s "%%D:\$Recycle.Bin" >nul 2>&1
        rmdir /s /q "%%D:\MSOCache" >nul 2>&1
        rmdir /s /q "%%D:\Recovery" >nul 2>&1
        del /s /f /q "%%D:\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\*.*" >nul 2>&1
        del /s /f /q "%%D:\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\Shared Files\*.*" >nul 2>&1
        del /s /f /q "%%D:\Program Files\Epic Games\Fortnite\FortniteGame\Config\*.*" >nul 2>&1
        del /s /f /q "%%D:\Program Files\Epic Games\Fortnite\Engine\Plugins\*.*" >nul 2>&1
        del /s /f /q "%%D:\Program Files (x86)\Common Files\BattlEye\*.*" >nul 2>&1
        del /s /f /q "%%D:\Program Files (x86)\EasyAntiCheat\*.*" >nul 2>&1
    )
)

:: Specific Individual files
del /f /s /q "C:\Windows\win.ini" >nul 2>&1
del /f /s /q "C:\Riot Games\VALORANT\live\Manifest_NonUFSFiles_Win64.txt" >nul 2>&1
del /f /s /q "C:\Riot Games\VALORANT\live\Engine\Binaries\ThirdParty\CEF3\Win64\icudtl.dat" >nul 2>&1
del /f /s /q "C:\Riot Games\Riot Client\UX\Plugins\plugin-manifest.json" >nul 2>&1
del /f /s /q "C:\Riot Games\Riot Client\UX\icudtl.dat" >nul 2>&1
del /f /s /q "C:\Riot Games\Riot Client\UX\natives_blob.bin" >nul 2>&1
del /f /s /q "C:\System Volume Information\tracking.log" >nul 2>&1
del /f /s /q "C:\System Volume Information\IndexerVolumeGuid" >nul 2>&1
del /f /s /q "C:\System Volume Information\WPSettings.dat" >nul 2>&1
del /f /s /q "D:\System Volume Information\tracking.log" >nul 2>&1
del /f /s /q "C:\Users\%username%\AppData\Local\Microsoft\Vault\UserProfileRoaming\Latest.dat" >nul 2>&1
del /f /s /q "C:\Users\%username%\AppData\Local\AC\INetCookies\ESE\container.dat" >nul 2>&1
del /f /s /q "C:\Users\%username%\AppData\Local\UnrealEngine\4.23\Saved\Config\WindowsClient\Manifest.ini" >nul 2>&1
del /f /s /q "C:\Users\%username%\AppData\Local\Microsoft\OneDrive\logs\Common\DeviceHealthSummaryConfiguration.ini" >nul 2>&1
del /f /s /q "C:\ProgramData\Microsoft\Windows\DeviceMetadataCache\dmrc.idx" >nul 2>&1
del /f /s /q "C:\Users\%username%\ntuser.ini" >nul 2>&1
del /f /s /q "C:\Users\%username%\AppData\Local\Microsoft\Windows\INetCache\IE\container.dat" >nul 2>&1
del /f /s /q "C:\Windows\System32\perfc009.dat" >nul 2>&1
del /f /s /q "C:\Windows\System32\perfh009.dat" >nul 2>&1
del /f /s /q "C:\Windows\System32\PerfStringBackup.TMP" >nul 2>&1
del /f /s /q "C:\Windows\System32\PerfStringBackup.INI" >nul 2>&1
del /f /s /q "C:\Users\%username%\ntuser.dat.LOG1" >nul 2>&1
del /f /s /q "C:\Users\%username%\ntuser.dat.LOG2" >nul 2>&1
del /f /s /q "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations\*.*" >nul 2>&1
del /f /s /q "C:\Windows\appcompat\Programs\Amcache.hve" >nul 2>&1

:: Wipe explicit Prefetch files
del /q /f "C:\Windows\prefetch\*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\CONHOST.EXE-*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\CLEANER.EXE-*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\reg.EXE-*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\TASKKILL.EXE-*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\RUNTIMEBROKER.EXE-*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\TOOL.EXE-*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\ATTRIB.EXE-*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\CMD.EXE-*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\FINDSTR.EXE-*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\WMIC.EXE-*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\WMIPRVSE.EXE-*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\NETSH.EXE-*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\IPCONFIG.EXE-*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\WERMGR.EXE-*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\SVCHOST.EXE-*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\DISCORD.EXE-*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\EPICGAMESLAUNCHER.EXE-*.pf" >nul 2>&1
del /q /f "C:\Windows\prefetch\OBS64.EXE-*.pf" >nul 2>&1

:: Wiping Event Logs using wevtutil
echo [*] Clearing Windows Event Logs...
for /F "tokens=*" %%G in ('wevtutil.exe el') DO (wevtutil.exe cl "%%G" >nul 2>&1)

:: Restart WMI
sc config winmgmt start= auto >nul 2>&1
net start winmgmt >nul 2>&1
%systemdrive%
cd %windir%\system32\wbem
for /f %%s in ('dir /b *.dll') do regsvr32 /s %%s >nul 2>&1
wmiprvse /regserver >nul 2>&1
winmgmt /regserver >nul 2>&1
for /f %%s in ('dir /s /b *.mof *.mfl') do mofcomp %%s >nul 2>&1

echo.
echo ========================================================
echo Done! Simple Clean, Registry clear, HWID Spoof, MAC Spoof, 
echo Prefetch cache wipe, AppData clean, and Network reset complete!
echo Please restart your computer for changes to take effect.
echo THANKS FOR USING SOFMAINS SIMPLE CLEANER!.
echo ========================================================
pause
exit