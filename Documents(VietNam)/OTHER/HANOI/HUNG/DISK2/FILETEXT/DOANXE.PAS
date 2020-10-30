uses crt;
const  fi='xe.inp';
       fo='xe.out';
var  tl,vt:array[1..1000] of integer;
     mind:array[1..1000] of real;
     luu:array[1..1000] of integer;
     f:text;
     l,n,p:integer;

procedure  readfile;
var  i:integer;
begin
  assign(f,fi);
  reset(f);
  readln(f,p,l,n);
  for i:=1 to n do  readln(f,tl[i],vt[i]);
  close(f);
end;

procedure  init;
begin
 fillchar(mind,sizeof(mind),0);
 mind[1]:=l/vt[1];luu[1]:=1;
end;

function tg(i,j:integer):real;
var  k,min:integer;
begin
 min:=100;
 for k:=i to j do
  if vt[k]<min then min:=vt[k];
 tg:=l/min;
end;

procedure  xuat;
var i:integer;
begin
 i:=n;
 writeln(n);
 while i>1 do
  begin
   i:=luu[i]-1;
   writeln(i);
  end;
end;

procedure  xuli;
var i,j:integer;
    tlg:real;
begin
  fillchar(luu,sizeof(luu),0);
  fillchar(mind,sizeof(mind),0);
  init;
 for i:=2 to n do
  begin
    tlg:=tl[i]+tl[i-1];
    mind[i]:=mind[i-1]+l/vt[i];luu[i]:=i;
    j:=i-2;
    while (tlg<=p) and (j>0) do
     begin
       if mind[i]>mind[j]+tg(j+1,i) then
        begin
         mind[i]:=mind[j]+tg(j+1,i);
         luu[i]:=j+1;
        end;
        tlg:=tlg+tl[j]+1;
        dec(j);
     end;
  end;
  writeln(mind[10]:3:3);
  xuat;
end;

begin  clrscr;
 readfile;
 xuli;
 readln
end.

 100 100 10
 40 25
 50 20
 50 20
 70 10
 12 50
 9 70
 49 30
 38 25
 27 50
 79 70




































































































































































































































































































































































































































