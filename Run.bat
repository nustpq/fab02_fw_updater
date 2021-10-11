@echo off
TITLE FAB02 Board MCU Firmware Updater
mode con cols=110 lines=25 &color 9f
echo -------------------------------------
echo     FB02 Fimware Update Tool V0.1  
echo           2021.Oct by SQA
echo -------------------------------------
echo.
echo Please make sure to follow instructions on screen step by step !
echo.
pause
echo Please set SW20-[2] switch pin to the [ON] side, then restart FAB02 board by power switch SW1!
pause
echo Please set SW20-[2] switch pin to the [OFF] side!
pause
samba\sam-ba -x fab02.qml
echo.
echo.
echo FAB02 firmware updated is done.
echo Please restart FAB02.
echo.
pause
exit
