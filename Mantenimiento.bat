@echo off
:: WebOS Windows Refap v1.0.1
Color 0a
echo --- Iniciando protoculo ---

echo Ejecutando SFC para pasar el rato...
sfc /scannow

echo Curando con medikit...
DISM /Online /Cleanup-Image /CheckHealth

echo Reparando ando...
DISM /Online /Cleanup-Image /RestoreHealth

echo Defrag C y D mamaron...
defrag C: /u
defrag D: /u

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

echo Reddit (nunca supe cómo se escribía)...
wevtutil cl System

Color 03
Color 06
Color 07
Color 04
Color 01
Color 07
echo uy un gay!
shutdown -p
exit
