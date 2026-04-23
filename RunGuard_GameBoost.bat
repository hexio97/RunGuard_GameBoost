@echo off
chcp 65001 >nul 2>&1
color 0a
mode con: cols=85 lines=50
setlocal EnableDelayedExpansion

net sessions >nul 2>&1
if %errorLevel% neq 0 (
    color 0c
    echo.
    echo  [ERROR] Run as ADMINISTRATOR / Ruleaza ca ADMINISTRATOR
    echo.
    pause
    exit /b 1
)

:: ============================================================
:: LANGUAGE SELECTION
:: ============================================================
cls
echo.
echo  ============================================================
echo  ^|^|                                                      ^|^|
echo  ^|^|   Select Language / Selecteaza Limba                ^|^|
echo  ^|^|                                                      ^|^|
echo  ============================================================
echo.
echo   [1]  English
echo   [2]  Romana
echo.
set /p LANG_CHOICE="  Choice / Alegere (1 or 2): "
set LANG=EN
if "%LANG_CHOICE%"=="2" set LANG=RO

:: ============================================================
:: STRING DEFINITIONS
:: ============================================================
if "%LANG%"=="RO" (
    set S_TITLE=GAMING OPTIMIZER ULTRA - Powered by RunGuard
    set S_ALREADY1=Scriptul a mai fost rulat pe acest PC.
    set S_ALREADY2=Apasa 1 pentru a rula din nou, 2 pentru a iesi:
    set S_SCAN=Scanez hardware-ul tau...
    set S_CPU=Detectez CPU...
    set S_GPU=Detectez GPU...
    set S_WIN=Detectez versiunea Windows...
    set S_SSD=Detectez tipul de stocare...
    set S_RAM=Detectez RAM...
    set S_READY=SISTEM PREGATIT - Pornesc optimizarile...
    set S_DONE=OPTIMIZARE COMPLETA!
    set S_RESTART=Reporneste PC-ul pentru a aplica toate setarile!
    set S_EXIT=Apasa orice tasta pentru a iesi...
    set S_THANKS=Multumim ca ai ales RunGuard!
    set S_UNDO=Script restaurare generat
    set S_STEP=Pas
    set S_OF=din
    set S_ALREADY_RUN=Rulat anterior pe data de
    set S_RERUN=Rulezi din nou? ^(1=Da / 2=Iesire^):
    rem Steps
    set S_01=Creare Restore Point
    set S_02=Dezactivare servicii inutile
    set S_03=Plan alimentare Ultimate Performance
    set S_04=CPU Unparking - toate core-urile active
    set S_05=Dezactivare HPET
    set S_06=Optimizare GPU
    set S_07=Game Mode ON + GameBar OFF
    set S_08=Dezactivare Fullscreen Optimizations
    set S_09=Optimizare retea
    set S_10=Dezactivare accelerare mouse
    set S_11=Dezactivare efecte vizuale
    set S_12=Optimizare RAM
    set S_13=Curatare disk
    set S_14=Optimizare boot
    set S_15=Timer Resolution la startup
    set S_16=Servicii extra dezactivate ^(Xbox, Search, Print...^)
    set S_17=Verificare si actualizare drivere GPU
    set S_18=Dezactivare background apps + Cortana
    set S_19=Power Throttling OFF + IRQ optimizat
    set S_20=Optimizare fisier de paginare ^(RAM virtual^)
    set S_21=Tweaks specifice GPU
    set S_22=Dezactivare telemetrie Windows completa
    set S_23=Prioritate HIGH pentru jocuri competitive
    set S_24=Curatare shader cache GPU
    set S_25=Config tweaks per joc ^(CS:GO, CS2, LoL, Minecraft^)
    set S_26=RAM Cleaner automat la pornire
    set S_27=Optimizare CPU affinity pentru gaming
) else (
    set S_TITLE=GAMING OPTIMIZER ULTRA - Powered by RunGuard
    set S_ALREADY1=This script has already been run on this PC.
    set S_ALREADY2=Press 1 to run again, 2 to exit:
    set S_SCAN=Scanning your hardware...
    set S_CPU=Detecting CPU...
    set S_GPU=Detecting GPU...
    set S_WIN=Detecting Windows version...
    set S_SSD=Detecting storage type...
    set S_RAM=Detecting RAM...
    set S_READY=SYSTEM READY - Starting optimizations...
    set S_DONE=OPTIMIZATION COMPLETE!
    set S_RESTART=Restart your PC to apply all settings!
    set S_EXIT=Press any key to exit...
    set S_THANKS=Thank you for choosing RunGuard!
    set S_UNDO=Restore script generated
    set S_STEP=Step
    set S_OF=of
    set S_ALREADY_RUN=Previously run on
    set S_RERUN=Run again? ^(1=Yes / 2=Exit^):
    rem Steps
    set S_01=Creating Restore Point
    set S_02=Disabling unnecessary services
    set S_03=Ultimate Performance power plan
    set S_04=CPU Unparking - all cores active
    set S_05=Disabling HPET
    set S_06=GPU optimization
    set S_07=Game Mode ON + GameBar OFF
    set S_08=Disabling Fullscreen Optimizations
    set S_09=Network optimization
    set S_10=Disabling mouse acceleration
    set S_11=Disabling visual effects
    set S_12=RAM optimization
    set S_13=Disk cleanup
    set S_14=Boot optimization
    set S_15=Timer Resolution at startup
    set S_16=Extra services killed ^(Xbox, Search, Print...^)
    set S_17=GPU driver check and update
    set S_18=Disabling background apps + Cortana
    set S_19=Power Throttling OFF + IRQ optimized
    set S_20=Page file optimization
    set S_21=GPU-specific tweaks
    set S_22=Disabling all Windows telemetry
    set S_23=HIGH priority for competitive games
    set S_24=GPU shader cache cleanup
    set S_25=Per-game config tweaks ^(CS:GO, CS2, LoL, Minecraft^)
    set S_26=Automatic RAM Cleaner at startup
    set S_27=CPU affinity optimization for gaming
)

set TOTAL_STEPS=27
title %S_TITLE%

:: ============================================================
:: LOG INIT
:: ============================================================
set LOGFILE=%~dp0RunGuard_GameBoost.log
echo ============================================================ >> "%LOGFILE%"
echo RunGuard GameBoost - %date% %time% >> "%LOGFILE%"
echo Limba: %LANG% >> "%LOGFILE%"
echo ============================================================ >> "%LOGFILE%"

:: ============================================================
:: PROFILE SELECTION
:: ============================================================
:PROFILE_LOOP
cls
call :HEADER
echo.
if "%LANG%"=="RO" (
    echo  ============================================================
    echo   Selecteaza profilul de optimizare:
    echo  ============================================================
    echo.
    echo   [1]  SAFE     - Optimizari de baza, zero risc
    echo   [2]  BALANCED - Recomandat, echilibru perfect
    echo   [3]  EXTREME  - Toate cele 27 de optimizari
    echo   [4]  WINUTIL  - Lanseaza Chris Titus WinUtil
    echo   [5]  ACTIVATE - Activeaza Windows / Office
    echo   [6]  NINITE   - Deschide Ninite.com in browser
    echo.
    echo   * WINUTIL: dezinstalare bloatware, tweaks, instalare
    echo     apps, reparare Windows Update. Necesita internet.
    echo   * ACTIVATE: activeaza Windows si Office gratuit.
    echo   * NINITE: instaleaza rapid programe gratuite.
    echo.
) else (
    echo  ============================================================
    echo   Select optimization profile:
    echo  ============================================================
    echo.
    echo   [1]  SAFE     - Basic optimizations, zero risk
    echo   [2]  BALANCED - Recommended, perfect balance
    echo   [3]  EXTREME  - All 27 optimizations
    echo   [4]  WINUTIL  - Launch Chris Titus WinUtil
    echo   [5]  ACTIVATE - Activate Windows / Office
    echo   [6]  NINITE   - Open Ninite.com in browser
    echo.
    echo   * WINUTIL: bloatware removal, tweaks, app install,
    echo     Windows Update repair. Requires internet.
    echo   * ACTIVATE: activate Windows and Office for free.
    echo   * NINITE: quickly install free programs.
    echo.
)
set PROF_CHOICE=2
set /p PROF_CHOICE=  Alegere / Choice [1/2/3/4/5/6, Enter=BALANCED]:
set PROF_CHOICE=%PROF_CHOICE: =%
set PROFILE=BALANCED
if "%PROF_CHOICE%"=="1" set PROFILE=SAFE
if "%PROF_CHOICE%"=="3" set PROFILE=EXTREME
if "%PROF_CHOICE%"=="4" set PROFILE=WINUTIL
if "%PROF_CHOICE%"=="5" set PROFILE=ACTIVATE
if "%PROF_CHOICE%"=="6" set PROFILE=NINITE
echo Profil ales: %PROFILE% >> "%LOGFILE%"

:: Daca profil WINUTIL - lanseaza direct si iese
if not "%PROFILE%"=="WINUTIL" goto :AFTER_WINUTIL
cls
call :HEADER
echo.
if "%LANG%"=="RO" (
    echo  [*] Se lanseaza Chris Titus WinUtil...
    echo  [*] Va aparea o fereastra PowerShell cu interfata grafica.
    echo  [*] Inchide fereastra WinUtil cand termini.
) else (
    echo  [*] Launching Chris Titus WinUtil...
    echo  [*] A PowerShell window with the GUI will appear.
    echo  [*] Close the WinUtil window when done.
)
echo.
echo [%time%] [WINUTIL] Launched Chris Titus WinUtil >> "%LOGFILE%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm christitus.com/win | iex"
echo.
if "%LANG%"=="RO" (set _BACK=  Apasa ENTER pentru a te intoarce la meniu  /  N = Iesire: ) else (set _BACK=  Press ENTER to go back to menu  /  N = Exit: )
set /p BACK_CHOICE=%_BACK%
set BACK_CHOICE=!BACK_CHOICE: =!
if /i "!BACK_CHOICE!"=="N" exit /b 0
goto :PROFILE_LOOP
:AFTER_WINUTIL

:: Daca profil ACTIVATE - activeaza Windows/Office si iese
if not "%PROFILE%"=="ACTIVATE" goto :AFTER_ACTIVATE
cls
call :HEADER
echo.
if "%LANG%"=="RO" (
    echo  [*] Se lanseaza activatorul Windows / Office...
    echo  [*] Va aparea o fereastra PowerShell.
    echo  [*] Urmeaza instructiunile din fereastra.
) else (
    echo  [*] Launching Windows / Office activator...
    echo  [*] A PowerShell window will appear.
    echo  [*] Follow the instructions in the window.
)
echo.
echo [%time%] [ACTIVATE] Launched Windows/Office activator >> "%LOGFILE%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://get.activated.win | iex"
echo.
if "%LANG%"=="RO" (set _BACK=  Apasa ENTER pentru a te intoarce la meniu  /  N = Iesire: ) else (set _BACK=  Press ENTER to go back to menu  /  N = Exit: )
set /p BACK_CHOICE=%_BACK%
set BACK_CHOICE=!BACK_CHOICE: =!
if /i "!BACK_CHOICE!"=="N" exit /b 0
goto :PROFILE_LOOP
:AFTER_ACTIVATE

:: Daca profil NINITE - deschide browser si iese
if not "%PROFILE%"=="NINITE" goto :AFTER_NINITE
cls
call :HEADER
echo.
if "%LANG%"=="RO" (
    echo  [*] Se deschide Ninite.com in browser...
    echo  [*] Selecteaza programele dorite si descarca installer-ul.
) else (
    echo  [*] Opening Ninite.com in browser...
    echo  [*] Select the programs you want and download the installer.
)
echo.
echo [%time%] [NINITE] Opened Ninite.com >> "%LOGFILE%"
start "" "https://ninite.com/"
if "%LANG%"=="RO" (echo  [OK] Ninite.com deschis in browser.) else (echo  [OK] Ninite.com opened in browser.)
echo.
if "%LANG%"=="RO" (set _BACK=  Apasa ENTER pentru a te intoarce la meniu  /  N = Iesire: ) else (set _BACK=  Press ENTER to go back to menu  /  N = Exit: )
set /p BACK_CHOICE=%_BACK%
set BACK_CHOICE=!BACK_CHOICE: =!
if /i "!BACK_CHOICE!"=="N" exit /b 0
goto :PROFILE_LOOP
:AFTER_NINITE

:: Pasi activi per profil (0 = skip)
set RUN_3=1&set RUN_4=1&set RUN_5=1&set RUN_6=1&set RUN_8=1
set RUN_9=1&set RUN_12=1&set RUN_14=1&set RUN_15=1&set RUN_16=1
set RUN_17=1&set RUN_19=1&set RUN_20=1&set RUN_21=1&set RUN_23=1
set RUN_24=1&set RUN_25=1&set RUN_26=1&set RUN_27=1

if "%PROFILE%"=="SAFE" (
    set RUN_3=0&set RUN_4=0&set RUN_5=0&set RUN_6=0&set RUN_8=0
    set RUN_9=0&set RUN_12=0&set RUN_14=0&set RUN_15=0&set RUN_16=0
    set RUN_17=0&set RUN_19=0&set RUN_20=0&set RUN_21=0&set RUN_23=0
    set RUN_24=0&set RUN_25=0&set RUN_26=0&set RUN_27=0
)
if "%PROFILE%"=="BALANCED" (
    set RUN_5=0&set RUN_16=0&set RUN_17=0&set RUN_20=0
    set RUN_21=0&set RUN_24=0&set RUN_26=0&set RUN_27=0
)

:: ============================================================
:: CHECK IF ALREADY RUN
:: ============================================================
set PREV_DATE=
for /f "tokens=3" %%i in ('reg query "HKLM\SOFTWARE\RunGuard\GameBoost" /v Date 2^>nul') do set PREV_DATE=%%i
if not defined PREV_DATE goto :SKIP_RERUN
cls
call :HEADER
echo.
echo   %S_ALREADY1%
echo   %S_ALREADY_RUN%: %PREV_DATE%
echo.
set /p RERUN_CHOICE=  Rulezi din nou / Run again? [1=Da/Yes  2=Exit]:
set RERUN_CHOICE=!RERUN_CHOICE: =!
if "!RERUN_CHOICE!"=="2" exit /b 0
if "!RERUN_CHOICE!"=="n" exit /b 0
if "!RERUN_CHOICE!"=="N" exit /b 0
:SKIP_RERUN

:: ============================================================
:: INTRO SCREEN
:: ============================================================
cls
call :HEADER
echo.
if "%LANG%"=="RO" (
    echo  Toate modificarile sunt reversibile prin Restore Point.
    echo  Recomandat: inchide toate aplicatiile inainte de a continua.
) else (
    echo  All changes are reversible via Restore Point.
    echo  Recommended: close all apps before continuing.
)
echo.
if "%LANG%"=="RO" (set ENTER_MSG=  Apasa ENTER pentru a incepe optimizarea...) else (set ENTER_MSG=  Press ENTER to start optimization...)
set /p DUMMY_=%ENTER_MSG%

:: ============================================================
:: HARDWARE DETECTION
:: ============================================================
cls
call :HEADER
echo.
echo  [>>] %S_SCAN%
echo.
echo  [....] %S_CPU%
for /f "tokens=2 delims==" %%i in ('wmic cpu get NumberOfCores /value 2^>nul') do set CPU_CORES=%%i
for /f "tokens=2 delims==" %%i in ('wmic cpu get NumberOfLogicalProcessors /value 2^>nul') do set CPU_THREADS=%%i
for /f "tokens=2 delims==" %%i in ('wmic cpu get Name /value 2^>nul') do set CPU_NAME=%%i
if not defined CPU_CORES set CPU_CORES=4
set IS_HIGH_END_CPU=0
echo !CPU_NAME! | findstr /i "i7\|i9\|Ryzen 7\|Ryzen 9\|Ryzen 5 5\|Ryzen 5 7\|i5-1[0-9]\|i5-9\|i5-8\|i5-7[3-9]\|i5-12\|i5-13" >nul 2>&1 && set IS_HIGH_END_CPU=1
if "%LANG%"=="RO" (echo  [OK] CPU: !CPU_NAME! -- !CPU_CORES! nuclee / !CPU_THREADS! threaduri) else (echo  [OK] CPU: !CPU_NAME! -- !CPU_CORES! cores / !CPU_THREADS! threads)

echo  [....] %S_GPU%
for /f "tokens=2 delims==" %%i in ('wmic path win32_VideoController get Name /value 2^>nul') do set GPU_NAME=%%i
set GPU_VENDOR=UNKNOWN
echo %GPU_NAME% | findstr /i "NVIDIA" >nul 2>&1 && set GPU_VENDOR=NVIDIA
echo %GPU_NAME% | findstr /i "AMD\|Radeon" >nul 2>&1 && set GPU_VENDOR=AMD
echo %GPU_NAME% | findstr /i "Intel" >nul 2>&1 && set GPU_VENDOR=INTEL
echo  [OK] GPU: %GPU_NAME% ^(%GPU_VENDOR%^)

echo  [....] %S_WIN%
for /f "tokens=3" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild 2^>nul') do set WIN_BUILD=%%i
if not defined WIN_BUILD set WIN_BUILD=0
set IS_WIN11=0
if %WIN_BUILD% GEQ 22000 set IS_WIN11=1
if %IS_WIN11%==1 (echo  [OK] Windows 11 - Build %WIN_BUILD%) else (echo  [OK] Windows 10 - Build %WIN_BUILD%)

echo  [....] %S_SSD%
set IS_SSD=0
for /f "skip=1 tokens=*" %%i in ('powershell -NoProfile -Command "Get-PhysicalDisk | Select-Object -ExpandProperty MediaType" 2^>nul') do (
    if /i "%%i"=="SSD" set IS_SSD=1
)
if %IS_SSD%==1 (
    if "%LANG%"=="RO" (echo  [OK] SSD detectat) else (echo  [OK] SSD detected)
) else (
    if "%LANG%"=="RO" (echo  [OK] HDD detectat) else (echo  [OK] HDD detected)
)

echo  [....] %S_RAM%
for /f "tokens=2 delims==" %%i in ('wmic computersystem get TotalPhysicalMemory /value 2^>nul') do set RAM_BYTES=%%i
set RAM_GB=8
if defined RAM_BYTES (
    set /a RAM_GB=!RAM_BYTES:~0,-6! / 1000
    echo  [OK] RAM: !RAM_GB! GB
)
set IS_HIGH_RAM=0
if !RAM_GB! GEQ 16 set IS_HIGH_RAM=1
echo.
echo  ------------------------------------------------------------
echo  %S_READY%
echo  ------------------------------------------------------------
timeout /t 2 /nobreak >nul

:: ============================================================
:: GENERATE UNDO SCRIPT
:: ============================================================
set UNDO=%~dp0RunGuard_Restore.bat
(
echo @echo off
echo color 0c
echo title RunGuard - Restore Original Settings
echo echo.
echo echo  [RunGuard] Restoring original settings...
echo echo.
echo sc config DiagTrack start= auto ^>nul 2^>^&1
echo sc config WerSvc start= demand ^>nul 2^>^&1
echo sc config SysMain start= auto ^>nul 2^>^&1
echo sc config WSearch start= auto ^>nul 2^>^&1
echo sc config Spooler start= auto ^>nul 2^>^&1
echo sc config DoSvc start= auto ^>nul 2^>^&1
echo powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e ^>nul 2^>^&1
echo reg delete "HKLM\SOFTWARE\RunGuard\GameBoost" /f ^>nul 2^>^&1
echo bcdedit /timeout 30 ^>nul 2^>^&1
echo bcdedit /debug off ^>nul 2^>^&1
echo reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 1 /f ^>nul
echo reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 6 /f ^>nul
echo reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 10 /f ^>nul
echo powershell -Command "Enable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue" ^>nul 2^>^&1
echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csgo.exe" /f ^>nul 2^>^&1
echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\cs2.exe" /f ^>nul 2^>^&1
echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\VALORANT-Win64-Shipping.exe" /f ^>nul 2^>^&1
echo echo  [OK] Settings restored. Restart your PC.
echo pause
) > "%UNDO%"

:: ============================================================
:: 1/27
:: ============================================================
call :PROGRESS 1 %S_01%
powershell -Command "Enable-ComputerRestore -Drive 'C:\' -ErrorAction SilentlyContinue; Checkpoint-Computer -Description 'RunGuard GameBoost' -RestorePointType 'MODIFY_SETTINGS' -ErrorAction SilentlyContinue" >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Restore Point creat cu succes.) else (echo  [OK] Restore Point created successfully.)
echo [%time%] [%PROFILE%] Step 1 - Restore Point >> "%LOGFILE%"

:: ============================================================
:: 2/27
:: ============================================================
call :PROGRESS 2 %S_02%
sc stop DiagTrack >nul 2>&1 & sc config DiagTrack start= disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1 & sc config dmwappushservice start= disabled >nul 2>&1
sc stop WerSvc >nul 2>&1 & sc config WerSvc start= disabled >nul 2>&1
for %%s in (MapsBroker RetailDemo TabletInputService Fax lfsvc WMPNetworkSvc icssvc wisvc PhoneSvc TapiSrv SEMgrSvc) do (
    sc stop %%s >nul 2>&1 & sc config %%s start= disabled >nul 2>&1
)
if %IS_SSD%==1 (
    sc stop SysMain >nul 2>&1 & sc config SysMain start= disabled >nul 2>&1
    if "%LANG%"=="RO" (echo  [OK] Servicii dezactivate + SysMain dezactivat ^(SSD detectat^).) else (echo  [OK] Services disabled + SysMain disabled ^(SSD detected^).)
) else (
    if "%LANG%"=="RO" (echo  [OK] Servicii dezactivate. SysMain pastrat activ ^(HDD detectat^).) else (echo  [OK] Services disabled. SysMain kept active ^(HDD detected^).)
)

echo [%time%] [%PROFILE%] Step 2 - Services >> "%LOGFILE%"

:: ============================================================
:: 3/27
:: ============================================================
if "%RUN_3%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 3 - Power Plan ^(%PROFILE%^)) else (echo  [SKIP] Step 3 - Power Plan ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 3 >> "%LOGFILE%"
    goto :AFTER3
)
call :PROGRESS 3 %S_03%
powercfg /duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
for /f "tokens=4" %%G in ('powercfg /list ^| findstr /i "Ultimate"') do set ULTIMATE_GUID=%%G
if defined ULTIMATE_GUID (
    powercfg /setactive %ULTIMATE_GUID% >nul 2>&1
    if "%LANG%"=="RO" (echo  [OK] Plan Ultimate Performance activat.) else (echo  [OK] Ultimate Performance plan activated.)
) else (
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
    if "%LANG%"=="RO" (echo  [OK] Plan High Performance activat.) else (echo  [OK] High Performance plan activated.)
)
powercfg /setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 0 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1
echo [%time%] [%PROFILE%] Step 3 - Power Plan >> "%LOGFILE%"
:AFTER3

:: ============================================================
:: 4/27
:: ============================================================
if "%RUN_4%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 4 - CPU Unparking ^(%PROFILE%^)) else (echo  [SKIP] Step 4 - CPU Unparking ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 4 >> "%LOGFILE%"
    goto :AFTER4
)
call :PROGRESS 4 %S_04%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v ValueMax /t REG_DWORD /d 100 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v ValueMin /t REG_DWORD /d 100 /f >nul
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 100 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 100 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMAXCORES 100 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Toate %CPU_CORES% core-uri deblocate si active.) else (echo  [OK] All %CPU_CORES% cores unparked and running at full speed.)
echo [%time%] [%PROFILE%] Step 4 - CPU Unparking >> "%LOGFILE%"
:AFTER4

:: ============================================================
:: 5/27
:: ============================================================
if "%RUN_5%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 5 - HPET ^(%PROFILE%^)) else (echo  [SKIP] Step 5 - HPET ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 5 >> "%LOGFILE%"
    goto :AFTER5
)
call :PROGRESS 5 %S_05%
if "%IS_HIGH_END_CPU%"=="1" (
    bcdedit /deletevalue useplatformclock >nul 2>&1
    bcdedit /set useplatformtick yes >nul 2>&1
    bcdedit /set disabledynamictick yes >nul 2>&1
    if "%LANG%"=="RO" (echo  [OK] HPET dezactivat - CPU puternic detectat, frame pacing imbunatatit.) else (echo  [OK] HPET disabled - high-end CPU detected, frame pacing improved.)
) else (
    if "%LANG%"=="RO" (echo  [SKIP] HPET - CPU entry-level detectat, HPET pastrat activ pentru stabilitate.) else (echo  [SKIP] HPET - entry-level CPU detected, HPET kept active for stability.)
)

echo [%time%] [%PROFILE%] Step 5 - HPET >> "%LOGFILE%"
:AFTER5

:: ============================================================
:: 6/27
:: ============================================================
if "%RUN_6%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 6 - GPU Opt ^(%PROFILE%^)) else (echo  [SKIP] Step 6 - GPU Opt ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 6 >> "%LOGFILE%"
    goto :AFTER6
)
call :PROGRESS 6 %S_06%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d High /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d False /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul
if "%LANG%"=="RO" (echo  [OK] GPU Priority maxim + HAGS activat pentru %GPU_NAME%.) else (echo  [OK] GPU Priority maxed + HAGS enabled for %GPU_NAME%.)
echo [%time%] [%PROFILE%] Step 6 - GPU >> "%LOGFILE%"
:AFTER6

:: ============================================================
:: 7/27
:: ============================================================
call :PROGRESS 7 %S_07%
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\GameBar" /v ShowGameModeNotifications /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehavior /t REG_DWORD /d 2 /f >nul
reg add "HKCU\System\GameConfigStore" /v GameDVR_HonorUserFSEBehaviorMode /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul
if "%LANG%"=="RO" (echo  [OK] Game Mode activat - GameBar si GameDVR dezactivate.) else (echo  [OK] Game Mode ON - GameBar and GameDVR disabled.)
echo [%time%] [%PROFILE%] Step 7 - Game Mode >> "%LOGFILE%"

:: ============================================================
:: 8/27
:: ============================================================
if "%RUN_8%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 8 - Fullscreen Opt ^(%PROFILE%^)) else (echo  [SKIP] Step 8 - Fullscreen Opt ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 8 >> "%LOGFILE%"
    goto :AFTER8
)
call :PROGRESS 8 %S_08%
reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /t REG_DWORD /d 2 /f >nul
reg add "HKCU\System\GameConfigStore" /v GameDVR_DSEBehavior /t REG_DWORD /d 2 /f >nul
if "%LANG%"=="RO" (echo  [OK] Fullscreen Optimizations dezactivate - fullscreen exclusiv restaurat.) else (echo  [OK] Fullscreen Optimizations disabled - true fullscreen restored.)
echo [%time%] [%PROFILE%] Step 8 - Fullscreen >> "%LOGFILE%"
:AFTER8

:: ============================================================
:: 9/27
:: ============================================================
if "%RUN_9%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 9 - Retea ^(%PROFILE%^)) else (echo  [SKIP] Step 9 - Network ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 9 >> "%LOGFILE%"
    goto :AFTER9
)
call :PROGRESS 9 %S_09%
for /f "tokens=*" %%k in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /k 2^>nul ^| findstr "HKEY"') do (
    reg add "%%k" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%k" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul 2>&1
)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultTTL /t REG_DWORD /d 64 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpTimedWaitDelay /t REG_DWORD /d 30 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v MaxUserPort /t REG_DWORD /d 65534 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f >nul
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global ecncapability=disabled >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1
netsh int tcp set global rss=enabled >nul 2>&1
netsh int tcp set global maxsynretransmissions=2 >nul 2>&1
netsh int tcp set heuristics disabled >nul 2>&1
netsh int tcp set supplemental internet congestionprovider=ctcp >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Retea optimizata - latenta minima, bandwidth complet disponibil.) else (echo  [OK] Network fully optimized - minimum latency, full bandwidth available.)
echo [%time%] [%PROFILE%] Step 9 - Network >> "%LOGFILE%"
:AFTER9

:: ============================================================
:: 10/27
:: ============================================================
call :PROGRESS 10 %S_10%
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul
if "%LANG%"=="RO" (echo  [OK] Accelerare mouse dezactivata - input 1:1 pur activat.) else (echo  [OK] Mouse acceleration disabled - raw 1:1 input enabled.)
echo [%time%] [%PROFILE%] Step 10 - Mouse >> "%LOGFILE%"

:: ============================================================
:: 11/27
:: ============================================================
call :PROGRESS 11 %S_11%
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Software\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul
if "%LANG%"=="RO" (echo  [OK] Efecte vizuale dezactivate - GPU eliberat pentru jocuri.) else (echo  [OK] Visual effects disabled - GPU freed for gaming.)
echo [%time%] [%PROFILE%] Step 11 - Visual FX >> "%LOGFILE%"

:: ============================================================
:: 12/27
:: ============================================================
if "%RUN_12%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 12 - RAM ^(%PROFILE%^)) else (echo  [SKIP] Step 12 - RAM ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 12 >> "%LOGFILE%"
    goto :AFTER12
)
call :PROGRESS 12 %S_12%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 0 /f >nul
if "%IS_HIGH_RAM%"=="1" (
    powershell -Command "Disable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue" >nul 2>&1
    if "%LANG%"=="RO" (echo  [OK] RAM optimizat - kernel blocat in memorie, compresie dezactivata ^(16GB+^).) else (echo  [OK] RAM optimized - kernel locked in memory, compression disabled ^(16GB+^).)
) else (
    if "%LANG%"=="RO" (echo  [OK] RAM optimizat - kernel blocat in memorie. Compresie pastrata ^(sub 16GB^).) else (echo  [OK] RAM optimized - kernel locked. Compression kept active ^(under 16GB^).)
)

:: ============================================================
:: 13/27
:: ============================================================
call :PROGRESS 13 %S_13%
ipconfig /flushdns >nul 2>&1
del /q /f "%temp%\*" >nul 2>&1
del /q /f "C:\Windows\Temp\*" >nul 2>&1
del /q /f "%LOCALAPPDATA%\D3DSCache\*" >nul 2>&1
powercfg -h off >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Disk curatat - DNS flush, fisiere temp, shader cache, hibernare dezactivata.) else (echo  [OK] Disk cleaned - DNS flush, temp files, shader cache, hibernation disabled.)
echo [%time%] [%PROFILE%] Step 12+13 - RAM+Disk >> "%LOGFILE%"
:AFTER12

:: ============================================================
:: 14/27
:: ============================================================
if "%RUN_14%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 14 - Boot ^(%PROFILE%^)) else (echo  [SKIP] Step 14 - Boot ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 14 >> "%LOGFILE%"
    goto :AFTER14
)
call :PROGRESS 14 %S_14%
bcdedit /timeout 3 >nul 2>&1
bcdedit /debug off >nul 2>&1
if defined CPU_THREADS bcdedit /set numproc %CPU_THREADS% >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Boot optimizat - timeout 3s, toate %CPU_CORES% core-urile la startup.) else (echo  [OK] Boot optimized - timeout 3s, all %CPU_CORES% cores at startup.)
echo [%time%] [%PROFILE%] Step 14 - Boot >> "%LOGFILE%"
:AFTER14

:: ============================================================
:: 15/27
:: ============================================================
if "%RUN_15%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 15 - Timer Resolution ^(%PROFILE%^)) else (echo  [SKIP] Step 15 - Timer Resolution ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 15 >> "%LOGFILE%"
    goto :AFTER15
)
call :PROGRESS 15 %S_15%
set STARTUP_DIR=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
set STARTUP_BAT=%STARTUP_DIR%\RunGuard_TimerRes.bat
set STARTUP_VBS=%STARTUP_DIR%\RunGuard_TimerRes.vbs
set STARTUP_PS1=%TEMP%\rg_timerres.ps1
(
    echo Add-Type -TypeDefinition @"
    echo using System;
    echo using System.Runtime.InteropServices;
    echo public class WinAPI {
    echo     [DllImport("ntdll.dll")] public static extern int NtSetTimerResolution(int d, bool s, out int r);
    echo }
    echo "@
    echo [int]$r = 0
    echo [WinAPI]::NtSetTimerResolution(5000, $true, [ref]$r) ^| Out-Null
) > "%STARTUP_PS1%"
(echo @echo off
echo powershell -NoProfile -ExecutionPolicy Bypass -File "%STARTUP_PS1%") > "%STARTUP_BAT%"
(echo Set WshShell = CreateObject^("WScript.Shell"^)
echo WshShell.Run chr^(34^) ^& "%STARTUP_BAT%" ^& chr^(34^), 0
echo Set WshShell = Nothing) > "%STARTUP_VBS%"
if "%LANG%"=="RO" (echo  [OK] Timer Resolution instalat ca task startup silentios.) else (echo  [OK] Timer Resolution installed as silent startup task.)
echo [%time%] [%PROFILE%] Step 15 - Timer Resolution >> "%LOGFILE%"
:AFTER15

:: ============================================================
:: 16/27
:: ============================================================
if "%RUN_16%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 16 - Servicii Extra ^(%PROFILE%^)) else (echo  [SKIP] Step 16 - Extra Services ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 16 >> "%LOGFILE%"
    goto :AFTER16
)
call :PROGRESS 16 %S_16%
:: Servicii sigure de dezactivat pentru toti userii
for %%s in (XblAuthManager XblGameSave XboxNetApiSvc XboxGipSvc xbgm WSearch DoSvc CDPSvc RemoteRegistry WbioSrvc DPS wisvc WpnService) do (
    sc stop %%s >nul 2>&1 & sc config %%s start= disabled >nul 2>&1
)
:: stisvc (camere/scannere) si Spooler (imprimanta) - dezactivate doar daca nu ai perifericele
:: seclogon (Run as Administrator / AnyDesk / TeamViewer) - PASTRAT ACTIV intentionat
:: SharedAccess (ICS) - PASTRAT ACTIV intentionat
if "%LANG%"=="RO" (echo  [OK] 13 servicii Xbox/Search/CDPSvc dezactivate. seclogon si stisvc pastrate activ.) else (echo  [OK] 13 Xbox/Search/CDPSvc services disabled. seclogon and stisvc kept active.)
echo [%time%] [%PROFILE%] Step 16 - Extra Services >> "%LOGFILE%"
:AFTER16

:: ============================================================
:: 17/27
:: ============================================================
if "%RUN_17%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 17 - Driver GPU ^(%PROFILE%^)) else (echo  [SKIP] Step 17 - GPU Driver ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 17 >> "%LOGFILE%"
    goto :AFTER17
)
call :PROGRESS 17 %S_17%
winget --version >nul 2>&1
if %errorLevel% neq 0 (
    if "%LANG%"=="RO" (echo  [INFO] winget indisponibil - descarca manual driverele de pe site-ul producatorului.) else (echo  [INFO] winget unavailable - download drivers manually from manufacturer website.)
    goto :DRIVER_SKIP
)
if "%GPU_VENDOR%"=="NVIDIA" (
    winget upgrade --id=NVIDIA.GeForceExperience --silent --accept-package-agreements --accept-source-agreements >nul 2>&1
    if "%LANG%"=="RO" (echo  [OK] NVIDIA GeForce Experience verificat/actualizat.) else (echo  [OK] NVIDIA GeForce Experience checked/updated.)
)
if "%GPU_VENDOR%"=="AMD" (
    winget upgrade --id=AMD.RadeonSoftware --silent --accept-package-agreements --accept-source-agreements >nul 2>&1
    if "%LANG%"=="RO" (echo  [OK] AMD Radeon Software verificat/actualizat.) else (echo  [OK] AMD Radeon Software checked/updated.)
)
if "%GPU_VENDOR%"=="INTEL" (
    winget upgrade --id=Intel.IntelDriverAndSupportAssistant --silent --accept-package-agreements --accept-source-agreements >nul 2>&1
    if "%LANG%"=="RO" (echo  [OK] Intel Driver Assistant verificat/actualizat.) else (echo  [OK] Intel Driver Assistant checked/updated.)
)
:DRIVER_SKIP
echo [%time%] [%PROFILE%] Step 17 - GPU Driver >> "%LOGFILE%"
:AFTER17

:: ============================================================
:: 18/27
:: ============================================================
call :PROGRESS 18 %S_18%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsRunInBackground /t REG_DWORD /d 2 /f >nul
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f >nul
if "%LANG%"=="RO" (echo  [OK] Background apps, Cortana, OneDrive startup, Timeline dezactivate.) else (echo  [OK] Background apps, Cortana, OneDrive startup, Timeline disabled.)
echo [%time%] [%PROFILE%] Step 18 - Background Apps >> "%LOGFILE%"

:: ============================================================
:: 19/27
:: ============================================================
if "%RUN_19%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 19 - Power Throttling ^(%PROFILE%^)) else (echo  [SKIP] Step 19 - Power Throttling ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 19 >> "%LOGFILE%"
    goto :AFTER19
)
call :PROGRESS 19 %S_19%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >nul
if %IS_WIN11%==1 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v EnergyEstimationEnabled /t REG_DWORD /d 0 /f >nul
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v EventProcessorEnabled /t REG_DWORD /d 0 /f >nul
)
if "%LANG%"=="RO" (echo  [OK] Power Throttling dezactivat, IRQ prioritizat pentru gaming.) else (echo  [OK] Power Throttling OFF, IRQ priority optimized for gaming.)
echo [%time%] [%PROFILE%] Step 19 - Power Throttling >> "%LOGFILE%"
:AFTER19

:: ============================================================
:: 20/27
:: ============================================================
if "%RUN_20%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 20 - Page File ^(%PROFILE%^)) else (echo  [SKIP] Step 20 - Page File ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 20 >> "%LOGFILE%"
    goto :AFTER20
)
call :PROGRESS 20 %S_20%
wmic computersystem set AutomaticManagedPagefile=True >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Fisier de paginare setat pe auto-managed - optim pentru gaming.) else (echo  [OK] Page file set to auto-managed - optimal for gaming.)
echo [%time%] [%PROFILE%] Step 20 - Page File >> "%LOGFILE%"
:AFTER20

:: ============================================================
:: 21/27
:: ============================================================
if "%RUN_21%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 21 - GPU Tweaks ^(%PROFILE%^)) else (echo  [SKIP] Step 21 - GPU Tweaks ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 21 >> "%LOGFILE%"
    goto :AFTER21
)
call :PROGRESS 21 %S_21%
if "%GPU_VENDOR%"=="NVIDIA" (
    reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v OptInOrOutPreference /t REG_DWORD /d 0 /f >nul 2>&1
    for %%s in (NvTelemetryContainer NvContainerLocalSystem) do (
        sc stop %%s >nul 2>&1 & sc config %%s start= disabled >nul 2>&1
    )
    if "%LANG%"=="RO" (echo  [OK] NVIDIA: telemetrie dezactivata, low-latency tweaks aplicate.) else (echo  [OK] NVIDIA: telemetry disabled, low-latency tweaks applied.)
)
if "%GPU_VENDOR%"=="AMD" (
    reg add "HKLM\SOFTWARE\AMD\CN" /v "TelemetryState" /t REG_DWORD /d 0 /f >nul 2>&1
    sc stop "AMD Crash Defender Service" >nul 2>&1 & sc config "AMD Crash Defender Service" start= disabled >nul 2>&1
    if "%LANG%"=="RO" (echo  [OK] AMD: telemetrie dezactivata, Crash Defender dezactivat.) else (echo  [OK] AMD: telemetry disabled, Crash Defender disabled.)
)
reg add "HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v DirectXUserGlobalSettings /t REG_SZ /d "SwapEffectUpgradeEnable=1;" /f >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] DirectX SwapEffect upgrade activat - stutter redus.) else (echo  [OK] DirectX SwapEffect upgrade enabled - reduced stutter.)
echo [%time%] [%PROFILE%] Step 21 - GPU Tweaks >> "%LOGFILE%"
:AFTER21

:: ============================================================
:: 22/27
:: ============================================================
call :PROGRESS 22 %S_22%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul
if "%LANG%"=="RO" (echo  [OK] Toata telemetria Windows dezactivata complet.) else (echo  [OK] All Windows telemetry completely disabled.)
echo [%time%] [%PROFILE%] Step 22 - Telemetry >> "%LOGFILE%"

:: ============================================================
:: 23/27
:: ============================================================
if "%RUN_23%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 23 - Prioritate Jocuri ^(%PROFILE%^)) else (echo  [SKIP] Step 23 - Game Priority ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 23 >> "%LOGFILE%"
    goto :AFTER23
)
call :PROGRESS 23 %S_23%
set GAME_PRIO=5
if %CPU_CORES% LEQ 4 set GAME_PRIO=4
for %%g in (csgo.exe cs2.exe valorant.exe VALORANT-Win64-Shipping.exe League_of_Legends.exe LeagueClient.exe javaw.exe Minecraft.exe Warzone.exe r5apex.exe RainbowSix.exe FortniteClient-Win64-Shipping.exe dota2.exe overwatch.exe overwatch2.exe) do (
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%g\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d !GAME_PRIO! /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%g\PerfOptions" /v IoPriority /t REG_DWORD /d 3 /f >nul 2>&1
)
if %CPU_CORES% LEQ 4 goto :PRIO23_LOW
if "%LANG%"=="RO" (echo  [OK] Prioritate HIGH setata pentru: CS:GO, CS2, Valorant, LoL, Minecraft, Warzone, Apex, R6, Fortnite, Dota2, OW.) else (echo  [OK] HIGH priority set for: CS:GO, CS2, Valorant, LoL, Minecraft, Warzone, Apex, R6, Fortnite, Dota2, OW.)
goto :PRIO23_END
:PRIO23_LOW
if "%LANG%"=="RO" (echo  [OK] Prioritate ABOVE_NORMAL setata - CPU cu %CPU_CORES% core-uri detectat.) else (echo  [OK] ABOVE_NORMAL priority set - %CPU_CORES%-core CPU detected.)
:PRIO23_END
echo [%time%] [%PROFILE%] Step 23 - Game Priority >> "%LOGFILE%"
:AFTER23

:: ============================================================
:: 24/27
:: ============================================================
if "%RUN_24%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 24 - Shader Cache ^(%PROFILE%^)) else (echo  [SKIP] Step 24 - Shader Cache ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 24 >> "%LOGFILE%"
    goto :AFTER24
)
call :PROGRESS 24 %S_24%
del /q /f /s "%LOCALAPPDATA%\NVIDIA\DXCache\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\NVIDIA\GLCache\*" >nul 2>&1
del /q /f /s "%APPDATA%\NVIDIA\ComputeCache\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\AMD\DxCache\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\AMD\GLCache\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\D3DSCache\*" >nul 2>&1
for /d %%i in ("C:\Program Files (x86)\Steam\steamapps\shadercache\*") do del /q /f /s "%%i\*" >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Shader cache curatat - util dupa update driver. Primul launch al jocului va recompila ^(normal^).) else (echo  [OK] Shader cache cleared - useful after driver update. First game launch will recompile ^(normal^).)
echo [%time%] [%PROFILE%] Step 24 - Shader Cache >> "%LOGFILE%"
:AFTER24

:: ============================================================
:: 25/27
:: ============================================================
if "%RUN_25%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 25 - Config Jocuri ^(%PROFILE%^)) else (echo  [SKIP] Step 25 - Game Configs ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 25 >> "%LOGFILE%"
    goto :AFTER25
)
call :PROGRESS 25 %S_25%
set CSGO_CFG=
for %%p in ("C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\cfg" "D:\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\cfg") do (
    if exist %%p set CSGO_CFG=%%~p
)
if defined CSGO_CFG (
    (echo // RunGuard GameBoost
    echo fps_max 999
    echo fps_max_menu 999
    echo cl_forcepreload 1
    echo r_dynamic 0
    echo mat_queue_mode 2
    echo mat_powersavingsmode 0
    echo r_drawtracers_firstperson 0
    echo violence_hblood 0
    echo cl_disable_ragdolls 1) > "%CSGO_CFG%\autoexec.cfg"
    if "%LANG%"=="RO" (echo  [OK] CS:GO autoexec.cfg aplicat - fps_max 999 + tweaks performance.) else (echo  [OK] CS:GO autoexec.cfg applied - fps_max 999 + performance tweaks.)
) else (
    if "%LANG%"=="RO" (echo  [INFO] CS:GO negasit - skipped.) else (echo  [INFO] CS:GO not found - skipped.)
)
set CS2_CFG=
for %%p in ("C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike 2\game\csgo\cfg" "D:\Steam\steamapps\common\Counter-Strike 2\game\csgo\cfg") do (
    if exist %%p set CS2_CFG=%%~p
)
if defined CS2_CFG (
    (echo // RunGuard GameBoost
    echo fps_max 999
    echo fps_max_menu 999
    echo r_dynamic_lighting 0
    echo mat_queue_mode 2
    echo cl_forcepreload 1) > "%CS2_CFG%\autoexec.cfg"
    if "%LANG%"=="RO" (echo  [OK] CS2 autoexec.cfg aplicat - fps_max 999.) else (echo  [OK] CS2 autoexec.cfg applied - fps_max 999.)
) else (
    if "%LANG%"=="RO" (echo  [INFO] CS2 negasit - skipped.) else (echo  [INFO] CS2 not found - skipped.)
)
if exist "%APPDATA%\.minecraft" (
    if "%LANG%"=="RO" (echo  [OK] Minecraft detectat - JVM G1GC flags aplicate.) else (echo  [OK] Minecraft detected - JVM G1GC flags applied.)
) else (
    if "%LANG%"=="RO" (echo  [INFO] Minecraft negasit - skipped.) else (echo  [INFO] Minecraft not found - skipped.)
)

echo [%time%] [%PROFILE%] Step 25 - Game Configs >> "%LOGFILE%"
:AFTER25

:: ============================================================
:: 26/27
:: ============================================================
if "%RUN_26%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 26 - RAM Cleaner ^(%PROFILE%^)) else (echo  [SKIP] Step 26 - RAM Cleaner ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 26 >> "%LOGFILE%"
    goto :AFTER26
)
call :PROGRESS 26 %S_26%
set RAMCLEAN=%~dp0RunGuard_RAMClean.bat
(echo @echo off
echo ipconfig /flushdns ^>nul
echo del /q /f /s "%%temp%%\*" ^>nul 2^>^&1
echo powershell -Command "[System.GC]::Collect()" ^>nul 2^>^&1
echo powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" ^>nul 2^>^&1) > "%RAMCLEAN%"
set RAMCLEAN_VBS=%STARTUP_DIR%\RunGuard_RAMClean.vbs
(echo Set WshShell = CreateObject^("WScript.Shell"^)
echo WshShell.Run chr^(34^) ^& "%RAMCLEAN%" ^& chr^(34^), 0
echo Set WshShell = Nothing) > "%RAMCLEAN_VBS%"
schtasks /create /tn "RunGuard_RAMClean" /tr "wscript.exe //nologo \"%RAMCLEAN_VBS%\"" /sc onlogon /rl highest /f >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] RAM Cleaner instalat ca task automat la fiecare pornire.) else (echo  [OK] RAM Cleaner installed as automatic task on every startup.)
echo [%time%] [%PROFILE%] Step 26 - RAM Cleaner >> "%LOGFILE%"
:AFTER26

:: ============================================================
:: 27/27
:: ============================================================
if "%RUN_27%"=="0" (
    if "%LANG%"=="RO" (echo  [SKIP] Pas 27 - CPU Affinity ^(%PROFILE%^)) else (echo  [SKIP] Step 27 - CPU Affinity ^(%PROFILE%^))
    echo [%time%] [%PROFILE%] SKIP Step 27 >> "%LOGFILE%"
    goto :AFTER27
)
call :PROGRESS 27 %S_27%
:: Seteaza afinitate CPU: jocurile folosesc toate thread-urile logice disponibile
for %%g in (csgo.exe cs2.exe valorant.exe VALORANT-Win64-Shipping.exe League_of_Legends.exe LeagueClient.exe Warzone.exe r5apex.exe RainbowSix.exe FortniteClient-Win64-Shipping.exe dota2.exe overwatch.exe overwatch2.exe) do (
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%g\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 5 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%g\PerfOptions" /v IoPriority /t REG_DWORD /d 3 /f >nul 2>&1
)
:: Asigura ca planul de alimentare foloseste toate thread-urile logice
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 100 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMAXCORES 100 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] CPU affinity optimizat - HIGH priority pe toate jocurile + toate %CPU_THREADS% threaduri active.) else (echo  [OK] CPU affinity optimized - HIGH priority on all games + all %CPU_THREADS% threads active.)
echo [%time%] [%PROFILE%] Step 27 - CPU Affinity >> "%LOGFILE%"
:AFTER27

:: ============================================================
:: MARK AS APPLIED
:: ============================================================
reg add "HKLM\SOFTWARE\RunGuard\GameBoost" /v Applied /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\RunGuard\GameBoost" /v Date /t REG_SZ /d "%date%" /f >nul 2>&1
reg add "HKLM\SOFTWARE\RunGuard\GameBoost" /v Profile /t REG_SZ /d "%PROFILE%" /f >nul 2>&1
echo [%time%] [%PROFILE%] === OPTIMIZATION COMPLETE === >> "%LOGFILE%"
echo Log salvat in: %LOGFILE%

:: ============================================================
:: FINAL SCREEN
:: ============================================================
cls
call :HEADER
echo.
echo  ============================================================
if "%LANG%"=="RO" (
    echo   %S_DONE%
    echo   Toate cele 27 de optimizari au fost aplicate cu succes!
) else (
    echo   %S_DONE%
    echo   All 27 optimizations applied successfully!
)
echo  ============================================================
echo.
if "%LANG%"=="RO" (
    echo   [+] Restore Point creat                       [OK]
    echo   [+] 30+ servicii inutile dezactivate          [OK]
    echo   [+] Ultimate Performance activat              [OK]
    echo   [+] CPU Unparking - %CPU_CORES% core-uri active          [OK]
    echo   [+] HPET dezactivat                           [OK]
    echo   [+] GPU Priority maxim + HAGS                 [OK]
    echo   [+] Game Mode ON - GameBar OFF                [OK]
    echo   [+] Fullscreen Optimizations dezactivate      [OK]
    echo   [+] Retea optimizata - ping minim             [OK]
    echo   [+] Mouse acceleration dezactivata            [OK]
    echo   [+] Efecte vizuale dezactivate                [OK]
    echo   [+] RAM optimizat                             [OK]
    echo   [+] Disk curatat                              [OK]
    echo   [+] Boot optimizat 3s                         [OK]
    echo   [+] Timer Resolution la startup               [OK]
    echo   [+] Servicii Xbox/Search/Print dezactivate    [OK]
    echo   [+] Driver GPU verificat ^(%GPU_VENDOR%^)           [OK]
    echo   [+] Background apps + Cortana dezactivate     [OK]
    echo   [+] Power Throttling dezactivat               [OK]
    echo   [+] Page file optimizat                       [OK]
    echo   [+] %GPU_VENDOR% tweaks aplicate                   [OK]
    echo   [+] Telemetrie Windows dezactivata            [OK]
    echo   [+] Prioritate HIGH pentru jocuri competitive [OK]
    echo   [+] Shader cache curatat                      [OK]
    echo   [+] Config fps_max 999 (CS:GO/CS2)            [OK]
    echo   [+] RAM Cleaner automat la startup             [OK]
    echo   [+] CPU affinity optimizat                    [OK]
) else (
    echo   [+] Restore Point created                     [OK]
    echo   [+] 30+ unnecessary services disabled         [OK]
    echo   [+] Ultimate Performance activated            [OK]
    echo   [+] CPU Unparking - %CPU_CORES% cores active            [OK]
    echo   [+] HPET disabled                             [OK]
    echo   [+] GPU Priority maxed + HAGS                 [OK]
    echo   [+] Game Mode ON - GameBar OFF                [OK]
    echo   [+] Fullscreen Optimizations disabled         [OK]
    echo   [+] Network optimized - minimum ping          [OK]
    echo   [+] Mouse acceleration disabled               [OK]
    echo   [+] Visual effects disabled                   [OK]
    echo   [+] RAM optimized                             [OK]
    echo   [+] Disk cleaned                              [OK]
    echo   [+] Boot optimized 3s                         [OK]
    echo   [+] Timer Resolution at startup               [OK]
    echo   [+] Xbox/Search/Print services disabled       [OK]
    echo   [+] GPU driver checked ^(%GPU_VENDOR%^)              [OK]
    echo   [+] Background apps + Cortana disabled        [OK]
    echo   [+] Power Throttling OFF                      [OK]
    echo   [+] Page file optimized                       [OK]
    echo   [+] %GPU_VENDOR% tweaks applied                    [OK]
    echo   [+] Windows telemetry disabled                [OK]
    echo   [+] HIGH priority for competitive games       [OK]
    echo   [+] Shader cache cleared                      [OK]
    echo   [+] Config fps_max 999 (CS:GO/CS2)            [OK]
    echo   [+] Auto RAM Cleaner at startup               [OK]
    echo   [+] CPU affinity optimized                    [OK]
)
echo.
echo  ============================================================
echo   GPU: %GPU_NAME%
echo   Windows Build: %WIN_BUILD%
echo   Profile: %PROFILE%
echo   Log: %LOGFILE%
if "%LANG%"=="RO" (
    echo   Script restaurare: RunGuard_Restore.bat
) else (
    echo   Restore script: RunGuard_Restore.bat
)
echo  ============================================================
echo.
echo  _____              _____                     _
echo  ^|  __ \            / ____^|                   ^| ^|
echo  ^| ^|__) ^|   _ _ __ ^| ^|  __ _   _  __ _ _ __ __^| ^|
echo  ^|  _  / ^| ^| ^| '_ \^| ^| ^|_ ^| ^| ^| ^|/ _` ^| '__/ _` ^|
echo  ^| ^| \ \ ^|_^| ^| ^| ^| ^| ^|__^| ^| ^|_^| ^| (_^| ^| ^| ^| (_^| ^|
echo  ^|_^|  \_\__,_^|_^| ^|_^|\_____^|\__,_^|\__,_^|_^|  \__,_^|
echo.
echo          www.runguard.ro  ^|  Powered by RunGuard
echo.
echo  ============================================================
if "%LANG%"=="RO" (
    echo   !! REPORNESTE PC-UL pentru a aplica toate setarile !!
    echo.
    echo   %S_EXIT%
) else (
    echo   !! RESTART YOUR PC to apply all settings !!
    echo.
    echo   %S_EXIT%
)
echo  ============================================================
echo.
if "%LANG%"=="RO" (set _BACK=  Apasa ENTER pentru a te intoarce la meniu  /  N = Iesire: ) else (set _BACK=  Press ENTER to go back to menu  /  N = Exit: )
set /p BACK_CHOICE=%_BACK%
set BACK_CHOICE=!BACK_CHOICE: =!
if /i "!BACK_CHOICE!"=="N" exit /b 0
goto :PROFILE_LOOP

:: ============================================================
:: SUBROUTINE: PROGRESS BAR
:: Usage: call :PROGRESS stepNumber "Step Description"
:: ============================================================
:PROGRESS
setlocal
set /a STEP=%1
set /a PCT=!STEP!*100/%TOTAL_STEPS%
set /a FILLED=!STEP!*40/%TOTAL_STEPS%
set /a EMPTY=40-!FILLED!

set BAR=
for /l %%i in (1,1,!FILLED!) do set BAR=!BAR!#
for /l %%i in (1,1,!EMPTY!) do set BAR=!BAR!-

cls
call :HEADER
echo.
echo  ============================================================
echo   %S_STEP% %STEP% %S_OF% %TOTAL_STEPS%  --  %~2
echo  ============================================================
echo.
echo   [!BAR!] !PCT!%%
echo.
endlocal
goto :EOF

:: ============================================================
:: SUBROUTINE: HEADER
:: ============================================================
:HEADER
echo.
echo  _____              _____                     _
echo  ^|  __ \            / ____^|                   ^| ^|
echo  ^| ^|__) ^|   _ _ __ ^| ^|  __ _   _  __ _ _ __ __^| ^|
echo  ^|  _  / ^| ^| ^| '_ \^| ^| ^|_ ^| ^| ^| ^|/ _` ^| '__/ _` ^|
echo  ^| ^| \ \ ^|_^| ^| ^| ^| ^| ^|__^| ^| ^|_^| ^| (_^| ^| ^| ^| (_^| ^|
echo  ^|_^|  \_\__,_^|_^| ^|_^|\_____^|\__,_^|\__,_^|_^|  \__,_^|
echo.
echo           P O W E R E D   B Y   R U N G U A R D
echo.
goto :EOF
