@echo off
:: WebOS Windows Refap v1.2.0
Color 0a
echo --- Iniciando protoculo ---

echo Ejecutando SFC para pasar el rato...
sfc /scannow

echo Curando con medikit...
DISM /Online /Cleanup-Image /CheckHealth

echo Reparando ando...
DISM /Online /Cleanup-Image /RestoreHealth

echo Defrag C y D mamaron...
defrag C: /O
defrag D: /O

Color 0c
echo Escaneando C y D en busca de virus de xvideos...
chkdsk C: /scan
chkdsk D: /scan

echo Otra vez actívate Javascript...
ipconfig /flushdns
netsh int ip reset
netsh winsock reset
netsh advfirewall reset

Color 09
echo Si...
cleanmgr /sagerun:1

echo Creando algo...
reagentc /info
reagentc /enable

:: Crear punto de restauración
echo Creando punto de restauracion por si se pudre...
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Mantenimiento", 100, 7

:: Limpiar archivos temporales
echo Deleting el bloatware escondido...
del /s /q %temp%\*.* 2>nul
del /s /q C:\Windows\Temp\*.* 2>nul

:: Revisar procesos sospechosos
echo Mirando si hay algun rat por ahi...
tasklist | findstr /I /C:"malware" /C:"virus"

:: Optimizar inicio
echo Revisando que chucha arranca con Windows...
wmic startup get caption,command

:: Verificar estado del disco
echo Checando si el disco mamó...
wmic diskdrive get status

Color 03
Color 06
Color 07
Color 04
Color 01
Color 07
echo uy un gay!
shutdown -p
exit
