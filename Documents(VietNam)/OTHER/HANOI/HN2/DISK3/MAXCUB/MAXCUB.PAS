Program Lapphuong;
Uses crt;
Const
	Fi='Maxcub.inp';
    Fo='Maxcub.out';
    maxn=20;
Var
   i,j,m,n:longint;
   a:array[1..maxn,1..maxn,1..maxn] of longint;
   tong,save:longint;

Procedure Readf;
Var
	f:text;
    k:longint;
Begin
	Assign(f,fi);
    Reset(f);
    Readln(f,n);
    For i:=1 to n do
        for j:=1 to n do
            for k:=1 to n do read(f,a[i,j,k]);
    Close(f);
End;

Procedure Init;
Begin
     Fillchar(a,sizeof(a),0);
     Readf;
End;

Function tinhtong(l,b,c,d:longint):longint;
Var
   i,j,k:longint;
   t:longint;
Begin
     t:=0;
     For k:=l downto l-d+1 do
     	For i:=b downto b-d+1 do
        	for j:=c downto c-d+1 do
             	t:=t+a[k,i,j];
     tinhtong:=t;
End;

Function min(a,b,c:longint):longint;
Var
	t:Longint;
Begin
	t:=a;
    if t>b then t:=b;
    if t>c then t:=c;
    min:=t;
ENd;

Procedure Main;
Var
   t,l,k:longint;
Begin
     tong:=0;

     For i:=1 to n do
         For j:=1 to n do
             For k:=1 to n do
             	for l:=1 to min(i,j,k) do
{                If (i+l<=n) and (j+l<=n) and (k+l<=n) then}
                begin
                    t:=Tinhtong(i,j,k,l);
                  	If tong<t then tong:=t;
                End;
End;

Procedure Done;
Var
   f:text;
   i,j:longint;
Begin
     Assign(f,fo);
     Rewrite(f);
     Writeln(f,tong);
     Close(f);
End;

Procedure sinhtest;
Var
   f:text;
   l,i,j,k:longint;
Begin
     Assign(f,fi);
     Rewrite(f);
     n:=20;
     Writeln(f,n);
{     Randomize;}

     For i:=1 to n do
     begin
          for j:=1 to n do
          begin
              for k:=1 to n do
              begin
                   l:=random(300);
                   if random(10)>6 then write(f,0-l,' ')
                   else write(f,l,' ');
              end;
              writeln(f);
          end;
     end;

     Close(f);
end;

BEGIN
{
sinhtest
end.}
     Clrscr;
     Init;
     Main;
     Done;
END.
3
0 -1 3
-5 7 4
-8 9 1
-1 -3 -1
2 -1 5
0 -1 3
3 1 -1
1 3 2
1 -2 1
