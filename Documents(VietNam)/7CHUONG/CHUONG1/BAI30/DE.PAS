{$M 65000,0,655360}
{B-}
uses crt;
const
      fi='inp.bl';
      fo='out.bl';
      fu='phu.txt';
type
    mang=array[0..30,0..30,0..30] of word;
var
lk:array[0..30,0..30,0..30] of byte;
truoc:array[0..30,0..30,0..30] of byte;
dd:^mang;
f:text;g:file of byte;
rax,ray,raz,x0,y0,z0,lastx,lasty,lastz,i,j,k,n:byte;
m,dem,min,mindd:word;
procedure readdata;
var
   p,q,r,s:byte;
begin
fillchar(lk,sizeof(lk),0);
assign(f,fi);reset(f);
readln(f,n);readln(f,x0,y0,z0);
while not(eof(f)) do
      begin
      readln(f,p,q,r,s);
      if p=0 then
         begin
         lk[0,q,r]:=s;
         for i:=1 to s do lk[i,q,r]:=1;
         end;
      if p=n then
         begin
         for i:=n-1 downto n-s do lk[i,q,r]:=1;
         lk[n,q,r]:=s;
         end;
      if q=0 then
         begin
         for i:=1 to s do lk[p,i,r]:=1;
         lk[p,0,r]:=s;
         end;
      if q=n then
         begin
         for i:=n-1 downto n-s do lk[p,i,r]:=1;
         lk[p,n,r]:=s;
         end;
      if r=0 then
         begin
         for i:=1 to s do lk[p,q,i]:=1;
         lk[p,q,0]:=s;
         end;
      if r=n then
         begin
         for i:=n-1 downto n-s do lk[p,q,i]:=1;
         lk[p,q,n]:=s;
         end;
      end;
close(f);
end;
function thoat(x8,y8,z8:byte):boolean;
begin
thoat:=false;
if x0=0 then thoat:=(x8=n)and(y8*z8>0);
if x0=n then thoat:=(x8=0)and(y8*z8>0);
if y0=0 then thoat:=(y8=n)and(x8*z8>0);
if y0=n then thoat:=(y8=0)and(x8*z8>0);
if z0=0 then thoat:=(z8=n)and(x8*y8>0);
if z0=n then thoat:=(z8=0)and(x8*y8>0);
end;
function dh(tx1,ty1,tz1,tx2,ty2,tz2,tx3,ty3,tz3:byte):boolean;
begin
dh:=((tx2-tx1)*(tx2-tx3)+(ty2-ty1)*(ty2-ty3)+(tz2-tz1)*(tz2-tz3)=0)
end;
function bien(a,b,c:byte):boolean;
begin
bien:=(a=0)or(a=n)or(b=0)or(b=n)or(c=0)or(c=n);
end;
procedure vietduong;
var
    so,x1,y1,z1,x2,y2,z2,x3,y3,z3:byte;
begin
writeln('Bat dau ghi lai duong di');
dem:=0;
x1:=lastx;y1:=lasty;z1:=lastz;
assign(g,fu);rewrite(g);
inc(dem,3);write(g,lastz);write(g,lasty);write(g,lastx);
while (x1<>x0)or(y1<>y0)or(z1<>z0) do
begin
  if truoc[x1,y1,z1]=129 then begin x2:=x1+1;y2:=y1; z2:=z1; end;
  if truoc[x1,y1,z1]=130 then begin x2:=x1-1;y2:=y1;z2:=z1; end;
  if truoc[x1,y1,z1]=131 then begin x2:=x1;y2:=y1+1;z2:=z1; end;
  if truoc[x1,y1,z1]=132 then begin x2:=x1;y2:=y1-1;z2:=z1; end;
  if truoc[x1,y1,z1]=133 then begin x2:=x1;y2:=y1; z2:=z1+1; end;
  if truoc[x1,y1,z1]=134 then begin x2:=x1;y2:=y1;z2:=z1-1; end;
      if (x2=x0)and(y2=y0)and(z2=z0) then
         begin inc(dem,3);write(g,z2);write(g,y2);write(g,x2);end
      else
      begin
      if truoc[x2,y2,z2]=129 then begin x3:=x2+1;y3:=y2;z3:=z2; end;
      if truoc[x2,y2,z2]=130 then begin x3:=x2-1;y3:=y2;z3:=z2; end;
      if truoc[x2,y2,z2]=131 then begin x3:=x2;y3:=y2+1;z3:=z2; end;
      if truoc[x2,y2,z2]=132 then begin x3:=x2;y3:=y2-1;z3:=z2; end;
      if truoc[x2,y2,z2]=133 then begin x3:=x2;y3:=y2;z3:=z2+1; end;
      if truoc[x2,y2,z2]=134 then begin x3:=x2;y3:=y2;z3:=z2-1; end;
      if dh(x1,y1,z1,x2,y2,z2,x3,y3,z3) then
      begin inc(dem,3);write(g,z2);write(g,y2);write(g,x2);end;
      end;
      x1:=x2;y1:=y2;z1:=z2;
end;
close(g);
writeln('Bat dau viet duong di!!!');
assign(g,fu);reset(g);
for i:=dem downto 1 do
    begin
    seek(g,i-1);read(g,so);
    write(f,so:5);
    if ((i-1) mod 3 = 0) then writeln(f);
    end;
close(g);
close(f);
end;
procedure dao;
var so,x1,y1,z1,x2,y2,z2,x3,y3,z3,i1,j1,k1:byte;
begin
   lastx:=x0;lasty:=y0;lastz:=z0;
   new(dd);
   for i:=0 to 30 do
   for j:=0 to 30 do
   for k:=0 to 30 do dd^[i,j,k]:=60000;
   fillchar(truoc,sizeof(truoc),0);
   dd^[lastx,lasty,lastz]:=0;inc(truoc[lastx,lasty,lastz],128);
   while not(thoat(lastx,lasty,lastz)) do
   begin
       min:=60000;
       if lastx>=1 then
       begin
       i1:=lastx-1;j1:=lasty;k1:=lastz;
       if (truoc[i1,j1,k1]<128) then
       if ((lk[0,j1,k1]>=lastx)or(n-lk[n,j1,k1]<=lastx-1))
       then begin if dd^[i1,j1,k1]>dd^[lastx,lasty,lastz]+1
            then begin dd^[i1,j1,k1]:=dd^[lastx,lasty,lastz]+1;
            truoc[i1,j1,k1]:=1;end;
            end
       else
            if dd^[i1,j1,k1]>dd^[lastx,lasty,lastz]+1000
            then begin truoc[i1,j1,k1]:=1;
            dd^[i1,j1,k1]:=dd^[lastx,lasty,lastz]+1000;end;
       end;
       if lastx<n then
       begin
       i1:=lastx+1;j1:=lasty;k1:=lastz;
       if (truoc[i1,j1,k1]<128) then
       if ((lk[0,j1,k1]>=lastx+1)or(n-lk[n,j1,k1]<=lastx))
       then begin if dd^[i1,j1,k1]>dd^[lastx,lasty,lastz]+1
            then begin dd^[i1,j1,k1]:=dd^[lastx,lasty,lastz]+1;
            truoc[i1,j1,k1]:=2;end;
            end
       else
            if dd^[i1,j1,k1]>dd^[lastx,lasty,lastz]+1000
            then begin truoc[i1,j1,k1]:=2;
            dd^[i1,j1,k1]:=dd^[lastx,lasty,lastz]+1000;end;
       end;
       if lasty>=1 then
       begin
       j1:=lasty-1;i1:=lastx;k1:=lastz;
       if (truoc[i1,j1,k1]<128) then
       if ((lk[i1,0,k1]>=lasty)or(n-lk[i1,n,k1]<=lasty-1))
       then begin if dd^[i1,j1,k1]>dd^[lastx,lasty,lastz]+1 then
            begin truoc[i1,j1,k1]:=3;
            dd^[i1,j1,k1]:=dd^[lastx,lasty,lastz]+1;end;
            end
       else
            if dd^[i1,j1,k1]>dd^[lastx,lasty,lastz]+1000
            then begin truoc[i1,j1,k1]:=3;
            dd^[i1,j1,k1]:=dd^[lastx,lasty,lastz]+1000;end;
       end;
       if lasty<n then
       begin
       j1:=lasty+1;i1:=lastx;k1:=lastz;
       if (truoc[i1,j1,k1]<128) then
       if ((lk[i1,0,k1]>=lasty+1)or(n-lk[i1,n,k1]<=lasty))
       then begin if dd^[i1,j1,k1]>dd^[lastx,lasty,lastz]+1 then
            begin truoc[i1,j1,k1]:=4;
            dd^[i1,j1,k1]:=dd^[lastx,lasty,lastz]+1;end;
            end
       else
            if dd^[i1,j1,k1]>dd^[lastx,lasty,lastz]+1000
            then begin truoc[i1,j1,k1]:=4;
            dd^[i1,j1,k1]:=dd^[lastx,lasty,lastz]+1000;end;
       end;
       if lastz>=1 then
       begin
       k1:=lastz-1;i1:=lastx;j1:=lasty;
       if (truoc[i1,j1,k1]<128) then
       if ((lk[i1,j1,0]>=lastz)or(n-lk[i1,j1,n]<=lastz-1))
       then begin if dd^[i1,j1,k1]>dd^[lastx,lasty,lastz]+1
            then begin truoc[i1,j1,k1]:=5;
            dd^[i1,j1,k1]:=dd^[lastx,lasty,lastz]+1;end;
            end
       else
            if dd^[i1,j1,k1]>dd^[lastx,lasty,lastz]+1000
            then begin truoc[i1,j1,k1]:=5;
            dd^[i1,j1,k1]:=dd^[lastx,lasty,lastz]+1000;end;
       end;
       if lastz<n then
       begin
       k1:=lastz+1;i1:=lastx;j1:=lasty;
       if (truoc[i1,j1,k1]<128) then
       if ((lk[i1,j1,0]>=lastz+1)or(n-lk[i1,j1,n]<=lastz))
       then begin if dd^[i1,j1,k1]>dd^[lastx,lasty,lastz]+1
            then begin truoc[i1,j1,k1]:=6;
            dd^[i1,j1,k1]:=dd^[lastx,lasty,lastz]+1;end;
            end
       else
            if dd^[i1,j1,k1]>dd^[lastx,lasty,lastz]+1000
            then begin truoc[i1,j1,k1]:=6;
            dd^[i1,j1,k1]:=dd^[lastx,lasty,lastz]+1000;end;
       end;
   min:=60000;
   for i:=0 to n do
   for j:=0 to n do
   for k:=0 to n do if (truoc[i,j,k]<128)and(dd^[i,j,k]<min) then
   begin lastx:=i;lasty:=j;lastz:=k;min:=dd^[i,j,k];end;
   inc(truoc[lastx,lasty,lastz],128);
   end;
   mindd:=dd^[lastx,lasty,lastz];
   release(dd);
   assign(f,fo);rewrite(f);
   if mindd<1000 then
   begin
   writeln(f,'CAU 1');
   writeln(f,mindd);
   vietduong;
   end
   else
   begin
   assign(f,fo);rewrite(f);
   writeln(f,'CAU 2');mindd:=mindd div 1000;
   writeln(f,mindd);
   vietduong;
   end;
end;
BEGIN
clrscr;readdata;dao;
END.


