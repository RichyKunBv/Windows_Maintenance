@echo off
title Mantenimiento de Windows - RichyKunBv
color 0A

set "AppVersion=2.1.1"

:MENU
cls
echo ============================================
echo         MANTENIMIENTO DE WINDOWS
echo ============================================
echo.
echo    Editor: RichyKunBv
echo    Version: %AppVersion%
echo    Pagina: https://github.com/RichyKunBv
echo.
echo 1. Revision del sistema
echo 2. Limpieza basica
echo 3. Limpieza completa
echo 4. Analisis completo
echo 5. Salir
echo 6. Actualizar App
echo.
set /p opcion=Selecciona una opcion:

if "%opcion%"=="1" goto REVISION
if "%opcion%"=="2" goto LIMPIEZA_BASICA
if "%opcion%"=="3" goto LIMPIEZA_COMPLETA
if "%opcion%"=="4" goto ANALISIS_COMPLETO
if "%opcion%"=="5" goto SALIR
if "%opcion%"=="6" goto ACTUALIZAR
goto MENU

:REVISION
cls
echo [1/4] Revision del sistema: comprobando integridad...
sfc /scannow

echo Revisando imagen de Windows...
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /RestoreHealth
pause
goto MENU

:LIMPIEZA_BASICA
cls
echo [2/4] Limpieza basica: optimizando discos y checando errores...
defrag C: /O
defrag D: /O

chkdsk C: /scan
chkdsk D: /scan
pause
goto MENU

:LIMPIEZA_COMPLETA
cls
echo [3/4] Limpieza completa: temporales, red, firewall y bloatware...

echo Restableciendo DNS y red...
ipconfig /flushdns
netsh int ip reset
netsh winsock reset
netsh advfirewall reset

echo Ejecutando Liberador de espacio...
cleanmgr /sagerun:1

echo Borrando temporales...
del /s /q %temp%\*.* 2>nul
del /s /q C:\Windows\Temp\*.* 2>nul

echo Creando punto de restauracion...
reagentc /info
reagentc /enable
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Mantenimiento Completo", 100, 7

echo Verificando procesos y arranque...
tasklist | findstr /I /C:"malware" /C:"virus"
wmic startup get caption,command

echo Comprobando estado fisico del disco...
wmic diskdrive get status
pause
goto MENU

:ANALISIS_COMPLETO
cls
echo [4/4] Analisis completo: ejecutando TODO el mantenimiento...
sfc /scannow
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /RestoreHealth

defrag C: /O
defrag D: /O

chkdsk C: /scan
chkdsk D: /scan

ipconfig /flushdns
netsh int ip reset
netsh winsock reset
netsh advfirewall reset

cleanmgr /sagerun:1

del /s /q %temp%\*.* 2>nul
del /s /q C:\Windows\Temp\*.* 2>nul

reagentc /info
reagentc /enable
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Mantenimiento Total", 100, 7

tasklist | findstr /I /C:"malware" /C:"virus"
wmic startup get caption,command
wmic diskdrive get status

echo Mantenimiento completo finalizado.
pause
goto MENU

:ACTUALIZAR
cls
echo =================================================
echo      BUSCANDO ACTUALIZACIONES PARA EL SCRIPT
echo =================================================
echo.

setlocal

set "localVersion=%AppVersion%"

REM --- Variables ---
set "repoUser=RichyKunBv"
set "repoName=Windows_Maintenance"
set "repoURL=https://raw.githubusercontent.com/%repoUser%/%repoName%/main"
set "versionFileURL=%repoURL%/version.txt"
set "scriptFileURL=%repoURL%/Mantenimiento.bat"
set "tempVersionFile=%temp%\latest_version.txt"
set "tempNewScriptFile=%temp%\Mantenimiento_new.bat"

REM --- Comprobar Internet ---
echo [INFO] Comprobando conexion a internet...
ping -n 1 8.8.8.8 >nul 2>&1
if errorlevel 1 (
    echo [ERROR] No se detecto una conexion a internet.
    goto EndUpdate
)
echo [OK]   Conexion establecida.
echo.

REM --- Obtener Versiones ---
echo [INFO] Version actual instalada: %localVersion%

echo [INFO] Obteniendo ultima version desde GitHub...
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { (New-Object System.Net.WebClient).DownloadFile('%versionFileURL%', '%tempVersionFile%') } catch {}" >nul 2>&1

if not exist "%tempVersionFile%" (
    echo [ERROR] No se pudo obtener el archivo de version desde GitHub.
    goto EndUpdate
)

set /p latestVersion=<%tempVersionFile%
echo [INFO] Ultima version disponible: %latestVersion%
echo.

REM --- COMPARAR VERSIONES ---
echo [INFO] Comparando versiones...
powershell -NoProfile -ExecutionPolicy Bypass -Command "if ([Version]'%latestVersion%' -gt [Version]'%localVersion%') { exit 1 } else { exit 0 }"
if not errorlevel 1 (
    echo [OK]   Ya tienes la ultima version o una superior.
    goto EndUpdate
)

echo [!] Se encontro una nueva version mas reciente (%latestVersion%)!
set /p "doUpdate=Deseas actualizar el script ahora? (S/N): "
if /i not "%doUpdate%"=="S" (
    echo [INFO] Actualizacion omitida por el usuario.
    goto EndUpdate
)

cls
echo =================================================
echo      ACTUALIZANDO SCRIPT...
echo =================================================
echo.

REM --- Descargar el Nuevo Script ---
echo [+] Descargando script [%latestVersion%]...
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { (New-Object System.Net.WebClient).DownloadFile('%scriptFileURL%', '%tempNewScriptFile%') } catch {}" >nul 2>&1

if not exist "%tempNewScriptFile%" (
    echo [ERROR] La descarga del script actualizado ha fallado.
    goto EndUpdate
)
echo [OK]   Descarga completada.
echo.
echo [INFO] La aplicacion se reiniciara para finalizar la actualizacion...
timeout /t 3 /nobreak >nul

REM --- Script Ayudante ---
(
    echo @echo off
    echo title Actualizando...
    echo echo Finalizando, por favor espera...
    echo timeout /t 1 /nobreak ^> nul
    rem Reemplaza el archivo viejo con el nuevo
    echo copy /Y "%tempNewScriptFile%" "%~f0" ^> nul
    rem Limpia los archivos temporales
    echo del "%tempNewScriptFile%" ^> nul
    echo del "%tempVersionFile%" ^> nul
    rem Vuelve a lanzar el script ya actualizado
    echo start "" "%~f0"
) > "%temp%\updater.bat"

start "" /B "%temp%\updater.bat"
exit

:EndUpdate
del "%tempVersionFile%" >nul 2>&1
echo.
pause
goto MENU

:SALIR
echo Saliendo del programa...
start https://github.com/RichyKunBv
timeout /t 2 >nul
exit
