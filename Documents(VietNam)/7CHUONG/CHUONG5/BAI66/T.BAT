@echo off
echo ========= File du lieu %2
copy %2 DC.INP > nul
copy %2.dap DC.DAP > nul
echo ========= Chay chuong trinh %1
tg TBEGIN
%1
tg TEND
echo ========= Test %2
test
del DC.INP
del DC.OUT