uses crt;
var
   mang1:array[1..100,1..100] of byte;
   tp:array[1..100] of byte;
   gt:array[1..100,1..100] of word;
   n,k,c,chon1,chon2,dem:byte;
   kc,d:word;
   them,test,x,y:byte;
   f,g:text;
   cphs,cp,ss:word;
   s,ten:string;
   ok1,ok2:boolean;
procedure nhapdl;
var
   f:text;
   i,j,x,y:byte;
begin
fillchar(mang1,sizeof(mang1),0);
assign(f,'mgt'+s+'.dat');reset(f);
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
procedure cham;
begin
{$I-}
assign(g,'gp.dat');reset(g);{$I+}
if IOresult<>0 then
   begin
   writeln('Khong co file output!!!');
   writeln('Diem test ',test,' : 0 diem');close(f);exit;
   end;
assign(f,'gp'+s+'.dat');reset(f);
readln(g,cphs);
readln(f,cp);
if cphs<>cp then ok1:=false;
   ss:=0;
   while not(eof(g)) do
      begin
      readln(g,x,y);ss:=ss+gt[x,y];
      mang1[x,y]:=1;mang1[y,x]:=1;
      end;
writeln('Chi phi cua hoc sinh: ',cphs);
writeln('Chi phi thuc: ',ss );
lt;
if c>1 then ok2:=false;
{OK2 ghi nhan cac doan duong xay them bao dam lien thong
co dung khong}
if not(ok2) then writeln('Diem test ',test,' : 0.0');
if not(ok1)and (ok2) then writeln('Diem test ',test,' : 1.0');
if ok1 and ok2 then writeln('Diem test ',test,' : 2.0');
close(f);close(g);
end;
BEGIN
ok1:=true;ok2:=true;
clrscr;
write('Test thu: ');readln(test);
str(test,s);
nhapdl;cham;readln;
END.