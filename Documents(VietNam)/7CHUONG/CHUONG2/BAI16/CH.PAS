{$M 65000,0,655360}
const
     fi='ch.';
     tam='h.h';
type
    dd=array[0..100] of byte;
    ma=array[1..100,1..100] of byte;
    md=^ma;
var
   f,g:text;c1,c2,c3:char;
   t:array[1..100,1..100] of longint;
   chua:array[1..100] of boolean;
   a,a1:md;
   dsc:array[1..5000] of word;
   cbt:array[1..100,1..2] of byte;
   cc,truoc,ct:dd;max,max1,max2:longint;
   xong:boolean;
   ss:word;
   k1,k2:array[1..100] of longint;
   x,y,n,cx,cy,tx,ty:byte;
procedure sinh;
var
   t1,t2,t3:char;
   u,i,j:word;k:longint;
BEGIN
n:=100;
randomize;
for t1:='0' to '9' do
for t2:='0' to '9' do
for t3:='0' to '9' do
    begin
    assign(f,fi+t1+t2+t3);rewrite(f);
    writeln(f,n);
    for i:=1 to n-1 do
    for j:=i+1 to n do
        begin
        k:=random(2);
        if k=1 then writeln(f,i:4,j:4,10+random(1000):10);
        end;
    close(f);
    end;
END;
procedure nhap;
var
   i,j:byte;k:longint;
begin
assign(f,fi+c1+c2+c3);reset(f);
readln(f,n);
for i:=1 to n do
for j:=1 to n do t[i,j]:=1000000000;
while not(seekeof(f)) do
      begin
      readln(f,i,j,k);t[i,j]:=k;t[j,i]:=k;
      end;
close(f);
end;
procedure ijk(var truoc:dd);
var
   dem,last,j:byte;min:longint;
begin
for j:=1 to n do begin chua[j]:=true;k1[j]:=1000000000;end;
chua[1]:=false;k1[1]:=0;last:=1;
dem:=1;
while dem<n do
      begin
      for j:=2 to n do
      if chua[j] and (t[last,j]<1000000000)and(k1[j]>k1[last]+t[last,j]) then
          begin k1[j]:=k1[last]+t[last,j];truoc[j]:=last;end;
      min:=1500000000;
      for j:=2 to n do if chua[j] and (k1[j]<min) then
          begin min:=k1[j];last:=j;end;
      chua[last]:=false;inc(dem);
      end;
max:=k1[1];for j:=2 to n do if k1[j]>max then max:=k1[j];
end;
procedure ijk1(var truoc1:dd);
var
   dem,last,j:byte;min:longint;
begin
for j:=1 to n do begin chua[j]:=true;k2[j]:=1000000000;end;
chua[1]:=false;k2[1]:=0;last:=1;
dem:=1;
while dem<n do
      begin
      for j:=2 to n do
          if chua[j] and (t[last,j]<1000000000)and(a1^[last,j]=1)
             and (k2[j]>k2[last]+t[last,j]) then
                 begin k2[j]:=k2[last]+t[last,j];truoc1[j]:=last;end;
      min:=1500000000;
      for j:=2 to n do if chua[j] and (k2[j]<min) then
          begin min:=k2[j];last:=j;end;
      chua[last]:=false;inc(dem);
      end;
max1:=k2[1];for j:=2 to n do if k2[j]>max1 then max1:=k2[j];
end;
procedure mtk;
var
   p,q,r:byte;d:dd;
begin
fillchar(a^,sizeof(a^),0);
for r:=2 to n do
    begin
    for q:=2 to n do
        begin
        d[0]:=1;d[d[0]]:=q;p:=q;
        while p<>1 do begin p:=truoc[p];inc(d[0]);d[d[0]]:=p;end;
        for p:=1 to d[0]-1 do
            begin
            a^[d[p],d[p+1]]:=1;a^[d[p+1],d[p]]:=1;
            end;
        end;
    end;
end;
procedure mtk1;
var
   p,q,r:byte;d:dd;
begin
fillchar(a1^,sizeof(a1^),0);
for r:=1 to n-1 do
    begin
    a1^[cbt[r,1],cbt[r,2]]:=1;a1^[cbt[r,2],cbt[r,1]]:=1;
    end;
end;
procedure prim;
var
   min:longint;
   nea:array[1..100] of byte;
   dist:array[1..100] of longint;
   chon,i,j,sc:byte;
begin
fillchar(chua,sizeof(chua),true);sc:=0;
for i:=1 to n do begin dist[i]:=2000000000;nea[i]:=1;end;
chua[1]:=false;dist[1]:=0;chon:=1;
while sc<n-1 do
      begin
      for i:=2 to n do
          if chua[i] and(a^[chon,i]=1)and(dist[i]>t[chon,i]) then
             begin dist[i]:=t[chon,i];nea[i]:=chon;end;
      min:=2100000000;
      for i:=2 to n do if chua[i] and (dist[i]<min) then
          begin min:=dist[i];chon:=i;end;
      chua[chon]:=false;
      inc(sc);cbt[sc,1]:=chon;cbt[sc,2]:=nea[chon];
      end;
end;
procedure xet1;
var
   h:byte;
begin
ijk(truoc);mtk;
prim;mtk1;ijk1(truoc);
end;
BEGIN
sinh;
new(a1);new(a);
ss:=0;
assign(g,tam);rewrite(g);
for c1:='0' to '9' do
for c2:='0' to '9' do
for c3:='0' to '9' do
begin
nhap;xet1;
writeln(g,max:10,max1:10);
if max1=max then inc(ss);
end;
writeln(g,ss);
close(g);
dispose(a1);dispose(a);
END.