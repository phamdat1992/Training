{$A+,B-,D+,E+,F+,G+,I+,L+,N+,O+,P-,Q+,R+,S+,T-,V+,X+}
{$M 65384,0,655360}
Const
     fi = 'xepviec.inp';
     fo = 'xepviec.out';
     maxN = 200;
     MaxM = 200;
Type
    Mang  = Array[1..MaxN] of integer;
    Mang3 = Array[1..MaxN,1..maxM] of byte;
Var
   A            : mang3;
   d,c          : Mang;
   csc,csd      : mang ;
   n,m          : integer;

Procedure Nhap;
Var
   f    : text;
   i,j  : integer;
   ch   : char;
Begin
Assign(f,fi);reset(f);
Readln(f,m,n);
For i:=1 to m do
    Begin
    read(f,d[i]);
    csd[i]:=i;
    End;
readln(f);
For i:=1 to n do
    Begin
    read(f,c[i]);
    csc[i]:=i;
    End;
close(f);
End;

procedure sortd(f,k : integer);
Var
   i,j  : integer;
   mid  : integer;
   tg   : integer;
begin
i:=f;j:=k;mid:=d[(i+j) div 2];
repeat
while d[i] > mid do inc(i);
while d[j] < mid do dec(j);
if i <= j then
   Begin
   tg:=d[i];d[i]:=d[j];d[j]:=tg;
   tg:=csd[i];csd[i]:=csd[j];csd[j]:=tg;
   inc(i);dec(j);
   End;
until i > j ;
if f < j then sortd(f,j);
if i < k then sortd(i,k);
end;

procedure sortc(f,k : integer);
Var
   i,j  : integer;
   mid  : integer;
   tg   : integer;
begin
i:=f;j:=k;mid:=c[(i+j) div 2];
repeat
while c[i] > mid do inc(i);
while c[j] < mid do dec(j);
if i <= j then
   Begin
   tg:=c[i];c[i]:=c[j];c[j]:=tg;
   tg:=csc[i];csc[i]:=csc[j];csc[j]:=tg;
   inc(i);dec(j);
   End;
until i > j ;
if f < j then sortc(f,j);
if i < k then sortc(i,k);
end;

procedure Xuly;
Var
   i,j  : integer;
begin
For i:=1 to m do
    Begin
    Sortd(1,m);
    sortc(1,n);
    For j:=1 to d[1] do
        Begin
        a[csd[1],csc[j]]:=1;
        dec(d[1]);
        dec(c[j]);
        End;
    End;
end;

Procedure Xuat;
Var
   f    : text;
   i,u  : integer;
Begin
Assign(f,fo);rewrite(f);
For i:=1 to m do
    Begin
    For u:=1 to n do if a[i,u] = 1 then write(f,u,' ');
    Writeln(f);
    End;
close(f);
end;

Begin
Nhap;
Xuly;
Xuat;
End.