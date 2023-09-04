@echo off
setlocal enabledelayedexpansion
color 0A
title compile-and-deploy-maven

echo.
echo                  _________-----_____
echo        ____------           __      ----_
echo  ___----             ___------              \
echo     ----________        ----                 \
echo                -----__    ^|             _____)
echo                     __-                /     \
echo         _______-----    ___--          \    /)\
echo   ------_______      ---____            \__/  /
echo                -----__    \ --    _          /\
echo                       --__--__     \_____/   \_/\
echo                               ---^|   /          ^|
echo                                  ^| ^|___________^|
echo                                  ^| ^| ((_(_)^| )_)
echo                                  ^|  \_((_(_)^|/(_)
echo                                   \             (
echo                                    \_____________)
echo.
echo.

REM Ejecutar mvn clean install
call mvn clean install
echo.

REM Obtener el nombre de la carpeta actual
for %%A in (.) do set "ultimaCarpeta=%%~nxA"

REM Buscar y mover el archivo .war generado en la carpeta actual
set "origen="
for /r "." %%f in (*.war) do (
    set "origen=%%f"
    
    for %%g in ("!origen!") do set "nombreWar=%%~nxg"
    echo WAR LOCALIZADO: !nombreWar!
    echo.
)

if not "!origen!"=="" (
    set "destino=C:\Oracle\Middleware\user_projects\domains\base_domain\servers\AdminServer\upload\!nombreWar!"

    if exist "!destino!" (
        echo Archivo destino existe. Reemplazando...
        del "!destino!"
    )

    move "!origen!" "!destino!"
    echo Archivo .war movido exitosamente.
) else (
    echo No se encontraron archivos .war en la carpeta actual.
)
