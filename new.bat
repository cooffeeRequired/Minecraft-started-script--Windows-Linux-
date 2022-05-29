


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


@rem ------------Variables ------------------
set properties=server.properties
set tmp_ip=%temp%\Uu2zy_result.tmp
set tmp_port=%temp%\Uu2zy_result2.tmp

findstr /I "server-ip=" %properties% > %tmp_ip%
findstr /I "server-port=" %properties% > %tmp_port%

set /p "ip_unformatted=" < %tmp_ip% 
set /p "port_unformatted= "< %tmp_port%
if "%ip_unformatted%"=="server-ip=" set "ip_unformatted=server-ip=0.0.0.0"
set ip=%ip_unformatted:~10,25%
set port=%port_unformatted:~12,25%


@rem ----------- server flags -------------
set "akair=-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true"

set "flags_basic=java -Xms512M -Xmx1000M -jar server.jar nogui"
set "flags_akair=java -Xms4G -Xmx4G %akair% -jar server.jar nogui"
set "flags_akair_2=java -Xms8G -Xmx8G %akair% --add-modules=jdk.incubator.vector -jar server.jar nogui"
set "flags_akair_custom_0=java -Xms%7 -Xmx%9 %akair% -jar server.jar nogui"
set "flags_akair_custom_1=java -Xms%7 -Xmx%9 %akair% --add-modules=jdk.incubator.vector -jar server.jar nogui"



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
                goto :__update__
            ) else if "%~4"=="improved" (
                echo %nI% Your server will spin up with %nRed% Improved flags... %nReset% 
                echo %nI% %nYellow% -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 
                echo %nI% %nYellow% -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 
                echo %nI% %nYellow% -XX:MaxTenuringThreshold=1 -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20
                echo %nI% %nYellow% -XX:InitiatingHeapOccupancyPercent=15 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true %nReset% 
                echo %nS% java %nRed%-Xms4000M -Xmx4000M %nReset% -jar %nYellow%server.jar%nReset%
                echo.
                set "server_type=improved"
                goto :__update__
            ) else if "%~4"=="advanced" (
                echo %nI% Your server will spin up with %nRed%Adcenced flags... %nReset% 
                echo %nS% java %nRed%-Xms8000M -Xmx8000M %nReset% --add-modules=jdk.incubator.vector -jar %nYellow%server.jar%nReset%
                set "server_type=Advanced"
                echo.
                goto :__update__                
            ) else if "%~4"=="custom" (
                echo %nI% Your server will spin up with %nRed%Custom flags... %nReset%
                set "server_type=Custom"
                echo %nI% Your server will spin up with %nRed%Full customs flags -- Need specify Ram params... %nReset% 
                echo %nS% java %nRed%--min "yourInput" --max "yourInput" %nReset% --winc ^| wionc -jar %nYellow%server.jar%nReset%
                echo.
                goto :__update__
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
        curl -ks https://api.purpurmc.org/v2/purpur/!latest_version!/!build_string!/download -o server.jar
        set "version=!latest_version!"
        set "type=purpur"
        call :__execute__ 
    ) else if "%~6"=="latest" (
        for /f "delims=" %%A in ('curl -ks https://api.purpurmc.org/v2/purpur/!latest_version! ^| jq-win64.exe .builds.latest') do set "build_string=%%~A"
        curl -ks https://api.purpurmc.org/v2/purpur/!latest_version!/!build_string!/download -o server.jar
        set "version=!latest_version!"
        set "type=purpur"
        call :__execute__
    ) else if not "!ver_string:%~6=!"=="!ver_string!" (
        for /f "delims=" %%A in ('curl -ks https://api.purpurmc.org/v2/purpur/%~6 ^| jq-win64.exe .builds.latest') do set "build_string=%%~A"
        curl -ks https://api.purpurmc.org/v2/purpur/%~6/!build_string!/download -o server.jar
        set "version=%~6"
        set "type=purpur"
        call :__execute__
    ) else (
        echo %nW%%nReset% This version %nYellow%%6%nReset% is not valid!
        exit /b
    )
) else if "%~5"=="--paper" (
    for /f "delims=" %%A in ('curl -ks https://api.papermc.io/v2/projects/paper/') do set "ver_string=%%~A"
    for %%A in (!ver_string!) do set "paper_version=%%~A"
    set "latest_version=!paper_version:~0,-3!"
    if "%~6"=="" (
        for /f "delims=" %%A in ('curl -ks https://api.papermc.io/v2/projects/paper/versions/!latest_version! ^| jq-win64.exe ".builds | last"') do set "build_string=%%~A"
        curl -ks https://api.papermc.io/v2/projects/paper/versions/!latest_version!/builds/!build_string!/downloads/paper-!latest_version!-!build_string!.jar -o server.jar
        set "version=!latest_version!"
        set "type=paper"
        call :__execute__
    ) else if "%~6"=="latest" (
        for /f "delims=" %%A in ('curl -ks https://api.papermc.io/v2/projects/paper/versions/!latest_version! ^| jq-win64.exe ".builds | last"') do set "build_string=%%~A"
        curl -ks https://api.papermc.io/v2/projects/paper/versions/!latest_version!/builds/!build_string!/downloads/paper-!latest_version!-!build_string!.jar -o server.jar
        set "version=!latest_version!"
        set "type=paper"
        call :__execute_
    ) else if not "!ver_string:%~6=!"=="!ver_string!" (
        for /f "delims=" %%A in ('curl -ks https://api.papermc.io/v2/projects/paper/versions/%~6^| jq-win64.exe ".builds | last"') do set "build_string=%%~A"
        curl -ks https://api.papermc.io/v2/projects/paper/versions/%~6/builds/!build_string!/downloads/paper-%~6-!build_string!.jar -o server.jar
        set "version=%~6"
        set "type=paper"
        call :__execute__
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
        curl -ks https://api.papermc.io/v2/projects/velocity/versions/!latest_version!/builds/!build_string!/downloads/velocity-!latest_version!-!build_string!.jar -o server.jar
        set "version=!latest_version!"
        set "type=velocity"
        call :__execute__
    ) else if "%~6"=="latest" (
        for /f "delims=" %%A in ('curl -ks https://api.papermc.io/v2/projects/velocity/versions/!latest_version!/builds ^| jq-win64.exe ".builds | last | .build"') do set "build_string=%%~A"
        curl -ks https://api.papermc.io/v2/projects/velocity/versions/!latest_version!/builds/!build_string!/downloads/velocity-!latest_version!-!build_string!.jar -o server.jar
        set "version=!latest_version!"
        set "type=velocity"
        call :__execute__
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
        curl -ks https://api.papermc.io/v2/projects/waterfall/versions/!latest_version!/builds/!build_string!/downloads/waterfall-!latest_version!-!build_string!.jar -o server.jar
        set "version=!latest_version!"
        set "type=waterfall"
        call :__execute__
    ) else if "%~6"=="latest" (
        for /f "delims=" %%A in ('curl -ks https://api.papermc.io/v2/projects/waterfall/versions/!latest_version!/builds ^| jq-win64.exe ".builds | last | .build"') do set "build_string=%%~A"
        curl -ks https://api.papermc.io/v2/projects/waterfall/versions/!latest_version!/builds/!build_string!/downloads/waterfall-!latest_version!-!build_string!.jar -o server.jar
        set "version=!latest_version!"
        set "type=waterfall"
        call :__execute_
    ) else if not "!ver_string:%~6=!"=="!ver_string!" (
        for /f "delims=" %%A in ('curl -ks https://api.papermc.io/v2/projects/waterfall/versions/%~6/builds^| jq-win64.exe ".builds | last | .build"') do set "build_string=%%~A"
        curl -ks https://api.papermc.io/v2/projects/waterfall/versions/%~6/builds/!build_string!/downloads/waterfall-%~6-!build_string!.jar -o server.jar
        set "version=%~6"
        set "type=waterfall"
        call :__execute__
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

goto :eof                 

:__after__
set "isRestarting=false"
set "isCrashed=false"

>nul find "RestartCommand" logs/latest.log && set "isRestarting=true"
>nul find "./start.sh' does not exist! Stopping server." logs/latest.log && set "isRestarting=true"
>nul find "UncaughtExceptionHandler" logs/latest.log && set "isCrashed=true"
>nul find "Exception:" logs/latest.log && set "isCrashed=true"
>nul find "java.lang.NullPointerException" logs/latest.log && set "isCrashed=true"
>nul find "java.lang.OutOfMemoryError" logs/latest.log && set "isCrashed=true"

if "%isRestarting%"=="true" (
    cls
    echo.
    echo %nS% Restarting your server %nReset%
    echo %nS% Server Address %nBlueL%%ip%:%port% %nReset%
    echo %nS% Public Server Address %nBlueL%%externalIP%:%port% %nReset%
    timeout >nul 2>&1
    call :__execute__
) else if "%isCrashed%"=="true" (
    cls
    echo.
    echo %nW% Your server crashed... Trying a restart %nReset%
    timeout >nul 2>&1
    call :__execute__    
) else (
    cls
    echo.
    echo %nW% You stopped server %nReset%
    echo.   
)

goto :eof




:__execute__
del "logs\latest.log" >nul 2>&1
echo eula=true>eula.txt

if "%server_type%"=="basics" (
    echo %nI% Type %nBlueL%%type% %nReset%Version %nYellow%%version%%nReset% Build %nGreenD%%build_string% %nReset%
    echo.
    echo.
    %flags_basic%
    call :__after__
) else if "%server_type%"=="improved" (
    echo %nI% Type %nBlueL%%type% %nReset%Version %nYellow%%version%%nReset% Build %nGreenD%%build_string% %nReset%
    echo.
    echo.
    %flags_akair%
    call :__after__
) else if "%server_type%"=="Advanced" (
    echo %nI% Type %nBlueL%%type% %nReset%Version %nYellow%%version%%nReset% Build %nGreenD%%build_string% %nReset%
    echo.
    echo.
    %flags_akair_2%
    call :__after__
) else if "%server_type%"=="Custom" (
    echo %nI% Type %nBlueL%%type% %nReset%Version %nYellow%%version%%nReset% Build %nGreenD%%build_string% %nReset%
    echo.
    if "!6"=="" (
        echo %nW% You need to specify version %nBlueL%latest%nReset% ^| %nGreenD%Version %nReset%
        echo.
        exit /b 1
    ) else if "%~6"=="latest" (
        echo %nI% You alredy using %nYellow%Latest version %nReset%
    ) else if not "%~6"=="" (
        echo %nI% You alredy using %nYellow%%~6% version %nReset%
    )
    set "Counter=1"
    for %%f in (%*) do (
    set "arg_!Counter!=%%f"
    set /A Counter+=1
    )
    if "%~8"=="" (
        echo %nW% You need to specify %nYellow%value of Minimum %nReset%Ram via %nBlueL%e.g. --min 1G %nReset%
        exit /b 1
    )
    if "!arg_10!"=="" (
        echo %nW% You need to specify %nYellow%value of Maximum %nReset%Ram via %nBlueL%e.g. --max 10G %nReset%
        exit /b 1
    )
    if "!arg_11!"=="--winc" (
        echo %nS% You selected version with %nYellow% --add-modules=jdk.incubator.vector%nReset%
        %flags_akair_custom_1%
        call :__after__
    )
    if "!arg_11!"=="--wionc" (
       echo  %nS% You selected version without %nRed% --add-modules=jdk.incubator.vector%nReset%
        %flags_akair_custom_0%
        call :__after__
    ) else (
        echo %nW% You need to specify --wmic or --wiomc etting for --add-modules=jdk.incubator.vector %nReset%
    )
) else (
    exit /b 1
)


./new --name "Test" --flags custom --purpur latest | ver | --min 1000M --max 1000 --winc
