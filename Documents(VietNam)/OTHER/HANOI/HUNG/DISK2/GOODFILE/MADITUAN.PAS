(* thuat toan :dung tham lam chi mot duong di cua con ma:*)

program ma_di_tuan;
uses crt;
const c1:array[1..8] of shortint=(-2,-2,-1,1,2,2,1,-1);
      c2:array[1..8] of shortint=(-1,1,2,2,1,-1,-2,-2);
var a:array[1..100,1..100] of word;
    b:array[1..100,1..100] of 0..8;
    n,x,y:byte;

procedure tao_mang;
var i,j,k:integer;
begin
 fillchar(b,sizeof(b),0);
 fillchar(a,sizeof(a),0);
 for i:=1 to n do
  for j:=1 to n do
   for k:=1 to 8 do
    if (i+c1[k]>0) and (i+c1[k]<=n) and (j+c2[k]>0) and (j+c2[k]<=n) then
     inc(b[i,j]);
end;

procedure xuat;
var i,j,k,t:integer;
begin
{ textmode(1);}
 i:=0;
 while i<n*n do
  begin
   textcolor(green);
   clrscr;
   inc(i);
   for j:=1 to n do
    begin
     for k:=1 to n do
      begin
       textcolor(green);
       if (a[j,k]>i) then write('.':4)
       else
       begin
       textcolor(green);
       if a[j,k]<i then write(a[j,k]:4);
       if a[j,k]=i then
        begin
         textcolor(white+128);
         write(a[j,k]:4);
        end;
       end;
      end;
    writeln;
{    writeln;}
  end;
  delay(50);
end;
delay(2000);
clrscr;
  for i:=1 to n do
  begin
   clrscr;
   textcolor(green);
   for j:=1 to i do
    begin
     for k:=1 to n do write(a[j,k]:4);
    writeln;
    end;
    delay(50);
  end;
  delay(1000);
  clrscr;
  textcolor(lightred);
  for i:=n downto 1 do
  begin
  clrscr;
  for j:=1 to n do
   begin
   for k:=1 to n do
    begin
     if j>=i  then write(a[j,k]:4)
     else write('  ');
    end;
    writeln;
  end;
  delay(50);
end;
delay(1000);
clrscr;
textcolor(yellow);
for i:=1 to n do
 begin
  clrscr;
  for j:=1 to n do
   begin
   for k:=1 to n do
    if k<=i then write(a[j,k]:4)
    else write('    ');
    writeln;
   end;
   delay(50);
  end;
delay(1000);
clrscr;
textcolor(white);
for i:=n downto 1 do
 begin
  clrscr;
  for j:=1 to n do
   begin
   for k:=1 to n do
    if k>=i then write(a[j,k]:4)
    else write('    ');
    writeln;
   end;
   delay(50);
  end;
delay(1000);
clrscr;
textcolor(green);
for i:=1 to 2*n do
 begin
  clrscr;
  for j:=1 to n do
   begin
   for k:=1 to n do
    if k+j<=i+1 then write(a[j,k]:4)
    else write('    ');
    writeln;
   end;
   delay(50);
  end;
delay(1000);
clrscr;
textcolor(green);
for i:=2*n downto 1 do
 begin
  clrscr;
  for j:=1 to n do
   begin
   for k:=1 to n do
    if k+j>=i+1 then write(a[j,k]:4)
    else write('    ');
    writeln;
   end;
   delay(50);
  end;
delay(1000);
clrscr;
textcolor(green);
for i:=2*n downto 1 do
 begin
  clrscr;
  for j:=1 to n do
   begin
   for k:=1 to n do
    if k+n-j>=i then write(a[j,k]:4)
    else write('    ');
    writeln;
   end;
   delay(50);
  end;
delay(1000);
clrscr;
textcolor(green);
for i:= 1 to 2*n do
 begin
  clrscr;
  for j:=1 to n do
   begin
   for k:=1 to n do
    if k+n-j<=i then write(a[j,k]:4)
    else write('    ');
    writeln;
   end;
   delay(50);
  end;
end;

procedure xu_li;
var dem,i,k,j,min,luu1,luu2:integer;
begin
  dem:=1;
  a[x,y]:=dem;
  repeat
    min:=9;
    for k:=1 to 8 do
   if (x+c1[k]>0) and (x+c1[k]<=n) and (y+c2[k]>0) and (y+c2[k]<=n) and (a[x+c1[k],y+c2[k]]=0) then
   begin
    dec(b[x+c1[k],y+c2[k]]);
    if ((b[x+c1[k],y+c2[k]]=0) and (dem=n*n-1)) or ((b[x+c1[k],y+c2[k]]<min) and (b[x+c1[k],y+c2[k]]>0)) then
      begin
       min:=b[x+c1[k],y+c2[k]];
       luu1:=x+c1[k];
       luu2:=y+c2[k];
      end;
    end;
     if min=9 then begin writeln('khong co dung di!');readln;halt;end
     else
     begin
     inc(dem);
     a[luu1,luu2]:=dem;
     x:=luu1;y:=luu2;
     end;
  until dem>=n*n;
  xuat;
end;

begin  clrscr;
write('n=');readln(n);
write('x, y=');readln(x,y);
tao_mang;
xu_li;
readln
end.