uses crt;
const
     fhs='cut.out';
var
   fi,fo,test:string;
   s,m,n,shv,shvhs:word;
   hv:array[1..100] of word;
   f:text;
procedure doc;
begin
assign(f,fi);reset(f);
readln(f,m,n);
close(f);
assign(f,fo);reset(f);
readln(f,shv);
close(f);
end;
procedure cham;
var
   i,j:word;
begin
fillchar(hv,sizeof(hv),0);
assign(f,fhs);reset(f);
readln(f,shvhs);
if shvhs<>shv then
   begin
   writeln('So hinh vuong cua HS: ',shvhs);
   writeln('So hinh vuong it nhat: ',shv);
   close(f);exit;
   end;
for i:=1 to shv do begin read(f,j);inc(hv[j]);end;
s:=0;
for i:=1 to 100 do if hv[i]>0 then s:=s+hv[i]*i*i;
if s<>m*n then
   begin
   writeln('Tong dien tich cac hinh vuong ghep lai khong dung!!!');
   writeln('Tong DT cua HS: ',s,' - DT hinh chu nhat: ',m*n);
   close(f);exit;
   end;
writeln('Ket qua dung!!!');
close(f);
end;
BEGIN
clrscr;
write('Cham test thu: ');readln(test);
fi:='cut'+test+'.inp';
fo:='cut'+test+'.out';
doc;cham;readln;
END.