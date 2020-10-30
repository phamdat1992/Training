{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}
uses crt;
const
  FILEINP='VIDU2.INP';
  FILEOUT='VIDU2.OUT';
  MAX=100;
  MAXT=10000;
var
  n,T:integer;
  V,W:array[1..MAX]of integer;
  f:array[0..MAXT]of integer;
 procedure Enter;
  var
    fi:text;
    i:integer;
  begin
    assign(fi,FILEINP);
    reset(fi);
    readln(fi,n,T);
    for i:=1 to n do
     readln(fi,V[i],W[i]);
    close(fi);
  end;
 procedure Init;
  var
    i:integer;
  begin
    for i:=0 to T do
     f[i]:=0;
  end;
 procedure Solve;
  var
    i,j:integer;
  begin
    for i:=1 to T do
     for j:=1 to n do
      if (i>=V[j]) and (f[i]<f[i-V[j]]+W[j]) then
       f[i]:=f[i-V[j]]+W[j];
  end;
 procedure PrintResult;
  var
    fo:text;
    i,Best:integer;
  begin
    assign(fo,FILEOUT);
    rewrite(fo);
    Best:=0;
    for i:=1 to T do
     if f[i]>Best then Best:=f[i];
    writeln(fo,'Tong gia tri do vat lon nhat chon duoc la : ',Best);
    close(fo);
  end;
begin
  clrscr;
  Enter;
  Init;
  Solve;
  PrintResult;
end.