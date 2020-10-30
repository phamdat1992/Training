{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program bai1;
uses crt;
const fi='INPUT.TXT';
	  fo='OUTPUT.TXT';
var	  dd:array[0..64000] of byte;
      a,b,dem:longint;
      f:text;

procedure Nhap;
begin
   assign(f,fi); reset(f);
   readln(f,a,b);
   close(f);
end;

function Get_bit(k:longint):byte;
var i,j:longint;
begin
   i:=k div 8;
   j:=k mod 8;
   Get_bit:=(dd[i] shr j) and 1;
end;

procedure Bat_bit(t:longint);
var  i,j,tg,k:longint;
begin
   k:=t; tg:=t;
   repeat
       k :=k + tg mod 10; tg := tg div 10;
   until tg=0;
   i:=k div 8;
   j:=k mod 8;
   dd[i]:=dd[i] or (1 shl j);
end;

procedure Xu_Ly;
var  i,k:longint;
begin
   dem:=0;
   fillchar(dd,sizeof(dd),0);
   if a>45 then k:=a-45
     else k:=1;
   for i:=k to b do  Bat_bit(i);
   for k:=a to b do
     if Get_bit(k)=0 then inc(dem);
end;

procedure Inkq;
var i,j,k:longint;
begin
   assign(f,fo); rewrite(f);
   writeln(f,dem);
   for k:=a to b do
      if Get_bit(k)=0 then write(f,k,' ');
   close(f);
end;

begin
   Clrscr;
   Nhap;
   Xu_Ly;
   Inkq;
end.
