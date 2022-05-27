


@rem ------------------------------------------------
@rem          Minecraft Server Starter
@rem
@rem
@rem            version = 3.0-alpha
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


echo %server_type%
goto :__main__

@rem fun...

:__main__
endlocal
@rem set the local variables..

echo.
@rem display logo...

echo [30m"[37m ___  ___ _                                   __  _                                               _                 _               
echo [30m"[37m |  \/  |(_)                                 / _|| |                                             | |               | |
echo [30m"[37m | .  . | _  _ __    ___   ___  _ __   __ _ | |_ | |_   ___   ___  _ __ __   __  ___  _ __   ___ | |_   __ _  _ __ | |_   ___  _ __ 
echo [30m"[37m | |\/| || || '_ \  / _ \ / __|| '__| / _\`||  _|| __| / __| / _ \| '__|\ \ / / / _ \| '__| / __|| __| / _\`|| '__|| __| / _ \| '__|
echo [30m"[37m | |  | || || | | ||  __/| (__ | |   | (_| || |  | |_  \__ \|  __/| |    \ V / |  __/| |    \__ \| |_ | (_| || |   | |_ |  __/| |   
echo [30m"[37m \_|  |_/|_||_| |_| \___| \___||_|    \__,_||_|   \__| |___/ \___||_|     \_/   \___||_|    |___/ \__| \__,_||_|    \__| \___||_|
echo. 

setlocal enabledelayedexpansion
setlocal enableextensions
echo [90m[[96m*[90m] [37m Setting [96menableextensions[37m
echo [90m[[96m*[90m] [37m Setting [96menabledelayedexpansion[37m
echo.
echo [90m[[32m+[90m] [37m Adding REG_DWORD Value
reg add HKEY_CURRENT_USER\Console /v VirtualTerminalLevel /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add HKEY_CURRENT_USER\Console /v VirtualTerminalLevel /t REG_DWORD /d 0x00000001 /f >nul 2>&1
echo.
echo [90m[[96m*[90m] [37m Checking REG_DWORD Value
for /f "tokens=3" %%A in ('reg query "HKCU\Console" /v VirtualTerminalLevel 2^>nul ^| find "VirtualTerminalLevel"') do set "output=%%A"
if "%output%"=="0x1" (
  echo [90m[[32m+[90m] [37m Success.. 
) else (
  echo [90m[[91m?[90m] [37m Failure..   
)
echo.


if "%~1"=="--name" (
    if "%~2"=="" (
        echo [90m[[31m?[90m] [37mInserted empty string [91m"" [37m
        echo.    
    ) else (
        title Minecraft server [%~2]
        if "%~3"=="--flags" (
            if "%~4"=="basics" (
                echo [90m[[96m*[90m] [37m Your server will spin up with [91mbasics flags... [37m
                echo [90m[[32m+[90m] [37m java [91m-Xms512M -Xmx1000M [37m-jar [93mserver.jar[37m
                echo [90m[[96m*[90m] [37m Executing...
                echo.
                set "server_type=basics"
                goto __execute__
            ) else if "%~4"=="improved" (
                echo [90m[[96m*[90m] [37m Your server will spin up with [91m Improved flags... [37m 
                echo [90m[[96m*[90m] [93m -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 
                echo [90m[[96m*[90m] [93m -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 
                echo [90m[[96m*[90m] [93m -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem
                echo [90m[[96m*[90m] [93m -XX:MaxTenuringThreshold=1 -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20
                echo [90m[[96m*[90m] [93m -XX:InitiatingHeapOccupancyPercent=15 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true] [37m 
                echo [90m[[32m+[90m] [37m java [91m-Xms4000M -Xmx4000M [37m-jar [93mserver.jar[37m
                echo.
                set "server_type=improved"
                goto __execute__
            ) else if "%~4"=="advanced" (
                echo [90m[[96m*[90m] [37m Your server will spin up with [91mAdcenced flags... [37m 
                set "server_type=Advanced"
                echo.
                goto __flags+__                
            ) else if "%~4"=="custom" (
                echo [90m[[96m*[90m] [37m Your server will spin up with [91mCustom flags... [37m 
            ) else (
                echo [90m[[96m*[90m] [37m Your server will spin up with [91mbasics flags... [37m
                echo [90m[[32m+[90m] [37m java [91m-Xms512M -Xmx1000M [37m-jar [93mserver.jar[37m
                echo [90m[[96m*[90m] [37m Executing...
                echo.
                set "server_type=basics"
                @rem goto __execute__
            )
        )
    )
)
echo !server_type!
goto :eof

:__flags+__
echo !server_type!