


@rem ------------------------------------------------
@rem          Minecraft Server Starter
@rem
@rem
@rem            version = 3.0.0-alpha
@rem
@rem            author = coffeerequired
@rem            # DONT USE IT - IN PROGRESS
@rem
@rem
@rem -------------------------------------------------

@echo off


@rem mode set
MODE con:cols=161 lines=36
@rem Setting a colour output
color 00
color 07
@rem ----------------------------------

@rem ------Set External IP-------------
for /f "tokens=1* delims=: " %%A in (
  'nslookup myip.opendns.com. resolver1.opendns.com 2^>NUL^|find "Address:"'
) Do set "externalIP=%%~B"
@rem ----------------------------------


@rem ------ Variables ------------------
set properties=server.properties
set tmp_ip=%temp%\Uu2zy_result.tmp && set tmp_port=%temp%\Uu2zy_result2.tmp
set /p "ip_unformatted="<%tmp_ip% && set /p "port_unformatted="<%tmp_port%
set ip=%ip_unformatted:~10,25% && set port=%port_unformatted:~12,25%

@rem ---------- functions ----------------
findstr /I "server-ip=" %properties% > %tmp_ip% >nul 2>&1
findstr /I "server-port=" %properties% > %tmp_port% >nul 2>&1

@rem ----------- server flags -------------
set "akair=-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true"

set "flags_basic=java -Xms512M -Xmx1000M -jar server.jar nogui"
set "flags_akair=java -Xms4G -Xmx4G %akair%-jar server.jar nogui"
set "flags_akair_custom=java -Xms%7 -Xmx%9 %akair% -jar !arg_10:~2,25!.jar nogui"

goto :__main__

@rem fun...

:__main__
@rem set the local variables..

echo.

setlocal enabledelayedexpansion
setlocal enableextensions

@rem ----------Colors-------------
set "nYellow=[93m"
set "nRed=[91m"
set "nGreenD=[32m"
set "nReset=[37m"
set "nBlueL=[96m"

@rem expColors
set "nLogo=[30m"[37m"

set "nI=[90m[[96m*[90m] [37m"
set "nW=[90m[[31m^^^^^![90m] [37m"
set "nS=[90m[[32m+[90m] [37m"

@rem ------------------------------

@rem display logo...

echo %nLogo% ___  ___ _                                   __  _                                               _                 _               
echo %nLogo% |  \/  |(_)                                 / _|| |                                             | |               | |
echo %nLogo% | .  . | _  _ __    ___   ___  _ __   __ _ | |_ | |_   ___   ___  _ __ __   __  ___  _ __   ___ | |_   __ _  _ __ | |_   ___  _ __ 
echo %nLogo% | |\/| || || '_ \  / _ \ / __|| '__| / _\`||  _|| __| / __| / _ \| '__|\ \ / / / _ \| '__| / __|| __| / _\`|| '__|| __| / _ \| '__|
echo %nLogo% | |  | || || | | ||  __/| (__ | |   | (_| || |  | |_  \__ \|  __/| |    \ V / |  __/| |    \__ \| |_ | (_| || |   | |_ |  __/| |   
echo %nLogo% \_|  |_/|_||_| |_| \___| \___||_|    \__,_||_|   \__| |___/ \___||_|     \_/   \___||_|    |___/ \__| \__,_||_|    \__| \___||_|
echo. 


echo %nI% Setting %nBlueL%enableextensions%nReset%
echo %nI% Setting %nBlueL%enabledelayedexpansion%nReset%

echo.
echo %nS% Adding REG_DWORD Value
reg add HKEY_CURRENT_USER\Console /v VirtualTerminalLevel /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add HKEY_CURRENT_USER\Console /v VirtualTerminalLevel /t REG_DWORD /d 0x00000001 /f >nul 2>&1
echo %nI% Checking REG_DWORD Value
for /f "tokens=3" %%A in ('reg query "HKCU\Console" /v VirtualTerminalLevel 2^>nul ^| find "VirtualTerminalLevel"') do set "output=%%A"
if "%output%"=="0x1" (
  echo %nS% [VirtualTerminalLevel] Success.. 
) else (
  echo %nW% [VirtualTerminalLevel] Failure..
  exit /b 
)
if exist jq-win64.exe goto :jmp
echo %nS% Downloading jq-win64.exe 
echo %nI% Checking jq-win64.exe 
curl -ksL https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe -o jq-win64.exe

:jmp
if not exist jq-win64.exe echo %nW% The jq-win64.exe missing && goto :eof
echo %nS% [jq-win64.exe] Success.
echo.
echo %nI% Setting done...
timeout 2 >nul 2>&1
cls
echo.



if "%~1"=="--name" (
    if "%~2"=="" (
        echo %nW%Inserted empty string %nRed%"" %nReset%
        echo.    
    ) else (
        title Minecraft server [%~2]
        if "%~3"=="--flags" (
            if "%~4"=="basics" (
                echo %nI% Your server will spin up with %nRed%basics flags... %nReset%
                echo %nS% java %nRed%-Xms512M -Xmx1000M %nReset%-jar %nYellow%server.jar%nReset%
                echo %nS% Server will start with autoupdate on %nGreenD%up-to-date version%nReset%
                echo %nI% Executing...
                echo.
                set "server_type=basics"
                goto __execute__
            ) else if "%~4"=="improved" (
                echo %nI% Your server will spin up with %nRed% Improved flags... %nReset% 
                echo %nI% %nYellow% -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 
                echo %nI% %nYellow% -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 
                echo %nI% %nYellow% -XX:MaxTenuringThreshold=1 -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20
                echo %nI% %nYellow% -XX:InitiatingHeapOccupancyPercent=15 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true %nReset% 
                echo %nS% java %nRed%-Xms4000M -Xmx4000M %nReset%-jar %nYellow%server.jar%nReset%
                echo.
                set "server_type=improved"
                goto __execute__
            ) else if "%~4"=="advanced" (
                echo %nI% Your server will spin up with %nRed%Adcenced flags... %nReset% 
                set "server_type=Advanced"
                echo.
                goto __flags+__                
            ) else if "%~4"=="custom" (
                echo %nI% Your server will spin up with %nRed%Custom flags... %nReset% 
            ) else (
                echo.
                echo %nW% Script ended, becouse you don't select type of flags %nReset%
                echo.
                exit /b 1
            )
        )
    )
)
goto :eof

:__update__

if "%~5"=="--purpur" (
    for /f "delims=" %%A in ('curl -ks https://api.purpurmc.org/v2/purpur') do set "ver_string=%%~A"
    for %%A in (!ver_string!) do set "purpur_version=%%~A"
    set "latest_version=!purpur_version:~0,-3!"
    if "%~6"=="" (
        for /f "delims=" %%A in ('curl -ks https://api.purpurmc.org/v2/purpur/!latest_version! ^| jq-win64.exe .builds.latest') do set "build_string=%%~A"
    ) else if not "!ver_string:%~6=!"=="!ver_string!" (
        for /f "delims=" %%A in ('curl -ks https://api.purpurmc.org/v2/purpur/%~6! ^| jq-win64.exe .builds.latest') do set "build_string=%%~A"
    ) else (
        echo %nW%%nReset% This version %nYellow%%6%nReset% is not valid!
        exit /b
    )
) else if "%~5"=="--paper" (
    for /f "delims=" %%A in ('curl -ks https://api.papermc.io/v2/projects/paper/') do set "ver_string=%%~A"
    for %%A in (!ver_string!) do set "paper_version=%%~A"
    set "latest_version=!paper_version:~0,-3!"
    if "%~6"=="" (
        for /f "delims=" %%A in ('curl -ks https://api.papermc.io/v2/projects/paper/!latest_version! ^| jq-win64.exe ".builds | last"') do set "build_string=%%~A"
    ) else if not "!ver_string:%~6=!"=="!ver_string!" (
        for /f "delims=" %%A in ('curl -ks https://api.papermc.io/v2/projects/paper/versions/%~6^| jq-win64.exe ".builds | last"') do set "build_string=%%~A"
    ) else (
        echo %nW%%nReset% This version %nYellow%%6%nReset% is not valid!
        exit /b
    )
) else if "%~5"=="--velocity" (
    for /f "delims=" %%A in ('curl -ks https://api.papermc.io/v2/projects/velocity/ ^| jq-win64.exe ".versions | last"') do set "ver_string=%%~A"
    for %%A in (!ver_string!) do set "velocity_version=%%~A"
    set "latest_version=!velocity_version!"
    if "%~6"=="" (
        for /f "delims=" %%A in ('curl -ks https://api.papermc.io/v2/projects/velocity/versions/!latest_version!/builds ^| jq-win64.exe ".builds | last | .build"') do set "build_string=%%~A"
    ) else (
        echo %nW%%nReset% You cannot insert any version on %nYellow%Velocity Project %nReset%!
        exit /b
    )
) else if "%~5"=="--waterfall" (
    for /f "delims=" %%A in ('curl -ks https://api.papermc.io/v2/projects/waterfall/ ^| jq-win64.exe ".versions | last"') do set "ver_string=%%~A"
    for %%A in (!ver_string!) do set "velocity_version=%%~A"
    set "latest_version=!velocity_version!"
    if "%~6"=="" (
        for /f "delims=" %%A in ('curl -ks https://api.papermc.io/v2/projects/waterfall/versions/!latest_version!/builds ^| jq-win64.exe ".builds | last | .build"') do set "build_string=%%~A"
    ) else if not "!ver_string:%~6=!"=="!ver_string!" (
        for /f "delims=" %%A in ('curl -ks https://api.papermc.io/v2/projects/waterfall/versions/%~6/builds^| jq-win64.exe ".builds | last | .build"') do set "build_string=%%~A"
    ) else (
        echo %nW%%nReset% This version %nYellow%%6%nReset% is not valid!
        exit /b
    )
) else (
    echo.
    echo %nW% Script ended, becouse you selected non-existed type of server %nReset%
    echo.
    exit /b 1  
)



@rem echo %latest_version%

echo %
echo %build_string%
echo %server_type%

goto :eof

:__execute__
if !server_type!==basics (
    goto :__update__
)

goto :eof






:__flags+__

