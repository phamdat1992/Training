{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}
uses crt;
const
  FILEINP='VIDU1.INP';
  FILEOUT='VIDU1.OUT';
  MAX=100;
  MAXC=15000;
var
  n,S,T:integer;
  a:array[1..MAX,1..MAX]of integer;
  f:array[1..MAX]of integer;
 procedure Enter;
  var
    fi:text;
    i,j:integer;
  begin
    assign(fi,FILEINP);
    reset(fi);
    readln(fi,n,S,T);
    for i:=1 to n do
     begin
       for j:=1 to n do
        read(fi,a[i,j]);
       readln(fi);
     end;
    close(fi);
  end;
 procedure Init;
  var
    i:integer;
  begin
    for i:=1 to n do
     f[i]:=MAXC;
    f[S]:=0;
  end;
 procedure Solve;
  var
    u,v:integer;
    Stop:boolean;
  begin
    repeat
     Stop:=True;
     for u:=1 to n do
      for v:=1 to n do
       if f[u]>f[v]+a[v,u] then
        begin
          f[u]:=f[v]+a[v,u];
          Stop:=False;
        end;
    until Stop;
  end;
 procedure PrintResult;
  var
    fo:text;
  begin
    assign(fo,FILEOUT);
    rewrite(fo);
    writeln(fo,'Duong di ngan nhat tu ',S,' den ',T,' co do dai la : ',f[T]);
    close(fo);
  end;
begin
  clrscr;
  Enter;
  Init;
  Solve;
  PrintResult;
end.