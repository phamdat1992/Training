{$R+}
const
     fi='mgt6.dat';
     fo='gp.dat';
type
    ts=array[1..100,1..100] of word;
var
   mang1,dau1,dau2:array[1..100,1..100] of byte;
   {Mang1 ghi tinh trang duong da lam}
   mang2:^ts;
   {Mang2 la mang trong so cua do thi co cac dinh la cac TPLT,
   trong so mot canh bang khoang cach nho nhat giua hai dinh, moi
   dinh thuoc mot thanh phan}
   {Cac mang Dau1,Dau2 ghi nhan khoang cach tren dat duoc tai dinh nao}
   tp:array[1..100] of byte;
   {Tp ghi nhan TPLT cua cac nut giao thong}
   {gn ghi nhan dinh cua do thi co mang trong so Mang2 da duoc mo rong toi
   khi xay dung cay bao trum chua}
   gt:array[1..100,1..100] of word;
   {Gia thanh xay dung cac doan duong}
   cay:array[1..2,1..100] of byte;
   {Ghi nhan cac canh thuoc cay bao trum}
   n,k,c,chon1,chon2,dem:byte;
   kc,d:word;g:text;
procedure nhapdl;
{Doc du lieu tu file va xay dung ma tran ke cua do thi
the hien mang giao thong}
var
   f:text;
   i,j,x,y:byte;
begin
fillchar(mang1,sizeof(mang1),0);
assign(f,fi);reset(f);
readln(f,N,K);
for i:=1 to k do
    begin
    readln(f,x,y);
    mang1[x,y]:=1;mang1[y,x]:=1;
    end;
for i:=1 to n do
for j:=1 to n do read(f,gt[i,j]);
close(f);
end;
procedure di(u:byte);
var
   i:byte;
begin
if tp[u]=0 then
   begin
   tp[u]:=c;
   for i:=1 to n do if mang1[u,i]=1 then di(i);
   end;
end;
procedure LT;
{Xac dinh xem mang giao thong co bao nhieu thanh phan lien thong}
var
   x1:byte;
begin
fillchar(tp,sizeof(tp),0);
c:=0;
for x1:=1 to n do if tp[x1]=0 then
    begin
    inc(c);di(x1);
    end;
end;
procedure tinh(z1,t1:byte;var chon1,chon2:byte;var kc:word);
{Tinh khoang cach ngan nhat KC giua thanh phan lien thong thu z1 va
thanh phan lien thong thu t1, chon1 va chon2 la hai dau mut cua canh
ngan nhat noi TPLT z1 va TPLT t1}
var
   p,q:byte;
begin
kc:=50000;
for p:=1 to N do
for q:=1 to N do
    if (gt[p,q]<kc)and(tp[p]=z1)and(tp[q]=t1) then
          begin
          kc:=gt[p,q];chon1:=p;chon2:=q;
          end;
end;
procedure cbtnn;
{Dung thuat toan nguoi lang gieng gan nhat xay dung cay bao trum
ngan nhat cua do thi co cac dinh la cac thanh phan lien thong va
khoang cach giua hai thanh phan lien thong da duoc tinh nho thu
tuc TINH}
var
   j,chon:byte;min1:word;
   dist:array[1..100] of word;
   gan:array[1..100] of byte;
   gn:array[1..100] of byte;
begin
dem:=0;d:=0;
fillchar(gn,sizeof(gn),0);gn[1]:=1;
for j:=2 to c do begin dist[j]:=mang2^[1,j];gan[j]:=1;end;
while dem<c-1 do
      begin
      min1:=50000;
      for j:=2 to c do
          begin
          if (gn[j]=0)and(dist[j]<min1) then
             begin
             chon:=j;min1:=dist[j];
             end;
          end;
      gn[chon]:=1;inc(dem);cay[1,dem]:=dau1[chon,gan[chon]];
      cay[2,dem]:=dau2[chon,gan[chon]];
      d:=d+dist[chon];
      for j:=2 to c do
          if (gn[j]=0)and(dist[j]>mang2^[chon,j]) then
             begin dist[j]:=mang2^[chon,j];gan[j]:=chon;end;
      end;
end;
procedure xuly;
{Giai quyet bai toan}
var
   f:text;
   r,s:byte;
begin
assign(f,fo);rewrite(f);
new(mang2);
fillchar(mang2^,sizeof(mang2^),0);
fillchar(dau2,sizeof(dau2),0);
fillchar(dau1,sizeof(dau1),0);
if c=1 then writeln(f,0)
else
    begin
    for r:=1 to c-1 do
    for s:=r+1 to c do
        begin
        tinh(r,s,chon1,chon2,kc);
        mang2^[r,s]:=kc;mang2^[s,r]:=mang2^[r,s];
        dau1[r,s]:=chon1;dau2[r,s]:=chon2;
        dau1[s,r]:=dau1[r,s];dau2[s,r]:=dau2[r,s];
        end;
    cbtnn;
    writeln(f,d);
    for r:=1 to dem do
        writeln(f,cay[1,r]:5,cay[2,r]:5);
    end;
close(f);dispose(mang2);
end;
BEGIN
nhapdl;LT;xuly;
END.