@echo off
chcp 65001 >nul 2>&1
color 0a
mode con: cols=85 lines=50
setlocal EnableDelayedExpansion

:: Flag: 0 = prima rulare, 1 = venim din meniu (sare "already run" check)
set CAME_FROM_MENU=0

:: ============================================================
:: CHECK ADMIN
:: ============================================================
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
choice /C 12 /N /M "  Choice / Alegere (1 or 2): "
set LANG=EN
if errorlevel 2 set LANG=RO

:: ============================================================
:: STRING DEFINITIONS
:: ============================================================
if "%LANG%"=="RO" (
    set S_TITLE=GAMING OPTIMIZER ULTRA - Powered by RunGuard
    set S_SCAN=Scanez hardware-ul tau...
    set S_CPU=Detectez CPU...
    set S_GPU=Detectez GPU...
    set S_WIN=Detectez versiunea Windows...
    set S_SSD=Detectez tipul de stocare...
    set S_RAM=Detectez RAM...
    set S_READY=SISTEM PREGATIT - Pornesc optimizarile...
    set S_DONE=OPTIMIZARE COMPLETA^^!
    set S_EXIT=Apasa orice tasta pentru a iesi...
    set S_STEP=Pas
    set S_OF=din
    set S_ALREADY_RUN=Rulat anterior pe data de
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
    set "S_16=Servicii extra dezactivate (Xbox, Search...)"
    set S_17=Verificare software GPU
    set S_18=Dezactivare background apps + Cortana
    set S_19=Power Throttling OFF + prioritate IRQ
    set S_20=Optimizare fisier de paginare
    set S_21=Tweaks specifice GPU
    set S_22=Dezactivare telemetrie Windows completa
    set S_23=Prioritate HIGH pentru jocuri competitive
    set S_24=Curatare shader cache GPU
    set "S_25=Config tweaks per joc (CS:GO, CS2, Minecraft)"
    set S_26=RAM Cleaner automat la pornire
    set S_27=Optimizare CPU priority pentru gaming
) else (
    set S_TITLE=GAMING OPTIMIZER ULTRA - Powered by RunGuard
    set S_SCAN=Scanning your hardware...
    set S_CPU=Detecting CPU...
    set S_GPU=Detecting GPU...
    set S_WIN=Detecting Windows version...
    set S_SSD=Detecting storage type...
    set S_RAM=Detecting RAM...
    set S_READY=SYSTEM READY - Starting optimizations...
    set S_DONE=OPTIMIZATION COMPLETE^^!
    set S_EXIT=Press any key to exit...
    set S_STEP=Step
    set S_OF=of
    set S_ALREADY_RUN=Previously run on
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
    set "S_16=Extra services disabled (Xbox, Search...)"
    set S_17=GPU software check
    set S_18=Disabling background apps + Cortana
    set S_19=Power Throttling OFF + IRQ priority
    set S_20=Page file optimization
    set S_21=GPU-specific tweaks
    set S_22=Disabling all Windows telemetry
    set S_23=HIGH priority for competitive games
    set S_24=GPU shader cache cleanup
    set "S_25=Per-game config tweaks (CS:GO, CS2, Minecraft)"
    set S_26=Automatic RAM Cleaner at startup
    set S_27=CPU priority optimization for gaming
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
    echo   [1]  SAFE  -----------------------------------------------
    echo        Modificari de baza, complet sigure, zero risc.
    echo        Dezactiveaza: servicii inutile, telemetrie, efecte
    echo        vizuale, accelerare mouse, GameDVR/GameBar.
    echo        Creeaza Restore Point inainte.
    echo        Recomandat: laptopuri, PC-uri de serviciu, orice PC.
    echo.
    echo   [2]  BALANCED  -------------------------------------------  [default]
    echo        Toate din SAFE + optimizari reale de gaming.
    echo        Adauga: Ultimate Performance, CPU unparking, GPU
    echo        priority, retea, RAM, boot 3s, background apps off,
    echo        Power Throttling off, prioritate HIGH jocuri, config
    echo        CS:GO/CS2.
    echo        Recomandat: majoritatea PC-urilor de gaming.
    echo.
    echo   [3]  EXTREME  --------------------------------------------
    echo        Toate din BALANCED + toate cele 27 de optimizari.
    echo        Adauga: HPET, timer resolution, servicii Xbox/Search
    echo        dezactivate, GPU tweaks specifice, shader cache
    echo        curatat, RAM cleaner startup, CPU affinity.
    echo        ATENTIE: Nu recomandat pe sisteme deja performante^^!
    echo        Recomandat: PC-uri mai vechi sau low-end.
    echo.
    echo   [4]  WINUTIL  - Chris Titus WinUtil ^(bloatware, reparare^)
    echo   [5]  NINITE   - Instaleaza programe gratuite rapid
    echo   [6]  ACTIVATE - Microsoft Activation Scripts ^(Windows/Office^)
    echo.
) else (
    echo  ============================================================
    echo   Select optimization profile:
    echo  ============================================================
    echo.
    echo   [1]  SAFE  -----------------------------------------------
    echo        Basic changes, completely safe, zero risk.
    echo        Disables: unnecessary services, telemetry, visual
    echo        effects, mouse acceleration, GameDVR/GameBar.
    echo        Creates a Restore Point first.
    echo        Recommended: laptops, work PCs, any PC.
    echo.
    echo   [2]  BALANCED  -------------------------------------------  [default]
    echo        Everything in SAFE + real gaming optimizations.
    echo        Adds: Ultimate Performance, CPU unparking, GPU
    echo        priority, network, RAM, 3s boot, background apps off,
    echo        Power Throttling off, HIGH priority games, CS:GO/CS2
    echo        config.
    echo        Recommended: most gaming PCs.
    echo.
    echo   [3]  EXTREME  --------------------------------------------
    echo        Everything in BALANCED + all 27 optimizations.
    echo        Adds: HPET, timer resolution, Xbox/Search services
    echo        disabled, GPU-specific tweaks, shader cache cleanup,
    echo        RAM cleaner startup, CPU affinity.
    echo        WARNING: Not recommended on already high-end systems^^!
    echo        Recommended: older or low-end PCs.
    echo.
    echo   [4]  WINUTIL  - Chris Titus WinUtil ^(bloatware, repair^)
    echo   [5]  NINITE   - Quickly install free programs
    echo   [6]  ACTIVATE - Microsoft Activation Scripts ^(Windows/Office^)
    echo.
)
choice /C 123456 /N /M "  Alegere / Choice [1/2/3/4/5/6]: "
set PROF_EL=%errorlevel%
set PROFILE=BALANCED
if "%PROF_EL%"=="1" set PROFILE=SAFE
if "%PROF_EL%"=="3" set PROFILE=EXTREME
if "%PROF_EL%"=="4" set PROFILE=WINUTIL
if "%PROF_EL%"=="5" set PROFILE=NINITE
if "%PROF_EL%"=="6" set PROFILE=ACTIVATE
echo Profil ales: %PROFILE% >> "%LOGFILE%"

:: ---- WARNING EXTREME ----
if not "%PROFILE%"=="EXTREME" goto :AFTER_EXTREME_WARN
cls
call :HEADER
echo.
if "%LANG%"=="RO" (
    echo  ============================================================
    echo   ^^!^^! ATENTIE - PROFIL EXTREME ^^!^^!
    echo  ============================================================
    echo.
    echo   Profilul EXTREME dezactiveaza agresiv servicii Windows,
    echo   modifica setari de sistem profunde si adauga taskuri la
    echo   startup. Pe sisteme deja performante, castigurile reale
    echo   de FPS sunt MINIME, iar riscurile sunt mai mari.
    echo.
    echo   EXTREME este conceput pentru PC-uri mai vechi sau low-end
    echo   care au nevoie de fiecare MHz disponibil.
    echo.
    echo   Daca ai unul dintre urmatoarele:
    echo     - Placa video: RTX 3000 / 4000 / 5000 sau RX 6000+
    echo     - Procesor:    Intel i7/i9 gen 10+ sau Ryzen 7/9
    echo     - RAM:         16 GB sau mai mult
    echo     - Windows:     instalat curat, fara bloatware
    echo.
    echo   ...atunci BALANCED este mai mult decat suficient si
    echo   mai sigur pentru sistemul tau.
    echo.
    echo  ============================================================
    echo   Ce vrei sa faci?
    echo  ============================================================
    echo.
    echo   [1]  Continua cu EXTREME  ^(stiu ce fac^)
    echo   [2]  Foloseste BALANCED   ^(recomandat pentru sisteme bune^)
    echo   [3]  Inapoi la meniu
    echo.
) else (
    echo  ============================================================
    echo   ^^!^^! WARNING - EXTREME PROFILE ^^!^^!
    echo  ============================================================
    echo.
    echo   The EXTREME profile aggressively disables Windows services,
    echo   modifies deep system settings and adds startup tasks. On
    echo   already high-end systems, real FPS gains are MINIMAL,
    echo   while risks are higher.
    echo.
    echo   EXTREME is designed for older or low-end PCs that need
    echo   every available MHz squeezed out.
    echo.
    echo   If you have any of the following:
    echo     - GPU:    RTX 3000 / 4000 / 5000 or RX 6000+
    echo     - CPU:    Intel i7/i9 gen 10+ or Ryzen 7/9
    echo     - RAM:    16 GB or more
    echo     - Windows: clean install, no bloatware
    echo.
    echo   ...then BALANCED is more than enough and safer for
    echo   your system.
    echo.
    echo  ============================================================
    echo   What do you want to do?
    echo  ============================================================
    echo.
    echo   [1]  Continue with EXTREME  ^(I know what I'm doing^)
    echo   [2]  Use BALANCED instead   ^(recommended for good systems^)
    echo   [3]  Back to menu
    echo.
)
choice /C 123 /N /M "  Alegere / Choice [1/2/3]: "
set EW_EL=%errorlevel%
if "%EW_EL%"=="2" set PROFILE=BALANCED
if "%EW_EL%"=="3" goto :PROFILE_LOOP
goto :AFTER_EXTREME_WARN
:AFTER_EXTREME_WARN

:: ---- WINUTIL ----
if not "%PROFILE%"=="WINUTIL" goto :AFTER_WINUTIL
cls
call :HEADER
echo.
if "%LANG%"=="RO" (
    echo  [*] Se lanseaza Chris Titus WinUtil...
    echo  [*] Va aparea o fereastra PowerShell cu interfata grafica.
    echo.
    echo  [!] ATENTIE: Acest tool descarca si executa cod remote.
    echo  [!] Asigura-te ca ai conexiune securizata.
) else (
    echo  [*] Launching Chris Titus WinUtil...
    echo  [*] A PowerShell window with the GUI will appear.
    echo.
    echo  [!] WARNING: This tool downloads and executes remote code.
    echo  [!] Make sure you have a secure connection.
)
echo.
echo [%time%] [WINUTIL] Launched >> "%LOGFILE%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm christitus.com/win | iex"
echo.
if "%LANG%"=="RO" (echo   [1] Inapoi la meniu  [2] Iesire) else (echo   [1] Back to menu  [2] Exit)
echo.
choice /C 12 /N /M "  Alegere / Choice [1/2]: "
if errorlevel 2 goto :EXIT_SCRIPT
set CAME_FROM_MENU=1
goto :PROFILE_LOOP
:AFTER_WINUTIL

:: ---- NINITE ----
if not "%PROFILE%"=="NINITE" goto :AFTER_NINITE
cls
call :HEADER
echo.
if "%LANG%"=="RO" (echo  [*] Se deschide Ninite.com...) else (echo  [*] Opening Ninite.com...)
echo [%time%] [NINITE] Opened >> "%LOGFILE%"
start "" "https://ninite.com/"
if "%LANG%"=="RO" (echo  [OK] Ninite.com deschis in browser.) else (echo  [OK] Ninite.com opened in browser.)
echo.
if "%LANG%"=="RO" (echo   [1] Inapoi la meniu  [2] Iesire) else (echo   [1] Back to menu  [2] Exit)
echo.
choice /C 12 /N /M "  Alegere / Choice [1/2]: "
if errorlevel 2 goto :EXIT_SCRIPT
set CAME_FROM_MENU=1
goto :PROFILE_LOOP
:AFTER_NINITE

:: ---- ACTIVATE ----
if not "%PROFILE%"=="ACTIVATE" goto :AFTER_ACTIVATE
cls
call :HEADER
echo.
if "%LANG%"=="RO" (
    echo  ============================================================
    echo   ^^!^^! ATENTIE - COD REMOTE / FOLOSIRE PE PROPRIA RASPUNDERE ^^!^^!
    echo  ============================================================
    echo.
    echo   Aceasta optiune descarca si executa un script direct de pe
    echo   internet ^(https://get.activated.win^) intr-o fereastra
    echo   PowerShell separata.
    echo.
    echo   Prin continuare, confirmi ca:
    echo     - Intelegi ca rulezi cod descarcat de pe internet
    echo     - Accepti responsabilitatea pentru utilizarea acestui tool
    echo     - RunGuard nu este afiliat cu Microsoft Activation Scripts
    echo     - Folosesti aceasta functie pe propria raspundere
    echo.
    echo   Sursa: https://github.com/massgravel/Microsoft-Activation-Scripts
    echo.
    echo  ============================================================
    echo   Apasa Y pentru a continua sau orice alta tasta pentru inapoi
    echo  ============================================================
) else (
    echo  ============================================================
    echo   ^^!^^! WARNING - REMOTE CODE / USE AT YOUR OWN RISK ^^!^^!
    echo  ============================================================
    echo.
    echo   This option downloads and executes a script directly from
    echo   the internet ^(https://get.activated.win^) in a separate
    echo   PowerShell window.
    echo.
    echo   By continuing, you confirm that:
    echo     - You understand you are running code downloaded from internet
    echo     - You accept responsibility for using this tool
    echo     - RunGuard is not affiliated with Microsoft Activation Scripts
    echo     - You use this feature at your own risk
    echo.
    echo   Source: https://github.com/massgravel/Microsoft-Activation-Scripts
    echo.
    echo  ============================================================
    echo   Press Y to continue or any other key to go back
    echo  ============================================================
)
echo.
choice /C YN /N /M "  Y / N: "
if errorlevel 2 (
    set CAME_FROM_MENU=1
    goto :PROFILE_LOOP
)
cls
call :HEADER
echo.
if "%LANG%"=="RO" (
    echo  [*] Se lanseaza Microsoft Activation Scripts...
    echo  [*] Va aparea o fereastra PowerShell cu meniul de activare.
    echo  [*] Inchide fereastra PowerShell cand ai terminat.
) else (
    echo  [*] Launching Microsoft Activation Scripts...
    echo  [*] A PowerShell window with the activation menu will appear.
    echo  [*] Close the PowerShell window when done.
)
echo.
echo [%time%] [ACTIVATE] Launched >> "%LOGFILE%"
start "Microsoft Activation Scripts" powershell.exe -NoProfile -ExecutionPolicy Bypass -NoExit -Command "irm https://get.activated.win | iex"
echo.
if "%LANG%"=="RO" (echo   [1] Inapoi la meniu  [2] Iesire) else (echo   [1] Back to menu  [2] Exit)
echo.
choice /C 12 /N /M "  Alegere / Choice [1/2]: "
if errorlevel 2 goto :EXIT_SCRIPT
set CAME_FROM_MENU=1
goto :PROFILE_LOOP
:AFTER_ACTIVATE

:: ============================================================
:: STEPS ACTIVE PER PROFILE  (1=run, 0=skip)
:: ============================================================
set RUN_1=1&set RUN_2=1&set RUN_3=1&set RUN_4=1&set RUN_5=1&set RUN_6=1
set RUN_7=1&set RUN_8=1&set RUN_9=1&set RUN_10=1&set RUN_11=1&set RUN_12=1
set RUN_13=1&set RUN_14=1&set RUN_15=1&set RUN_16=1&set RUN_17=1&set RUN_18=1
set RUN_19=1&set RUN_20=1&set RUN_21=1&set RUN_22=1&set RUN_23=1&set RUN_24=1
set RUN_25=1&set RUN_26=1&set RUN_27=1

if "%PROFILE%"=="SAFE" (
    set RUN_3=0&set RUN_4=0&set RUN_5=0&set RUN_6=0&set RUN_8=0
    set RUN_9=0&set RUN_12=0&set RUN_14=0&set RUN_15=0&set RUN_16=0
    set RUN_17=0&set RUN_19=0&set RUN_20=0&set RUN_21=0&set RUN_23=0
    set RUN_24=0&set RUN_25=0&set RUN_26=0&set RUN_27=0
)
if "%PROFILE%"=="BALANCED" (
    set RUN_5=0&set RUN_15=0&set RUN_16=0&set RUN_17=0
    set RUN_20=0&set RUN_21=0&set RUN_24=0&set RUN_26=0&set RUN_27=0
)

:: ============================================================
:: CHECK IF ALREADY RUN (sare daca venim din meniu)
:: ============================================================
if "!CAME_FROM_MENU!"=="1" goto :SKIP_RERUN
set PREV_DATE=
for /f "tokens=3" %%i in ('reg query "HKLM\SOFTWARE\RunGuard\GameBoost" /v Date 2^>nul') do set PREV_DATE=%%i
if not defined PREV_DATE goto :SKIP_RERUN
cls
call :HEADER
echo.
if "%LANG%"=="RO" (
    echo  ============================================================
    echo   Scriptul a mai fost rulat pe acest PC.
    echo   %S_ALREADY_RUN%: %PREV_DATE%
    echo.
    echo   Continua automat in 5 secunde sau apasa orice tasta...
    echo  ============================================================
) else (
    echo  ============================================================
    echo   This script has already been run on this PC.
    echo   %S_ALREADY_RUN%: %PREV_DATE%
    echo.
    echo   Continuing automatically in 5 seconds or press any key...
    echo  ============================================================
)
echo.
timeout /t 5 >nul 2>&1
:SKIP_RERUN

:: ============================================================
:: INTRO
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
if "%LANG%"=="RO" (echo   Apasa orice tasta pentru a incepe...) else (echo   Press any key to start...)
pause >nul

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
if not defined CPU_THREADS set CPU_THREADS=4
set IS_HIGH_END_CPU=0
echo !CPU_NAME! | findstr /i "i7 i9 Ryzen 7 Ryzen 9" >nul 2>&1
if !errorLevel!==0 set IS_HIGH_END_CPU=1
if "%LANG%"=="RO" (echo  [OK] CPU: !CPU_NAME! -- !CPU_CORES! nuclee / !CPU_THREADS! threaduri) else (echo  [OK] CPU: !CPU_NAME! -- !CPU_CORES! cores / !CPU_THREADS! threads)

echo  [....] %S_GPU%
for /f "tokens=2 delims==" %%i in ('wmic path win32_VideoController get Name /value 2^>nul') do set GPU_NAME=%%i
set GPU_VENDOR=UNKNOWN
set GPU_GEN=LEGACY
echo !GPU_NAME! | findstr /i "NVIDIA" >nul 2>&1
if !errorLevel!==0 set GPU_VENDOR=NVIDIA
echo !GPU_NAME! | findstr /i "AMD Radeon" >nul 2>&1
if !errorLevel!==0 set GPU_VENDOR=AMD
echo !GPU_NAME! | findstr /i "Intel" >nul 2>&1
if !errorLevel!==0 set GPU_VENDOR=INTEL
echo !GPU_NAME! | findstr /i "RTX" >nul 2>&1
if !errorLevel!==0 set GPU_GEN=MODERN
echo !GPU_NAME! | findstr /i /C:"RX 55" /C:"RX 56" /C:"RX 57" /C:"RX 6" /C:"RX 7" /C:"RX 9" >nul 2>&1
if !errorLevel!==0 set GPU_GEN=MODERN
if "%LANG%"=="RO" (echo  [OK] GPU: !GPU_NAME! -- !GPU_VENDOR! -- Gen: !GPU_GEN!) else (echo  [OK] GPU: !GPU_NAME! -- !GPU_VENDOR! -- Gen: !GPU_GEN!)

echo  [....] %S_WIN%
for /f "tokens=3" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild 2^>nul') do set WIN_BUILD=%%i
if not defined WIN_BUILD set WIN_BUILD=0
set IS_WIN11=0
if !WIN_BUILD! GEQ 22000 set IS_WIN11=1
if !IS_WIN11!==1 (echo  [OK] Windows 11 - Build !WIN_BUILD!) else (echo  [OK] Windows 10 - Build !WIN_BUILD!)

echo  [....] %S_SSD%
set IS_SSD=0
for /f "skip=1 tokens=*" %%i in ('powershell -NoProfile -Command "Get-PhysicalDisk | Select-Object -ExpandProperty MediaType" 2^>nul') do (
    if /i "%%i"=="SSD" set IS_SSD=1
)
if !IS_SSD!==1 (
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
:: GENERATE RESTORE SCRIPT
:: ============================================================
set UNDO=%~dp0RunGuard_Restore.bat
> "%UNDO%" echo @echo off
>> "%UNDO%" echo chcp 65001 ^>nul 2^>^&1
>> "%UNDO%" echo color 0c
>> "%UNDO%" echo title RunGuard - Restore Original Settings
>> "%UNDO%" echo setlocal EnableDelayedExpansion
>> "%UNDO%" echo.
>> "%UNDO%" echo net sessions ^>nul 2^>^&1
>> "%UNDO%" echo if %%errorLevel%% neq 0 ^(echo [ERROR] Run as ADMIN ^& pause ^& exit /b 1^)
>> "%UNDO%" echo.
>> "%UNDO%" echo echo  ============================================================
>> "%UNDO%" echo echo   RunGuard GameBoost - RESTAURARE / RESTORE
>> "%UNDO%" echo echo  ============================================================
>> "%UNDO%" echo echo.
>> "%UNDO%" echo pause
>> "%UNDO%" echo.
>> "%UNDO%" echo :: Restore Point
>> "%UNDO%" echo powershell -Command "Enable-ComputerRestore -Drive 'C:\' -EA SilentlyContinue; Checkpoint-Computer -Description 'RunGuard Restore' -RestorePointType 'MODIFY_SETTINGS' -EA SilentlyContinue"
>> "%UNDO%" echo echo [OK] Restore Point creat.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: Power Plan Balanced
>> "%UNDO%" echo powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] Power Plan Balanced restaurat.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: CPU throttling defaults
>> "%UNDO%" echo powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 5 ^>nul 2^>^&1
>> "%UNDO%" echo powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100 ^>nul 2^>^&1
>> "%UNDO%" echo powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 0 ^>nul 2^>^&1
>> "%UNDO%" echo powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMAXCORES 100 ^>nul 2^>^&1
>> "%UNDO%" echo powercfg /setactive SCHEME_CURRENT ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] CPU throttling restaurat.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: HPET
>> "%UNDO%" echo bcdedit /deletevalue useplatformtick ^>nul 2^>^&1
>> "%UNDO%" echo bcdedit /deletevalue disabledynamictick ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] HPET restaurat.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: GPU
>> "%UNDO%" echo reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 1 /f ^>nul 2^>^&1
>> "%UNDO%" echo reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 2 /f ^>nul 2^>^&1
>> "%UNDO%" echo reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 2 /f ^>nul 2^>^&1
>> "%UNDO%" echo reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d Medium /f ^>nul 2^>^&1
>> "%UNDO%" echo reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d Normal /f ^>nul 2^>^&1
>> "%UNDO%" echo reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d True /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /f ^>nul 2^>^&1
>> "%UNDO%" echo reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 20 /f ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] GPU registry restaurat.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: GameDVR
>> "%UNDO%" echo reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 0 /f ^>nul 2^>^&1
>> "%UNDO%" echo reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 1 /f ^>nul 2^>^&1
>> "%UNDO%" echo reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 1 /f ^>nul 2^>^&1
>> "%UNDO%" echo reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /t REG_DWORD /d 0 /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /f ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] Game Mode / GameDVR restaurate.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: Retea
>> "%UNDO%" echo reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultTTL /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpTimedWaitDelay /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v MaxUserPort /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /f ^>nul 2^>^&1
>> "%UNDO%" echo netsh int tcp set global autotuninglevel=normal ^>nul 2^>^&1
>> "%UNDO%" echo netsh int tcp set global ecncapability=default ^>nul 2^>^&1
>> "%UNDO%" echo netsh int tcp set global timestamps=default ^>nul 2^>^&1
>> "%UNDO%" echo netsh int tcp set heuristics enabled ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] Retea restaurata.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: Mouse
>> "%UNDO%" echo reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 1 /f ^>nul 2^>^&1
>> "%UNDO%" echo reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 6 /f ^>nul 2^>^&1
>> "%UNDO%" echo reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 10 /f ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] Mouse acceleration restaurata.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: Efecte vizuale
>> "%UNDO%" echo reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 400 /f ^>nul 2^>^&1
>> "%UNDO%" echo reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 1 /f ^>nul 2^>^&1
>> "%UNDO%" echo reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 0 /f ^>nul 2^>^&1
>> "%UNDO%" echo reg add "HKCU\Software\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 1 /f ^>nul 2^>^&1
>> "%UNDO%" echo reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 1 /f ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] Efecte vizuale restaurate.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: RAM
>> "%UNDO%" echo reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 0 /f ^>nul 2^>^&1
>> "%UNDO%" echo powershell -Command "Enable-MMAgent -MemoryCompression -EA SilentlyContinue" ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] RAM restaurat.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: Hibernare
>> "%UNDO%" echo powercfg -h on ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] Hibernare re-activata.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: Boot
>> "%UNDO%" echo bcdedit /timeout 30 ^>nul 2^>^&1
>> "%UNDO%" echo bcdedit /debug off ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] Boot timeout restaurat.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: Timer Resolution task
>> "%UNDO%" echo del /f /q "%%APPDATA%%\Microsoft\Windows\Start Menu\Programs\Startup\RunGuard_TimerRes.vbs" ^>nul 2^>^&1
>> "%UNDO%" echo del /f /q "%%APPDATA%%\Microsoft\Windows\Start Menu\Programs\Startup\RunGuard_TimerRes.bat" ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] Timer Resolution task eliminat.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: Servicii Xbox / Search
>> "%UNDO%" echo sc config XblAuthManager start= demand ^>nul 2^>^&1
>> "%UNDO%" echo sc config XblGameSave start= demand ^>nul 2^>^&1
>> "%UNDO%" echo sc config XboxNetApiSvc start= demand ^>nul 2^>^&1
>> "%UNDO%" echo sc config XboxGipSvc start= demand ^>nul 2^>^&1
>> "%UNDO%" echo sc config xbgm start= demand ^>nul 2^>^&1
>> "%UNDO%" echo sc config CDPSvc start= demand ^>nul 2^>^&1
>> "%UNDO%" echo sc config RemoteRegistry start= demand ^>nul 2^>^&1
>> "%UNDO%" echo sc config wisvc start= demand ^>nul 2^>^&1
>> "%UNDO%" echo sc config WpnService start= demand ^>nul 2^>^&1
>> "%UNDO%" echo sc config DoSvc start= demand ^>nul 2^>^&1
>> "%UNDO%" echo sc config WSearch start= auto ^>nul 2^>^&1
>> "%UNDO%" echo sc config Spooler start= auto ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] Servicii restaurate.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: Background apps / Cortana
>> "%UNDO%" echo reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 0 /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsRunInBackground /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /f ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] Background apps / Cortana restaurate.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: Power Throttling
>> "%UNDO%" echo reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /f ^>nul 2^>^&1
>> "%UNDO%" echo reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 2 /f ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] Power Throttling restaurat.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: GPU telemetrie
>> "%UNDO%" echo sc config NvTelemetryContainer start= auto ^>nul 2^>^&1
>> "%UNDO%" echo sc config "AMD Crash Defender Service" start= auto ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v DirectXUserGlobalSettings /f ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] GPU tweaks restaurate.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: Telemetrie Windows
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /f ^>nul 2^>^&1
>> "%UNDO%" echo reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 1 /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /f ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] Telemetrie restaurata.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: Game priority IFEO
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csgo.exe\PerfOptions" /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\cs2.exe\PerfOptions" /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\valorant.exe\PerfOptions" /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\VALORANT-Win64-Shipping.exe\PerfOptions" /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\League_of_Legends.exe\PerfOptions" /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\LeagueClient.exe\PerfOptions" /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\javaw.exe\PerfOptions" /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Minecraft.exe\PerfOptions" /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Warzone.exe\PerfOptions" /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\r5apex.exe\PerfOptions" /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RainbowSix.exe\PerfOptions" /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dota2.exe\PerfOptions" /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FortniteClient-Win64-Shipping.exe\PerfOptions" /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\overwatch.exe\PerfOptions" /f ^>nul 2^>^&1
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\overwatch2.exe\PerfOptions" /f ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] Game priority IFEO eliminat.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: RAM Cleaner task
>> "%UNDO%" echo schtasks /delete /tn "RunGuard_RAMClean" /f ^>nul 2^>^&1
>> "%UNDO%" echo del /f /q "%%APPDATA%%\Microsoft\Windows\Start Menu\Programs\Startup\RunGuard_RAMClean.vbs" ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] RAM Cleaner task eliminat.
>> "%UNDO%" echo.
>> "%UNDO%" echo :: RunGuard marker
>> "%UNDO%" echo reg delete "HKLM\SOFTWARE\RunGuard\GameBoost" /f ^>nul 2^>^&1
>> "%UNDO%" echo echo [OK] RunGuard marker eliminat.
>> "%UNDO%" echo.
>> "%UNDO%" echo echo  ============================================================
>> "%UNDO%" echo echo   RESTAURARE COMPLETA^^! Reporneste PC-ul.
>> "%UNDO%" echo echo   RESTORE COMPLETE^^! Restart your PC.
>> "%UNDO%" echo echo  ============================================================
>> "%UNDO%" echo echo.
>> "%UNDO%" echo pause

:: ============================================================
:: 1/27 - RESTORE POINT
:: ============================================================
if "%RUN_1%"=="0" goto :AFTER1
call :PROGRESS 1 "%S_01%"
powershell -Command "Enable-ComputerRestore -Drive 'C:\' -ErrorAction SilentlyContinue; Checkpoint-Computer -Description 'RunGuard GameBoost' -RestorePointType 'MODIFY_SETTINGS' -ErrorAction SilentlyContinue"
if "%LANG%"=="RO" (echo  [OK] Restore Point creat.) else (echo  [OK] Restore Point created.)
echo [%time%] [%PROFILE%] Step 1 - Restore Point >> "%LOGFILE%"
:AFTER1

:: ============================================================
:: 2/27 - SERVICII INUTILE
:: ============================================================
if "%RUN_2%"=="0" goto :AFTER2
call :PROGRESS 2 "%S_02%"
sc stop DiagTrack >nul 2>&1 & sc config DiagTrack start= disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1 & sc config dmwappushservice start= disabled >nul 2>&1
sc stop WerSvc >nul 2>&1 & sc config WerSvc start= disabled >nul 2>&1
for %%s in (MapsBroker RetailDemo TabletInputService Fax lfsvc WMPNetworkSvc icssvc wisvc PhoneSvc TapiSrv SEMgrSvc) do (
    sc stop %%s >nul 2>&1 & sc config %%s start= disabled >nul 2>&1
)
if !IS_SSD!==1 (
    sc stop SysMain >nul 2>&1 & sc config SysMain start= disabled >nul 2>&1
    if "%LANG%"=="RO" (echo  [OK] Servicii dezactivate + SysMain dezactivat ^(SSD^).) else (echo  [OK] Services disabled + SysMain disabled ^(SSD^).)
) else (
    if "%LANG%"=="RO" (echo  [OK] Servicii dezactivate. SysMain pastrat ^(HDD^).) else (echo  [OK] Services disabled. SysMain kept ^(HDD^).)
)
echo [%time%] [%PROFILE%] Step 2 - Services >> "%LOGFILE%"
:AFTER2

:: ============================================================
:: 3/27 - POWER PLAN
:: ============================================================
if "%RUN_3%"=="0" goto :AFTER3
call :PROGRESS 3 "%S_03%"
powercfg /duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
set ULTIMATE_GUID=
for /f "tokens=4" %%G in ('powercfg /list ^| findstr /i "Ultimate"') do set ULTIMATE_GUID=%%G
if defined ULTIMATE_GUID (
    powercfg /setactive !ULTIMATE_GUID! >nul 2>&1
    if "%LANG%"=="RO" (echo  [OK] Ultimate Performance activat.) else (echo  [OK] Ultimate Performance activated.)
) else (
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
    if "%LANG%"=="RO" (echo  [OK] High Performance activat.) else (echo  [OK] High Performance activated.)
)
echo [%time%] [%PROFILE%] Step 3 - Power Plan >> "%LOGFILE%"
:AFTER3

:: ============================================================
:: 4/27 - CPU UNPARKING
:: ============================================================
if "%RUN_4%"=="0" goto :AFTER4
call :PROGRESS 4 "%S_04%"
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 100 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 100 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMAXCORES 100 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Toate !CPU_CORES! core-uri active la viteza maxima.) else (echo  [OK] All !CPU_CORES! cores unparked at full speed.)
echo [%time%] [%PROFILE%] Step 4 - CPU Unparking >> "%LOGFILE%"
:AFTER4

:: ============================================================
:: 5/27 - HPET
:: ============================================================
if "%RUN_5%"=="0" goto :AFTER5
call :PROGRESS 5 "%S_05%"
if "!IS_HIGH_END_CPU!"=="1" (
    bcdedit /deletevalue useplatformclock >nul 2>&1
    bcdedit /set useplatformtick yes >nul 2>&1
    bcdedit /set disabledynamictick yes >nul 2>&1
    if "%LANG%"=="RO" (echo  [OK] HPET dezactivat - CPU performant detectat.) else (echo  [OK] HPET disabled - high-end CPU detected.)
) else (
    if "%LANG%"=="RO" (echo  [SKIP] HPET - CPU entry-level, pastrat activ pentru stabilitate.) else (echo  [SKIP] HPET - entry-level CPU, kept active for stability.)
)
echo [%time%] [%PROFILE%] Step 5 - HPET >> "%LOGFILE%"
:AFTER5

:: ============================================================
:: 6/27 - GPU OPTIMIZATION
:: SystemResponsiveness=10 (nu 0) - valoarea 0 poate cauza audio stutter
:: HAGS activat DOAR pe GPU-uri moderne - pe GTX/RX400-500/R9 poate cauza frame pacing issues
:: ============================================================
if "%RUN_6%"=="0" goto :AFTER6
call :PROGRESS 6 "%S_06%"
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d High /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d False /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 10 /f >nul 2>&1
if "!GPU_GEN!"=="MODERN" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul 2>&1
    if "%LANG%"=="RO" (echo  [OK] GPU Priority maxim + HAGS activat ^(!GPU_NAME!^).) else (echo  [OK] GPU Priority maxed + HAGS enabled ^(!GPU_NAME!^).)
) else (
    if "%LANG%"=="RO" (echo  [OK] GPU Priority maxim. HAGS pastrat - placa mai veche detectata ^(!GPU_NAME!^).) else (echo  [OK] GPU Priority maxed. HAGS left unchanged - older GPU ^(!GPU_NAME!^).)
)
echo [%time%] [%PROFILE%] Step 6 - GPU >> "%LOGFILE%"
:AFTER6

:: ============================================================
:: 7/27 - GAME MODE + GAMEBAR OFF
:: ============================================================
if "%RUN_7%"=="0" goto :AFTER7
call :PROGRESS 7 "%S_07%"
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v ShowGameModeNotifications /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehavior /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_HonorUserFSEBehaviorMode /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Game Mode activat - GameBar si GameDVR dezactivate.) else (echo  [OK] Game Mode ON - GameBar and GameDVR disabled.)
echo [%time%] [%PROFILE%] Step 7 - Game Mode >> "%LOGFILE%"
:AFTER7

:: ============================================================
:: 8/27 - FULLSCREEN OPTIMIZATIONS
:: ============================================================
if "%RUN_8%"=="0" goto :AFTER8
call :PROGRESS 8 "%S_08%"
reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_DSEBehavior /t REG_DWORD /d 2 /f >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Fullscreen Optimizations dezactivate.) else (echo  [OK] Fullscreen Optimizations disabled.)
echo [%time%] [%PROFILE%] Step 8 - Fullscreen >> "%LOGFILE%"
:AFTER8

:: ============================================================
:: 9/27 - NETWORK
:: Nota: ctcp (Compound TCP) eliminat din Windows 10 1803+ - nu se seteaza
:: ============================================================
if "%RUN_9%"=="0" goto :AFTER9
call :PROGRESS 9 "%S_09%"
for /f "tokens=*" %%k in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /k 2^>nul ^| findstr "HKEY"') do (
    reg add "%%k" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%k" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul 2>&1
)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultTTL /t REG_DWORD /d 64 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpTimedWaitDelay /t REG_DWORD /d 30 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v MaxUserPort /t REG_DWORD /d 65534 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f >nul 2>&1
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global ecncapability=disabled >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1
netsh int tcp set global rss=enabled >nul 2>&1
netsh int tcp set global maxsynretransmissions=2 >nul 2>&1
netsh int tcp set heuristics disabled >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Retea optimizata - latenta minima.) else (echo  [OK] Network optimized - minimum latency.)
echo [%time%] [%PROFILE%] Step 9 - Network >> "%LOGFILE%"
:AFTER9

:: ============================================================
:: 10/27 - MOUSE ACCELERATION
:: ============================================================
if "%RUN_10%"=="0" goto :AFTER10
call :PROGRESS 10 "%S_10%"
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Accelerare mouse dezactivata - input 1:1.) else (echo  [OK] Mouse acceleration disabled - raw 1:1 input.)
echo [%time%] [%PROFILE%] Step 10 - Mouse >> "%LOGFILE%"
:AFTER10

:: ============================================================
:: 11/27 - VISUAL EFFECTS
:: ============================================================
if "%RUN_11%"=="0" goto :AFTER11
call :PROGRESS 11 "%S_11%"
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Efecte vizuale dezactivate - GPU eliberat.) else (echo  [OK] Visual effects disabled - GPU freed.)
echo [%time%] [%PROFILE%] Step 11 - Visual FX >> "%LOGFILE%"
:AFTER11

:: ============================================================
:: 12/27 - RAM
:: ============================================================
if "%RUN_12%"=="0" goto :AFTER12
call :PROGRESS 12 "%S_12%"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 0 /f >nul 2>&1
if "!IS_HIGH_RAM!"=="1" (
    powershell -Command "Disable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue" >nul 2>&1
    if "%LANG%"=="RO" (echo  [OK] RAM: kernel blocat, compresie dezactivata ^(16GB+^).) else (echo  [OK] RAM: kernel locked, compression disabled ^(16GB+^).)
) else (
    if "%LANG%"=="RO" (echo  [OK] RAM: kernel blocat. Compresie pastrata ^(sub 16GB^).) else (echo  [OK] RAM: kernel locked. Compression kept ^(under 16GB^).)
)
echo [%time%] [%PROFILE%] Step 12 - RAM >> "%LOGFILE%"
:AFTER12

:: ============================================================
:: 13/27 - DISK CLEANUP (independent de step 12)
:: ============================================================
if "%RUN_13%"=="0" goto :AFTER13
call :PROGRESS 13 "%S_13%"
ipconfig /flushdns >nul 2>&1
del /q /f /s "%temp%\*" >nul 2>&1
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\D3DSCache\*" >nul 2>&1
powercfg -h off >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Disk curatat - DNS flush, temp files, hibernare dezactivata.) else (echo  [OK] Disk cleaned - DNS flush, temp files, hibernation disabled.)
echo [%time%] [%PROFILE%] Step 13 - Disk >> "%LOGFILE%"
:AFTER13

:: ============================================================
:: 14/27 - BOOT
:: ============================================================
if "%RUN_14%"=="0" goto :AFTER14
call :PROGRESS 14 "%S_14%"
bcdedit /timeout 3 >nul 2>&1
bcdedit /debug off >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Boot optimizat - timeout 3s.) else (echo  [OK] Boot optimized - timeout 3s.)
echo [%time%] [%PROFILE%] Step 14 - Boot >> "%LOGFILE%"
:AFTER14

:: ============================================================
:: 15/27 - TIMER RESOLUTION
:: Din Windows 10 build 19041 timer resolution e per-process - global nu mai are efect
:: ============================================================
if "%RUN_15%"=="0" goto :AFTER15
call :PROGRESS 15 "%S_15%"
if !WIN_BUILD! GEQ 19041 (
    if "%LANG%"=="RO" (echo  [INFO] Timer Resolution global nu are efect pe Build !WIN_BUILD!+. Skipped.) else (echo  [INFO] Global Timer Resolution has no effect on Build !WIN_BUILD!+. Skipped.)
    echo [%time%] [%PROFILE%] Step 15 - Timer Res skipped modern build >> "%LOGFILE%"
    goto :AFTER15
)
set SD=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
set SP=%TEMP%\rg_timerres.ps1
> "%SP%" echo Add-Type -TypeDefinition @"
>> "%SP%" echo using System;
>> "%SP%" echo using System.Runtime.InteropServices;
>> "%SP%" echo public class WinAPI {
>> "%SP%" echo     [DllImport^("ntdll.dll"^)] public static extern int NtSetTimerResolution^(int d, bool s, out int r^);
>> "%SP%" echo }
>> "%SP%" echo "@
>> "%SP%" echo [int]$r = 0
>> "%SP%" echo [WinAPI]::NtSetTimerResolution^(5000, $true, [ref]$r^) ^| Out-Null
> "%SD%\RunGuard_TimerRes.bat" echo @echo off
>> "%SD%\RunGuard_TimerRes.bat" echo powershell -NoProfile -ExecutionPolicy Bypass -File "%SP%"
> "%SD%\RunGuard_TimerRes.vbs" echo Set WshShell = CreateObject^("WScript.Shell"^)
>> "%SD%\RunGuard_TimerRes.vbs" echo WshShell.Run chr^(34^) ^& "%SD%\RunGuard_TimerRes.bat" ^& chr^(34^), 0
>> "%SD%\RunGuard_TimerRes.vbs" echo Set WshShell = Nothing
if "%LANG%"=="RO" (echo  [OK] Timer Resolution instalat ca task startup.) else (echo  [OK] Timer Resolution installed as startup task.)
echo [%time%] [%PROFILE%] Step 15 - Timer Resolution >> "%LOGFILE%"
:AFTER15

:: ============================================================
:: 16/27 - SERVICII EXTRA
:: WbioSrvc (Windows Hello) si DPS (Network Troubleshooter) - PASTRATE ACTIVE
:: ============================================================
if "%RUN_16%"=="0" goto :AFTER16
call :PROGRESS 16 "%S_16%"
for %%s in (XblAuthManager XblGameSave XboxNetApiSvc XboxGipSvc xbgm CDPSvc RemoteRegistry wisvc WpnService DoSvc) do (
    sc stop %%s >nul 2>&1 & sc config %%s start= disabled >nul 2>&1
)
sc stop WSearch >nul 2>&1 & sc config WSearch start= disabled >nul 2>&1
if "%LANG%"=="RO" (echo  [!] WSearch dezactivat - Start Menu search mai lent fara indexare.) else (echo  [!] WSearch disabled - Start Menu search slower without indexing.)
set HAS_PRINTER=0
for /f "skip=1 tokens=*" %%p in ('wmic printer get name 2^>nul') do (
    set _L=%%p
    set _L=!_L: =!
    if not "!_L!"=="" set HAS_PRINTER=1
)
if "!HAS_PRINTER!"=="0" (
    sc stop Spooler >nul 2>&1 & sc config Spooler start= disabled >nul 2>&1
    if "%LANG%"=="RO" (echo  [OK] Spooler dezactivat - nicio imprimanta.) else (echo  [OK] Spooler disabled - no printer found.)
) else (
    if "%LANG%"=="RO" (echo  [OK] Spooler PASTRAT - imprimanta detectata.) else (echo  [OK] Spooler KEPT - printer detected.)
)
if "%LANG%"=="RO" (echo  [OK] Servicii Xbox/CDPSvc dezactivate. WbioSrvc + DPS pastrate active.) else (echo  [OK] Xbox/CDPSvc disabled. WbioSrvc + DPS kept active.)
echo [%time%] [%PROFILE%] Step 16 - Extra Services >> "%LOGFILE%"
:AFTER16

:: ============================================================
:: 17/27 - GPU SOFTWARE UPDATE
:: ============================================================
if "%RUN_17%"=="0" goto :AFTER17
call :PROGRESS 17 "%S_17%"
winget --version >nul 2>&1
if %errorLevel% neq 0 (
    if "%LANG%"=="RO" (echo  [INFO] winget indisponibil. NVIDIA: nvidia.com/Download  AMD: amd.com/en/support) else (echo  [INFO] winget unavailable. NVIDIA: nvidia.com/Download  AMD: amd.com/en/support)
    goto :AFTER17
)
if "!GPU_VENDOR!"=="NVIDIA" (
    winget upgrade --id=NVIDIA.GeForceExperience --silent --accept-package-agreements --accept-source-agreements >nul 2>&1
    if "%LANG%"=="RO" (
        echo  [OK] NVIDIA GeForce Experience actualizat.
        echo       Drivere: deschide GFE ^> Drivers tab.
    ) else (
        echo  [OK] NVIDIA GeForce Experience updated.
        echo       Drivers: open GFE ^> Drivers tab.
    )
    if "!GPU_GEN!"=="LEGACY" (
        if "%LANG%"=="RO" (echo       Placi vechi fara suport GFE: https://www.nvidia.com/Download/index.aspx) else (echo       Old unsupported cards: https://www.nvidia.com/Download/index.aspx)
    )
)
if "!GPU_VENDOR!"=="AMD" (
    winget upgrade --id=AMD.RadeonSoftware --silent --accept-package-agreements --accept-source-agreements >nul 2>&1
    if "%LANG%"=="RO" (
        echo  [OK] AMD Radeon Software actualizat.
        echo       Drivere: deschide Radeon Software ^> Drivers tab.
    ) else (
        echo  [OK] AMD Radeon Software updated.
        echo       Drivers: open Radeon Software ^> Drivers tab.
    )
    if "!GPU_GEN!"=="LEGACY" (
        if "%LANG%"=="RO" (echo       Placi foarte vechi: https://www.amd.com/en/support) else (echo       Very old cards: https://www.amd.com/en/support)
    )
)
if "!GPU_VENDOR!"=="INTEL" (
    winget upgrade --id=Intel.IntelDriverAndSupportAssistant --silent --accept-package-agreements --accept-source-agreements >nul 2>&1
    if "%LANG%"=="RO" (echo  [OK] Intel Driver Assistant actualizat.) else (echo  [OK] Intel Driver Assistant updated.)
)
echo [%time%] [%PROFILE%] Step 17 - GPU Software >> "%LOGFILE%"
:AFTER17

:: ============================================================
:: 18/27 - BACKGROUND APPS + CORTANA
:: ============================================================
if "%RUN_18%"=="0" goto :AFTER18
call :PROGRESS 18 "%S_18%"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsRunInBackground /t REG_DWORD /d 2 /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Background apps, Cortana, OneDrive startup dezactivate.) else (echo  [OK] Background apps, Cortana, OneDrive startup disabled.)
echo [%time%] [%PROFILE%] Step 18 - Background Apps >> "%LOGFILE%"
:AFTER18

:: ============================================================
:: 19/27 - POWER THROTTLING + IRQ
:: ============================================================
if "%RUN_19%"=="0" goto :AFTER19
call :PROGRESS 19 "%S_19%"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >nul 2>&1
if !IS_WIN11!==1 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v EnergyEstimationEnabled /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v EventProcessorEnabled /t REG_DWORD /d 0 /f >nul 2>&1
)
if "%LANG%"=="RO" (echo  [OK] Power Throttling dezactivat, prioritate IRQ setata.) else (echo  [OK] Power Throttling OFF, IRQ priority set.)
echo [%time%] [%PROFILE%] Step 19 - Power Throttling >> "%LOGFILE%"
:AFTER19

:: ============================================================
:: 20/27 - PAGE FILE
:: ============================================================
if "%RUN_20%"=="0" goto :AFTER20
call :PROGRESS 20 "%S_20%"
wmic computersystem set AutomaticManagedPagefile=True >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Page file setat pe auto-managed.) else (echo  [OK] Page file set to auto-managed.)
echo [%time%] [%PROFILE%] Step 20 - Page File >> "%LOGFILE%"
:AFTER20

:: ============================================================
:: 21/27 - GPU TWEAKS
:: NVIDIA: dezactivam DOAR NvTelemetryContainer, NU NvContainerLocalSystem
:: NvContainerLocalSystem = necesar pentru GFE, ShadowPlay, NVIDIA Broadcast
:: AMD Crash Defender exista doar in Adrenalin 2020+ - pe drivere vechi poate lipsi
:: ============================================================
if "%RUN_21%"=="0" goto :AFTER21
call :PROGRESS 21 "%S_21%"
if "!GPU_VENDOR!"=="NVIDIA" (
    reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v OptInOrOutPreference /t REG_DWORD /d 0 /f >nul 2>&1
    sc stop NvTelemetryContainer >nul 2>&1 & sc config NvTelemetryContainer start= disabled >nul 2>&1
    if "!GPU_GEN!"=="MODERN" (
        if "%LANG%"=="RO" (echo  [OK] NVIDIA RTX: telemetrie dezactivata. GFE si ShadowPlay raman functionale.) else (echo  [OK] NVIDIA RTX: telemetry disabled. GFE and ShadowPlay remain functional.)
    ) else (
        if "%LANG%"=="RO" (echo  [OK] NVIDIA GTX: telemetrie dezactivata ^(NvTelemetryContainer poate lipsi pe drivere vechi - normal^).) else (echo  [OK] NVIDIA GTX: telemetry disabled ^(NvTelemetryContainer may not exist on old drivers - normal^).)
    )
)
if "!GPU_VENDOR!"=="AMD" (
    reg add "HKLM\SOFTWARE\AMD\CN" /v "TelemetryState" /t REG_DWORD /d 0 /f >nul 2>&1
    sc stop "AMD Crash Defender Service" >nul 2>&1 & sc config "AMD Crash Defender Service" start= disabled >nul 2>&1
    if "!GPU_GEN!"=="MODERN" (
        if "%LANG%"=="RO" (echo  [OK] AMD RDNA: telemetrie dezactivata, Crash Defender dezactivat.) else (echo  [OK] AMD RDNA: telemetry disabled, Crash Defender disabled.)
    ) else (
        if "%LANG%"=="RO" (echo  [OK] AMD legacy: telemetrie dezactivata ^(Crash Defender poate lipsi pe drivere vechi - normal^).) else (echo  [OK] AMD legacy: telemetry disabled ^(Crash Defender may not exist on old drivers - normal^).)
    )
)
reg add "HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v DirectXUserGlobalSettings /t REG_SZ /d "SwapEffectUpgradeEnable=1;" /f >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] DirectX SwapEffect upgrade activat.) else (echo  [OK] DirectX SwapEffect upgrade enabled.)
echo [%time%] [%PROFILE%] Step 21 - GPU Tweaks >> "%LOGFILE%"
:AFTER21

:: ============================================================
:: 22/27 - TELEMETRIE WINDOWS
:: ============================================================
if "%RUN_22%"=="0" goto :AFTER22
call :PROGRESS 22 "%S_22%"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Toata telemetria Windows dezactivata.) else (echo  [OK] All Windows telemetry disabled.)
echo [%time%] [%PROFILE%] Step 22 - Telemetry >> "%LOGFILE%"
:AFTER22

:: ============================================================
:: 23/27 - PRIORITATE JOCURI (IFEO)
:: ============================================================
if "%RUN_23%"=="0" goto :AFTER23
call :PROGRESS 23 "%S_23%"
set GAME_PRIO=5
if !CPU_CORES! LEQ 4 set GAME_PRIO=4
for %%g in (csgo.exe cs2.exe valorant.exe VALORANT-Win64-Shipping.exe League_of_Legends.exe LeagueClient.exe javaw.exe Minecraft.exe Warzone.exe r5apex.exe RainbowSix.exe FortniteClient-Win64-Shipping.exe dota2.exe overwatch.exe overwatch2.exe) do (
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%g\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d !GAME_PRIO! /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%g\PerfOptions" /v IoPriority /t REG_DWORD /d 3 /f >nul 2>&1
)
if "%LANG%"=="RO" (echo  [OK] Prioritate HIGH setata pentru toate jocurile competitive.) else (echo  [OK] HIGH priority set for all competitive games.)
echo [%time%] [%PROFILE%] Step 23 - Game Priority >> "%LOGFILE%"
:AFTER23

:: ============================================================
:: 24/27 - SHADER CACHE
:: Inclus AMD legacy (DXCache uppercase, AppData paths) pentru placi vechi
:: ============================================================
if "%RUN_24%"=="0" goto :AFTER24
call :PROGRESS 24 "%S_24%"
del /q /f /s "%LOCALAPPDATA%\NVIDIA\DXCache\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\NVIDIA\GLCache\*" >nul 2>&1
del /q /f /s "%APPDATA%\NVIDIA\ComputeCache\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\AMD\DxCache\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\AMD\DXCache\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\AMD\GLCache\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\AMD\VkCache\*" >nul 2>&1
del /q /f /s "%APPDATA%\AMD\DxCache\*" >nul 2>&1
del /q /f /s "%APPDATA%\AMD\DXCache\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\D3DSCache\*" >nul 2>&1
for /d %%i in ("C:\Program Files (x86)\Steam\steamapps\shadercache\*") do del /q /f /s "%%i\*" >nul 2>&1
for /d %%i in ("D:\Steam\steamapps\shadercache\*") do del /q /f /s "%%i\*" >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] Shader cache curatat ^(NVIDIA+AMD modern+AMD legacy+Steam^). Primul launch va recompila - normal.) else (echo  [OK] Shader cache cleared ^(NVIDIA+AMD modern+AMD legacy+Steam^). First launch recompiles - normal.)
echo [%time%] [%PROFILE%] Step 24 - Shader Cache >> "%LOGFILE%"
:AFTER24

:: ============================================================
:: 25/27 - CONFIG JOCURI
:: CS2: doar cvars valide in Source 2 (nu r_dynamic/mat_queue_mode din CS:GO)
:: CS:GO/CS2: backup autoexec inainte de suprascriere
:: Minecraft: JVM args scrise intr-un fisier txt, nu aplicate direct
:: ============================================================
if "%RUN_25%"=="0" goto :AFTER25
call :PROGRESS 25 "%S_25%"
set CSGO_CFG=
for %%p in ("C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\cfg" "D:\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\cfg") do (
    if exist %%p set CSGO_CFG=%%~p
)
if defined CSGO_CFG (
    if exist "%CSGO_CFG%\autoexec.cfg" copy /y "%CSGO_CFG%\autoexec.cfg" "%CSGO_CFG%\autoexec_backup_rg.cfg" >nul 2>&1
    > "%CSGO_CFG%\autoexec.cfg" echo // RunGuard GameBoost
    >> "%CSGO_CFG%\autoexec.cfg" echo fps_max 999
    >> "%CSGO_CFG%\autoexec.cfg" echo fps_max_menu 999
    >> "%CSGO_CFG%\autoexec.cfg" echo cl_forcepreload 1
    >> "%CSGO_CFG%\autoexec.cfg" echo r_dynamic 0
    >> "%CSGO_CFG%\autoexec.cfg" echo mat_queue_mode 2
    >> "%CSGO_CFG%\autoexec.cfg" echo mat_powersavingsmode 0
    >> "%CSGO_CFG%\autoexec.cfg" echo r_drawtracers_firstperson 0
    >> "%CSGO_CFG%\autoexec.cfg" echo violence_hblood 0
    >> "%CSGO_CFG%\autoexec.cfg" echo cl_disable_ragdolls 1
    if "%LANG%"=="RO" (echo  [OK] CS:GO autoexec.cfg aplicat. Backup: autoexec_backup_rg.cfg) else (echo  [OK] CS:GO autoexec.cfg applied. Backup: autoexec_backup_rg.cfg)
) else (
    if "%LANG%"=="RO" (echo  [INFO] CS:GO negasit.) else (echo  [INFO] CS:GO not found.)
)
set CS2_CFG=
for %%p in ("C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike 2\game\csgo\cfg" "D:\Steam\steamapps\common\Counter-Strike 2\game\csgo\cfg") do (
    if exist %%p set CS2_CFG=%%~p
)
if defined CS2_CFG (
    if exist "%CS2_CFG%\autoexec.cfg" copy /y "%CS2_CFG%\autoexec.cfg" "%CS2_CFG%\autoexec_backup_rg.cfg" >nul 2>&1
    > "%CS2_CFG%\autoexec.cfg" echo // RunGuard GameBoost - CS2 valid cvars only
    >> "%CS2_CFG%\autoexec.cfg" echo fps_max 999
    >> "%CS2_CFG%\autoexec.cfg" echo fps_max_menu 60
    if "%LANG%"=="RO" (echo  [OK] CS2 autoexec.cfg aplicat. Backup: autoexec_backup_rg.cfg) else (echo  [OK] CS2 autoexec.cfg applied. Backup: autoexec_backup_rg.cfg)
) else (
    if "%LANG%"=="RO" (echo  [INFO] CS2 negasit.) else (echo  [INFO] CS2 not found.)
)
if exist "%APPDATA%\.minecraft" (
    set MC_JVM=%APPDATA%\.minecraft\RunGuard_JVM_Args.txt
    > "!MC_JVM!" echo # RunGuard GameBoost - JVM Args pentru Minecraft
    >> "!MC_JVM!" echo # Copiaza in launcher JVM Arguments:
    >> "!MC_JVM!" echo.
    >> "!MC_JVM!" echo -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200
    >> "!MC_JVM!" echo -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC
    >> "!MC_JVM!" echo -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40
    >> "!MC_JVM!" echo -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5
    >> "!MC_JVM!" echo -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15
    >> "!MC_JVM!" echo -XX:G1MixedGCLiveThresholdPercent=90 -XX:SurvivorRatio=32
    >> "!MC_JVM!" echo -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1
    if "%LANG%"=="RO" (echo  [OK] Minecraft: JVM args salvate in RunGuard_JVM_Args.txt - copiaza in launcher.) else (echo  [OK] Minecraft: JVM args saved to RunGuard_JVM_Args.txt - paste into launcher.)
) else (
    if "%LANG%"=="RO" (echo  [INFO] Minecraft negasit.) else (echo  [INFO] Minecraft not found.)
)
echo [%time%] [%PROFILE%] Step 25 - Game Configs >> "%LOGFILE%"
:AFTER25

:: ============================================================
:: 26/27 - RAM CLEANER AUTOMAT
:: rundll32 ProcessIdleTasks = elibereaza procesele idle din memorie
:: ============================================================
if "%RUN_26%"=="0" goto :AFTER26
call :PROGRESS 26 "%S_26%"
set RC_BAT=%~dp0RunGuard_RAMClean.bat
set RC_VBS=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\RunGuard_RAMClean.vbs
> "%RC_BAT%" echo @echo off
>> "%RC_BAT%" echo color 0a
>> "%RC_BAT%" echo title RunGuard - Startup Cleanup
>> "%RC_BAT%" echo echo.
>> "%RC_BAT%" echo echo  [RunGuard] Startup cleanup...
>> "%RC_BAT%" echo echo.
>> "%RC_BAT%" echo echo  [1/4] Flush DNS...
>> "%RC_BAT%" echo ipconfig /flushdns ^>nul 2^>^&1
>> "%RC_BAT%" echo echo  [OK] DNS flushed.
>> "%RC_BAT%" echo echo  [2/4] Temp files...
>> "%RC_BAT%" echo del /q /f /s "%%temp%%\*" ^>nul 2^>^&1
>> "%RC_BAT%" echo del /q /f /s "C:\Windows\Temp\*" ^>nul 2^>^&1
>> "%RC_BAT%" echo echo  [OK] Temp files deleted.
>> "%RC_BAT%" echo echo  [3/4] Idle tasks...
>> "%RC_BAT%" echo rundll32.exe advapi32.dll,ProcessIdleTasks ^>nul 2^>^&1
>> "%RC_BAT%" echo echo  [OK] Idle tasks processed.
>> "%RC_BAT%" echo echo  [4/4] Recycle Bin...
>> "%RC_BAT%" echo powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" ^>nul 2^>^&1
>> "%RC_BAT%" echo echo  [OK] Recycle Bin cleared.
>> "%RC_BAT%" echo echo.
>> "%RC_BAT%" echo echo  [RunGuard] Cleanup done^^! Fereastra se inchide in 3 secunde...
>> "%RC_BAT%" echo timeout /t 3 /nobreak ^>nul
> "%RC_VBS%" echo Set WshShell = CreateObject^("WScript.Shell"^)
>> "%RC_VBS%" echo WshShell.Run chr^(34^) ^& "%RC_BAT%" ^& chr^(34^), 1
>> "%RC_VBS%" echo Set WshShell = Nothing
schtasks /create /tn "RunGuard_RAMClean" /tr "wscript.exe //nologo \"%RC_VBS%\"" /sc onlogon /rl highest /f >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] RAM Cleaner instalat ca task la fiecare pornire.) else (echo  [OK] RAM Cleaner installed as task on every startup.)
echo [%time%] [%PROFILE%] Step 26 - RAM Cleaner >> "%LOGFILE%"
:AFTER26

:: ============================================================
:: 27/27 - CPU PRIORITY
:: ============================================================
if "%RUN_27%"=="0" goto :AFTER27
call :PROGRESS 27 "%S_27%"
for %%g in (csgo.exe cs2.exe valorant.exe VALORANT-Win64-Shipping.exe League_of_Legends.exe LeagueClient.exe Warzone.exe r5apex.exe RainbowSix.exe FortniteClient-Win64-Shipping.exe dota2.exe overwatch.exe overwatch2.exe) do (
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%g\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 5 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%g\PerfOptions" /v IoPriority /t REG_DWORD /d 3 /f >nul 2>&1
)
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 100 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMAXCORES 100 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1
if "%LANG%"=="RO" (echo  [OK] CPU priority HIGH + toate !CPU_THREADS! threaduri active.) else (echo  [OK] CPU HIGH priority + all !CPU_THREADS! threads active.)
echo [%time%] [%PROFILE%] Step 27 - CPU Priority >> "%LOGFILE%"
:AFTER27

:: ============================================================
:: MARK AS APPLIED
:: ============================================================
reg add "HKLM\SOFTWARE\RunGuard\GameBoost" /v Applied /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\RunGuard\GameBoost" /v Date /t REG_SZ /d "%date%" /f >nul 2>&1
reg add "HKLM\SOFTWARE\RunGuard\GameBoost" /v Profile /t REG_SZ /d "%PROFILE%" /f >nul 2>&1
echo [%time%] [%PROFILE%] === OPTIMIZATION COMPLETE === >> "%LOGFILE%"

:: ============================================================
:: FINAL SCREEN
:: ============================================================
cls
call :HEADER
echo.
echo  ============================================================
if "%LANG%"=="RO" (
    echo   !S_DONE!
    if "%PROFILE%"=="SAFE"     echo   Optimizarile de baza au fost aplicate ^(profil SAFE^).
    if "%PROFILE%"=="BALANCED" echo   Optimizarile recomandate au fost aplicate ^(profil BALANCED^).
    if "%PROFILE%"=="EXTREME"  echo   Toate cele 27 de optimizari au fost aplicate ^(profil EXTREME^).
) else (
    echo   !S_DONE!
    if "%PROFILE%"=="SAFE"     echo   Basic optimizations applied ^(SAFE profile^).
    if "%PROFILE%"=="BALANCED" echo   Recommended optimizations applied ^(BALANCED profile^).
    if "%PROFILE%"=="EXTREME"  echo   All 27 optimizations applied ^(EXTREME profile^).
)
echo  ============================================================
echo.
echo   GPU  : !GPU_NAME! -- !GPU_VENDOR! -- !GPU_GEN!
echo   CPU  : !CPU_NAME! -- !CPU_CORES! cores
echo   Build: !WIN_BUILD!
echo   Log  : %LOGFILE%
if "%LANG%"=="RO" (echo   Restore: RunGuard_Restore.bat) else (echo   Restore: RunGuard_Restore.bat)
echo  ============================================================
echo.
call :HEADER
echo.
echo  ============================================================
if "%LANG%"=="RO" (
    echo   ^^!^^! REPORNESTE PC-UL pentru a aplica toate setarile ^^!^^!
    echo.
    echo   ENTER = inapoi la meniu   /   N = Iesire
) else (
    echo   ^^!^^! RESTART YOUR PC to apply all settings ^^!^^!
    echo.
    echo   ENTER = back to menu   /   N = Exit
)
echo  ============================================================
echo.
if "%LANG%"=="RO" (echo   [1] Inapoi la meniu  [2] Iesire) else (echo   [1] Back to menu  [2] Exit)
echo.
choice /C 12 /N /M "  Alegere / Choice [1/2]: "
if errorlevel 2 goto :EXIT_SCRIPT
set CAME_FROM_MENU=1
goto :PROFILE_LOOP

:: ============================================================
:: EXIT CURAT - folosit de toate iesirile din script
:: ============================================================
:EXIT_SCRIPT
echo.
if "%LANG%"=="RO" (echo  La revedere^^! Multumim ca ai ales RunGuard^^!) else (echo  Goodbye^^! Thank you for using RunGuard^^!)
echo.
timeout /t 2 /nobreak >nul
exit /b 0

:: ============================================================
:: SUBROUTINE: PROGRESS BAR
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
