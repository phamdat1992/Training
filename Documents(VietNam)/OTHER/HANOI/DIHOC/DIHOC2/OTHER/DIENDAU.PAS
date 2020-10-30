Program Diemdau;
Uses crt;
Const
     Fi='diendau.inp';
     Fo='diendau.out';
     Maxn=100;
Var
   n,i,j:integer;
   f1,f2:text;
   so:real;
   tong:integer;

Function gt(a,b:real;dau:integer):real;
begin
     case dau of
          1: gt:=a+b;
          2: gt:=a-b;
          3: gt:=a*b;
          4: {if b<>0 then} gt:=a/b {else gt:=0;}
     end;
end;

procedure xuly(so:real);
Var
   i,j,k,l,m:integer;
begin
     tong:=1;
     For i:=1 to 6 do tong:=tong*i;
     if so>tong then
     begin
          writeln(f2,0);
          exit;
     end
     else
     begin
     For i:=1 to 4 do
         for j:=1 to 4 do
             for k:=1 to 4 do
                 for l:=1 to 4 do
                     for m:=1 to 4 do
                         if  gt(gt(gt(gt(gt(1,2,i),3,j),4,k),5,l),6,m)=so then
                         begin
                              writeln(f2,i,' ',j,' ',k,' ',l,' ',m);
                              writeln(i,' ',j,' ',k,' ',l,' ',m);
                              exit;
                         end;
     end;
end;


Procedure Main;
Begin
     assign(f1,fi);
     Reset(f1);
     Assign(f2,fo);
     Rewrite(f2);
     Readln(f1,n);
     for i:=1 to n do
     begin
          readln(f1,so);
          xuly(so);
     end;
     Close(f1);
     Close(f2);
End;

BEGIN
     Clrscr;
     Main;
END.
1
90



1
13000

20
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20

1
35

2
120
720

5
3
4
12
36
95


