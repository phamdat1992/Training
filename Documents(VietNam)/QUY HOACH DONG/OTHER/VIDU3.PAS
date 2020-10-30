{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}
uses crt;
const
  FILEINP='VIDU3.INP';
  FILEOUT='VIDU3.OUT';
  MAX=100;
  MAXW=10000;
var
  n,W:integer;
  a:array[1..MAX]of integer;
  f,IMin:array[0..MAXW]of byte;
 procedure Enter;
  var
    fi:text;
    i:integer;
  begin
    assign(fi,FILEINP);
    reset(fi);
    readln(fi,n,W);
    for i:=1 to n do
     readln(fi,a[i]);
    close(fi);
  end;
 procedure Init;
  var
    i:integer;
  begin
    for i:=0 to W do
     begin
       f[i]:=0;
       IMin[i]:=0;
     end;
    f[0]:=1;
  end;
 procedure Solve;
  var
    i,j:integer;
  begin
    for i:=1 to W do
     for j:=1 to n do
      if (i>=a[j]) and (f[i-a[j]]=1) and (IMin[i-a[j]]<j) then
       begin
         f[i]:=1;
         IMin[i]:=j;
         break;
       end;
  end;
 procedure PrintResult;
  var
    fo:text;
    i,Best:integer;
  begin
    assign(fo,FILEOUT);
    rewrite(fo);
    Best:=0;
    for i:=1 to W do
     if f[i]=1 then Best:=i;
    writeln(fo,'So keo lon nhat chon duoc la ',Best);
    close(fo);
  end;
begin
  clrscr;
  Enter;
  Init;
  Solve;
  PrintResult;
end.