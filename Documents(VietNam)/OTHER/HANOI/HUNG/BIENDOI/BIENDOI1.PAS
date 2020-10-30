
{ LE VAN HUNG K28 A2 PHAN BOI CHAU - NGHE AN }
     { BAI BIENDOI1 }
uses crt;
const
     fi='c:\data\tam\biEndoi1.in9';
     fo='c:\biEndoi1.out';
var
   f:text;
   a:array[1..100,1..100]of byte;
   luu_X,luu_Y,X,y:array[1..100]of byte;
   n,so_can_lay:integer;

Procedure readfile;
var
    i,j,t:integer;

Begin
     assign(f,fi);
     reset(f);
     readln(f,n);
     for i:=1 to n do
     for j:=1 to n do
     read(f,a[i,j]);
{     readln(f);}
     for i:=1 to n do
     for j:=1 to n do
     Begin
          read(f,t);
          If t=a[i,j] then a[i,j]:=0 Else a[i,j]:=1;
     End;
     close(f);
End;
function kt:boolean;
var i,j:integer;
Begin
     kt:=false;
     for i:=1 to n do
     for j:=1 to n do
     If (a[i,j]+a[1,1])mod 2<>(a[i,1]+a[1,j]) mod 2 then
     eXit;
     kt:=true;
End;
Procedure tinh1;
var
    so_lay,i,j:integer;
Begin
     fillchar(X,sizeof(X),0);
     fillchar(y,sizeof(y),0);
     so_can_lay:=200;
     for X[1]:=0 to 1 do
     Begin
          so_lay:=X[1];
          for j:=1 to n do
          Begin
               y[j]:=(a[1,j]+2 - X[1]) mod 2;
               inc(so_lay,y[j]);
          End;
          for j:=2 to n do
          Begin
               X[j]:=(a[j,1]+2-y[1])mod 2;
               inc(so_lay,X[j]);
          End;
          If so_lay< so_can_lay then
          Begin
               so_can_lay:=so_lay;
               luu_X:=X;
               luu_Y:=y;
          End;
     End;
End;
Procedure writefile;
var i,j:integer;
Begin
     assign(f,fo);
     rewrite(f);
     If not kt then write(f,-1 )
     Else
     Begin
          writeln(f,1);
          tinh1;
          writeln(f,so_can_lay);
          for i:=1 to n do write(f,luu_X[i],' ');
          writeln(f);
          for i:=1 to n do write(f,luu_y[i],' ');
     End;
     close(f);
End;
Procedure sinhtest1;
var n,i,j,t:integer;
Begin
     assign(f,fi);
     rewrite(f);
     n:=100;
     randomize;
     writeln(f,n);
     for i:=1 to n do
     Begin
          for j:=1 to n do
          Begin
               t:=random(100)+1;
               write(f,t mod 2,' ');
               a[i,j]:=t mod 2;
          End;
          writeln(f);
     End;
     for i:=1 to n do
     Begin
          t:=random(100)+1;
          X[i]:= t mod 2;
     End;
     for i:=1 to n do
     Begin
          t:=random(100)+1;
          y[i]:= t mod 2;
     End;
     for i:=1 to n do
     If X[i]=1 then
     Begin
          for j:=1 to n do
          a[i,j]:=(a[i,j]+1) mod 2;
     End;
     for i:=1 to n do
     If y[i]=1 then
     Begin
          for j:=1 to n do
          a[j,i]:=(a[j,i]+1) mod 2;
     End;
     for i:=1 to n do
     Begin
          for j:=1 to n do
          write(f,a[i,j],' ');
          writeln(f);
     End;
     close(f);
End;
Procedure sinhtest2;
var n,i,j,t:integer;
Begin
     assign(f,fi);
     rewrite(f);
     n:=100;
     randomize;
     for i:=1 to n do
     Begin
          for j:=1 to n do
          Begin
               t:=random(100)+1;
               write(f,t mod 2, ' ' );
          End;
          writeln(f);
     End;
     close(f);
End;

Begin

     clrscr;
{     sinhtest1;} { chuong trinh nay cho cac test luon bien doi duoc}
{     sinhtest2;} { chuong trinh nay cho cac test co the khong the
                  bien doi duoc}
     readfile;
     writefile;
End.
5
1 0 0 1 0
1 0 0 1 0
0 1 1 0 1
1 0 1 0 0
0 1 0 1 0
0 0 1 0 0
1 1 0 1 1
0 0 1 0 0
1 1 1 0 1
0 0 0 1 1
