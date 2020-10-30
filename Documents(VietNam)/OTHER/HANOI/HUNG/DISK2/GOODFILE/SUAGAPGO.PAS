uses crt;
const
 cha:array[1..4] of char=('D','L','U','R');
  b:array[1..4] of shortint=(-1,0,1,0);
  c:array[1..4] of shortint=(0,1,0,-1);
type  mang=array[0..100,0..100] of byte;
var   a,mind,luus:mang;
      ok1:array[1..100,1..100] of boolean;
      f:text;
      m,n:byte;

procedure readfile;
var  i,j:byte;
begin
 writeln('INPUT:');
 fillchar(ok1,sizeof(ok1),true);
 assign(f,'gap_go.inp');
 reset(f);
 readln(f,m,n);
 writeln(m,'  ',n);
 for i:=1 to m do
  begin
  for j:=1 to n do
   begin
    read(f,a[i,j]);
    write(a[i,j],' ');
   end;
   writeln;
   end;
 close(f);
end;

function ok(i,j:integer):boolean;
begin
 ok:=false;
 if (i<0) or (i>m) or (j<0) or (j>n)or (a[i,j]<>0) then exit;
 ok:=true;
end;

function  doiso(i:byte):byte;
begin
 if i<=2 then doiso:=i+2
 else doiso:=i-2;
end;

procedure  innit;
begin
  fillchar(mind,sizeof(mind),0);
  luus:=mind;
  if a[1,2]=0 then begin mind[1,2]:=1;luus[1,2]:=2;end;
  if a[2,1]=0 then begin mind[2,1]:=1;luus[2,1]:=3;end;
end;

procedure xuat;
var k,l1,l2,dem:integer;
    ch:array[1..1000] of byte;
begin
  writeln('OUPUT:');
  dem:=0;
  if (mind[m,n]<=0) or odd(mind[m,n]) then writeln('khong co duong di:')
  else
  if not (odd(mind[m,n])) then
  begin
  k:=luus[m,n];l1:=m;l2:=n;
  while k>0 do
   begin
     inc(dem);
     ch[dem]:=k;
     l1:=l1-b[k];l2:=l2-c[k];
     k:=luus[l1,l2];
   end;
   for k:= dem downto dem div 2+1 do write(cha[doiso(ch[k])]);writeln;
   for k:= 1 to dem div 2  do write(cha[ch[k]]);
  end;
end;

procedure xu_li;
var   i,j,k,min,luu1,luu2:integer;dk:boolean;
begin
 ok1[1,1]:=false;
  repeat
   min:=maxint;luu1:=0;luu2:=0;
    for i:=1 to m do
      for j:=1 to n do
       if (mind[i,j]>0)and(mind[i,j]<min) and ok1[i,j] then
        begin
           min:=mind[i,j];
           luu1:=i;
           luu2:=j;
        end;
   ok1[luu1,luu2]:=false;
   for i:=1 to 4 do
    if ok(luu1+b[i],luu2+c[i]) and ok1[luu1+b[i],luu2+c[i]] then
      if (mind[luu1+b[i],luu2+c[i]]=0) or
       (mind[luu1+b[i],luu2+c[i]]>mind[luu1,luu2]+1) then
     begin
      mind[luu1+b[i],luu2+c[i]]:=mind[luu1,luu2]+1;
      luus[luu1+b[i],luu2+c[i]]:=i;
     end;
   until luu1<=0;
   xuat;
end;

begin  clrscr;
 readfile;
 innit;
 xu_li;
 readln
end.

16 18
0 1 0 0 0 1 0 1 1 1 1 1 0 0 0 0 0 0
0 1 0 0 0 0 1 0 1 0 1 1 0 0 0 1 0 1
0 0 1 0 0 0 1 0 1 0 0 0 1 1 1 1 0 0
0 0 0 0 0 0 0 1 1 1 1 0 0 0 1 0 1 1
1 1 1 0 0 0 0 0 0 0 1 0 0 0 0 1 0 1
0 1 1 0 0 0 1 0 1 0 0 1 0 0 0 1 0 1
0 0 0 0 1 1 1 0 0 0 0 0 1 0 0 0 1 1
1 1 0 0 0 1 0 1 1 1 1 0 0 0 0 0 0 0
0 1 0 0 0 0 1 0 1 0 1 1 0 0 0 1 0 1
0 0 1 0 0 0 1 0 1 0 0 0 1 1 0 0 0 0
0 0 0 1 0 0 0 1 1 1 1 0 0 0 0 0 1 1
1 1 1 0 0 0 0 0 0 0 1 0 0 0 0 1 0 1
0 1 1 0 0 0 1 0 1 0 0 1 0 0 0 1 0 1
0 0 0 1 1 1 1 0 0 0 0 0 1 0 0 0 1 1
1 1 0 0 0 1 0 1 1 1 1 0 0 0 0 0 0 0
0 1 0 0 0 0 1 0 1 0 1 1 0 0 0 1 0 0
0 0 1 0 0 0 1 0 1 0 0 0 1 1 1 1 0 0