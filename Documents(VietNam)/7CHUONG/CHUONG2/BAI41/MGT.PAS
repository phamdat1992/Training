{$R+}
const
     fi='mgt.dat';
     fo='gp.dat';
var
   c:array[1..120,1..120] of longint;
   {c ghi tinh trang duong da lam va gia thanh xay dung cac doan duong}
   cay:array[1..2,1..120] of longint;
   {Ghi nhan cac canh thuoc cay bao trum}
   n,k,dem:longint;
   kc,d:longint;g:text;
procedure nhapdl;
{Doc du lieu tu file va xay dung mang trong so C the hien dong thoi
ca mang giao thong va gia thanh xay dung cac doan duong khac}
var
   f:text;
   i,j,x,y,z:longint;
begin
fillchar(c,sizeof(c),1);
assign(f,fi);reset(f);
readln(f,N,K);
for i:=1 to k do
    begin
    readln(f,x,y);
    c[x,y]:=0;c[y,x]:=0;
    end;
for i:=1 to n do c[i,i]:=0;
for i:=1 to n do
for j:=1 to n do
    begin
    read(f,z);
    if (i<j)and(c[i,j]=1) then begin c[i,j]:=z;c[j,i]:=c[i,j];end;
    end;
close(f);
end;
procedure cbtnn;
var
   j,chon:longint;min:longint;
   dist:array[1..120] of longint;
   gan:array[1..120] of longint;
   gn:array[1..120] of longint;
begin
dem:=0;d:=0;
fillchar(gn,sizeof(gn),0);gn[1]:=1;
for j:=2 to n do begin dist[j]:=c[1,j];gan[j]:=1;end;
while dem<n-1 do
      begin
      min:=maxlongint;
      for j:=2 to n do
          begin
          if (gn[j]=0)and(dist[j]<min) then
             begin
             chon:=j;min:=dist[j];
             end;
          end;
      gn[chon]:=1;inc(dem);cay[1,dem]:=chon;
      cay[2,dem]:=gan[chon];
      d:=d+dist[chon];
      for j:=2 to n do
          if (gn[j]=0)and(dist[j]>c[chon,j]) then
             begin dist[j]:=c[chon,j];gan[j]:=chon;end;
      end;
end;
procedure xuly;
{Giai quyet bai toan}
var
   f:text;
   r,s:longint;
begin
assign(f,fo);rewrite(f);
cbtnn;
if d=0 then writeln(f,0)
else
    begin
    writeln(f,d);
    for r:=1 to dem do
    if c[cay[1,r],cay[2,r]]>0 then writeln(f,cay[1,r]:5,cay[2,r]:5);
    end;
close(f);
end;
BEGIN
nhapdl;xuly;
END.