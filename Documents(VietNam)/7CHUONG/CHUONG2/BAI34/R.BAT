@echo off
echo ========= File du lieu %2
echo *** Input: %2
copy %2 XH.INP > nul
echo ========= Chay chuong trinh %1
tg TBEGIN
%1
if errorlevel 1 goto Err
tg TEND
tinhtg
echo *** Ket qua test
test
if errorlevel 1 goto Err1
goto End
:Err1
echo Xem lai form output cua chuong trinh!
goto End1
:Err
echo Runtime error!
:End
del XH.OUT
:End1
del XH.INP
