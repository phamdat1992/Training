uses crt;
const fi='inp.b93';
      fo='out.b9';
      b:array[1..8] of shortint=(-1,0,1,0,-1,-1,1,1);
      c:array[1..8] of shortint=(0,1,0,-1,-1,1,1,-1);

type  mang1=array[1..16,1..16] of word;
      mang2=array[1..16,1..16,1..3] of 0..8;
var a,luu,val:mang1;
    sl:mang2;
    tong:longint;
    dt:array[1..200] of byte;
    m,n,dd:byte;
    f,f1:text;

procedure  readfile;
var i,j:byte;
begin
 tongf:=0;
 assign(f,fi);
 reset(f);
 readln(f,m,n);
 for i:=1 to m do
  for j:=1 to n do read(f,a[i,j]);
  close(f);
end;

procedure    tao_mang_sl;
var i,j:byte;
begin
 fillchar(sl,sizeof(sl),0);
 for i:=1 to m do
  for j:=1 to n do
   begin
     sl[i,j,1]:=a[i,j] mod 9;
     a[i,j]:=(a[i,j]-sl[i,j,1]) div 9;
     sl[i,j,2]:=a[i,j] mod 9;
     sl[i,j,3]:=(a[i,j]-sl[i,j,2]) div 9;
     tong:=tong+sl[i,j,1]+sl[i,j,2]+sl[i,j,3];
   end;
   if tong>m*n then begin writeln(f1,'0');halt;end;
end;

function dong(j:byte):byte;
begin
 dong:=1+(j-1) div n;
end;

function cot(j:byte):byte;
begin
 cot:=(j-1) mod n+1;
end;

function ok(i,j:byte):boolean;
var k,x1,x2:byte;
begin
   ok:=false;
   x1:=dong(j);
   x2:=cot(j);
   for k:=1 to 8 do
    if (x1+b[k]>0) and (x1+b[k]<=m) and (x2+c[k]>0) and (x2+c[k]<=n) then
     if sl[x1+b[k],x2+c[k],i]<=0 then  exit;
    for k:=1 to 8 do
     if (x1+b[k]>0) and (x1+b[k]<=m) and (x2+c[k]>0) and (x2+c[k]<=n) then
        dec(sl[x1+b[k],x2+c[k],i]);
    ok:=true;
end;

procedure  visit(i,j:byte);
var k:byte;
begin
  val[i,j]:=dd;
  inc(dt[dd]);
  for k:=1 to 4 do
   if (i+b[k]>0) and (j+c[k]>0) and (i+b[k]<=m) and (j+c[k]<=n) then
    if (val[i+b[k],j+c[k]]=0) and (luu[i,j]=luu[i+b[k],j+c[k]]) then
    visit(i+b[k],j+c[k]);
end;

procedure chon(dd:byte);
var chiso:array[1..200] of byte;
    i,j,tg:byte;
begin
 for i:=1 to dd do chiso[i]:=i;
  for i:=1 to dd-1 do
   for j:=i+1 to dd do
    if dt[i]>dt[j] then
     begin
      tg:=dt[i];
      dt[i]:=dt[j];
      dt[j]:=tg;
      tg:=chiso[i];
      chiso[i]:=chiso[j];
      chiso[j]:=tg;
     end;
     for i:=1 to dd do write(f1,chiso[i],'  ');
end;

procedure  loang;
var  i,j,dem:byte;
     tap:set of byte;
begin
  fillchar(val,sizeof(val),0);
  fillchar(dt,sizeof(dt),0);
  dd:=0;tap:=[];dem:=0;
  for i:=1 to m do
   for j:=1 to n do
     if val[i,j]=0 then
      begin
       inc(dd);
       visit(i,j);
       if not (dt[dd] in tap) then
        begin
         tap:=tap+[dt[dd]];
         inc(dem);
        end;
    end;
    writeln(f1,dd);
    for i:=1 to m do
     begin
       for j:=1 to n do
         write(f1,val[i,j],'  ');
       writeln(f1);
     end;
     writeln(f1,dem);
     chon(dd);
end;

procedure xuat;
var i,j:byte;
begin
 writeln(f1,'1');
 for i:=1 to m do
  begin
   for j:=1 to n do write(f1,luu[i,j],'  ');
   writeln(f1);
  end;
  loang;
  close(f1);
end;

procedure  try(dem:byte);
var  i,x1,x2,k:byte;
begin
   for i:=1 to 3 do
    if ok(i,dem) then
     begin
        luu[dong(dem),cot(dem)]:=i;
        if (dem>=m*n) then begin xuat;halt;end
        else try(dem+1);
        luu[dong(dem),cot(dem)]:=0;
      x1:=dong(dem);x2:=cot(dem);
      for k:=1 to 8 do
        if (x1+b[k]>0) and (x1+b[k]<=m) and (x2+c[k]>0) and (x2+c[k]<=n) then
            inc(sl[x1+b[k],x2+c[k],i]);
     end;
end;


begin  clrscr;
 assign(f1,fo);
 rewrite(f1);
 readfile;
 tao_mang_sl;
 try(1);
 writeln(f1,'0');
 close(f1);
end.

 3 3
 91 101 99
 109 128 189
 91 181 99
 91 101 99
 109 128 189
 91 181 99
 14 6
 3 5 5 5 5 3
 5 8 8 8 8 5
 5 8 8 8 8 5
 5 8 8 8 8 5
 5 8 8 8 8 5
 5 8 8 8 8 5
 5 8 8 8 8 5
 5 8 8 8 8 5
 5 8 8 8 8 5
 5 8 8 8 8 5
 5 8 8 8 8 5
 5 8 8 8 8 5
 5 8 8 8 8 5
 3 5 5 5 5 3


