@echo off
echo ========= File du lieu %2
copy %2 CAY.INP > nul
echo ========= Chay chuong trinh %1
tg TBEGIN
%1
tg TEND
tinhtg
echo ========= Test %2
test
del CAY.INP
rem del CAY.OUT
