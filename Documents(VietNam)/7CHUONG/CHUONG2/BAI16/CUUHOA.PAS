{$M 65000,0,655360}
const
     fi='ch.inp';
     fo='ch.out';
type
    dd=array[0..200] of byte;
    dong=array[1..200] of longint;
var
   f:text;
   t:array[1..200] of ^dong;
   chua:array[1..200] of boolean;
   a:array[1..200,1..200] of byte;
   truoc:dd;
   max,mm:longint;
   k1:array[1..200] of longint;
   m,n,ch,chon:byte;
procedure nhap;
var
   i,j:byte;k:longint;
begin
assign(f,fi);reset(f);
readln(f,n);
for i:=1 to n do
for j:=1 to n do t[i]^[j]:=1000000000;
while not(seekeof(f)) do
      begin
      readln(f,i,j,k);t[i]^[j]:=k;t[j]^[i]:=k;
      end;
close(f);
end;
procedure ijk(ch:byte;var truoc:dd);
var
   dem,last,j:byte;min:longint;
begin
for j:=1 to n do begin chua[j]:=true;k1[j]:=1000000000;end;
chua[ch]:=false;k1[ch]:=0;last:=ch;
dem:=1;
while dem<n do
      begin
      for j:=1 to n do
      if chua[j] and (t[last]^[j]<1000000000)and(k1[j]>k1[last]+t[last]^[j]) then
          begin k1[j]:=k1[last]+t[last]^[j];truoc[j]:=last;end;
      min:=1500000000;
      for j:=1 to n do if chua[j] and (k1[j]<min) then
          begin min:=k1[j];last:=j;end;
      chua[last]:=false;inc(dem);
      if k1[last]>mm then exit;
      end;
max:=k1[1];for j:=2 to n do if k1[j]>max then max:=k1[j];
if max<mm then begin mm:=max;chon:=ch;end;
end;
procedure mtk;
var
   p,q,r,s:byte;d:dd;
begin
fillchar(a,sizeof(a),0);
for r:=1 to n do
    begin
    for q:=1 to n do if q<>chon then
        begin
        d[0]:=1;d[d[0]]:=q;p:=q;
        while p<>chon do begin p:=truoc[p];inc(d[0]);d[d[0]]:=p;end;
        for p:=1 to d[0]-1 do
            begin
            a[d[p],d[p+1]]:=1;a[d[p+1],d[p]]:=1;
            end;
        end;
    end;
end;
procedure viet;
var
   i,j:byte;
begin
assign(f,fo);rewrite(f);
writeln(f,chon);writeln(f,mm);
for i:=1 to n-1 do
for j:=i+1 to n do if a[i,j]=1 then writeln(f,i:4,j:4);
close(f);
end;
procedure xet;
var
   h:byte;
begin
mm:=2000000000;
for h:=1 to n do ijk(h,truoc);
ijk(chon,truoc);mtk;viet;
end;
BEGIN
for m:=1 to 200 do new(t[m]);
nhap;xet;
for m:=1 to 200 do dispose(t[m]);
END.