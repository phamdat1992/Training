{$M 65000,0,655360}
const
     fi='job.inp';
     fo='job.out';
type
    ch=array[0..60000] of boolean;
    m=array[1..10000] of word;
var
   cs:m;
   chon,d:^m;
   g:array[1..10000] of longint;
   roi:^ch;
   n:word;
   f:text;
   t:longint;
procedure nhap;
var
   i:word;
begin
assign(f,fi);reset(f);
readln(f,n);
for i:=1 to n do readln(f,d^[i],g[i]);
close(f);
end;
procedure quicksort(dau,cuoi:word);
var
   t,i,j:word;
begin
if dau>=cuoi then exit;
i:=dau+1;
while (i<=cuoi)and(g[i]>=g[dau]) do inc(i);
j:=cuoi;
while (j>dau)and(g[j]<=g[dau]) do dec(j);
while i<j do
      begin
      t:=g[i];g[i]:=g[j];g[j]:=t;
      t:=d^[i];d^[i]:=d^[j];d^[j]:=t;
      t:=cs[i];cs[i]:=cs[j];cs[j]:=t;
      inc(i);
      while (i<=cuoi)and(g[i]>=g[dau]) do inc(i);
      dec(j);
      while (j>dau)and(g[j]<=g[dau]) do dec(j);
      end;
t:=g[dau];g[dau]:=g[j];g[j]:=t;
t:=d^[dau];d^[dau]:=d^[j];d^[j]:=t;
t:=cs[dau];cs[dau]:=cs[j];cs[j]:=t;
quicksort(dau,j-1); quicksort(j+1,cuoi);
end;
procedure tim;
var
   i,j:word;
begin
for i:=1 to n do cs[i]:=i;
quicksort(1,n);
fillchar(roi^,sizeof(roi^),false);
fillchar(chon^,sizeof(chon^),0);
for i:=1 to n do
    begin
    j:=d^[i];
    while (j>0)and roi^[j] do dec(j);
    if j>0 then
       begin
       roi^[j]:=true;inc(t,g[i]);chon^[cs[i]]:=j;
       end;
    end;
end;
procedure viet;
var
   i:word;
begin
assign(f,fo);rewrite(f);
writeln(f,t);
for i:=1 to n do if chon^[i]>0 then writeln(f,i:6,chon^[i]:6);
close(f);
end;
BEGIN
new(chon);new(roi);new(d);
nhap;tim;viet;
dispose(chon);dispose(roi);dispose(d);
END.