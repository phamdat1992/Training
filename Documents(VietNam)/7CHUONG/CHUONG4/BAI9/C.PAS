uses crt;
const
     fhs='vuon.out';
var
   max,maxhs,xd,xt,yd,yt,n:longint;
   fi,fo:string;test:char;
   cay:array[1..600,1..2] of longint;
   f:text;
procedure init;
var
   i:longint;
begin
assign(f,fi);reset(f);
readln(f,n);
for i:=1 to n do readln(f,cay[i,1],cay[i,2]);
close(f);
assign(f,fo);reset(f);
readln(f,max);
close(f);
end;
procedure cham;
var
   i:longint;
begin
assign(f,fhs);reset(f);
readln(f,maxhs);
if maxhs<=0 then
   begin
   writeln('             Sai: dien tich <=0!!!');
   close(f);exit;
   end;
readln(f,xd,yd);
if (xd*yd<0)or(xd>1000)or(yd>1000) then
   begin
   writeln('             Sai: Dinh hinh chu nhat nam ngoai vuon!!!');
   close(f);exit;
   end;
readln(f,xt,yt);
if (xt*yt<0)or(xt>1000)or(yt>1000) then
   begin
   writeln('             Sai: Dinh hinh chu nhat nam ngoai vuon!!!');
   close(f);exit;
   end;
close(f);
if (xt<=xd)or(yt<=yd) then
   begin
   writeln('             Xac dinh hinh chu nhat sai:');
   writeln('             Dinh trai duoi: ',xd:5,yd:5);
   writeln('             Dinh phai tren: ',xt:5,yt:5);
   exit;
   end;
if (xt-xd)*(yt-yd)<>maxhs then
   begin
   writeln('             Sai: DT hinh chu nhat khong phu hop hai dinh:');
   writeln('             DT hinh chu nhat thong bao: ',maxhs);
   writeln('             DT hinh chu nhat tinh theo cac dinh: ',(xt-xd)*(yt-yd));
   exit;
   end;
for i:=1 to n do
if (cay[i,1]>xd)and(cay[i,1]<xt)and(cay[i,2]>yd)and(cay[i,2]<yt) then
   begin
   writeln('             Sai: Trong hinh chu nhat co cay thu ',i);
   exit;
   end;
writeln('             Ket qua hop ly!!!');
writeln('             DT cua hoc sinh: ',maxhs);
writeln('             DT cua dap an: ',max);
end;
BEGIN
clrscr;
writeln;
write('             CHAM TEST THU ');test:=readkey;writeln(test);
writeln;
fi:='vuon.in'+test;
fo:='vuon.out'+test;
init;cham;readln;
END.
