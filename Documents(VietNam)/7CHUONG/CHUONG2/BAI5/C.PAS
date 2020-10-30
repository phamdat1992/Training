{$R+}
uses crt;
const
     fohs='tb.out';
var
   f:text;
   n,std,stdhs:byte;
   ok1,ok2:boolean;
   fi,fo,ten,test:string;
   tbc,tbm:array[1..255] of byte;
procedure doc;
var
   i,x,y,demhs:byte;
begin
ok1:=true;
fillchar(tbc,sizeof(tbc),0);
assign(f,fi);reset(f);
readln(f,n);
for i:=1 to n do
    begin
    read(f,tbc[i]);
    end;
close(f);
tbm:=tbc;
{$I-}assign(f,fohs);reset(f);
if IOResult<>0 then
   begin
   writeln('Khong co file out hoac ten file sai');
   readln;halt;
   end;{$I+}
readln(f,stdhs);
demhs:=0;
while not(eof(f)) do
    begin
    inc(demhs);
    readln(f,x,y);
    if x=y then
       begin
       writeln('Nguoi ke tiep trung voi nguoi chon NKT!!!');
       ok1:=false;
       exit;
       end;
    tbm[x]:=y;
    end;
if demhs<>stdhs then
   begin
   writeln('So luong thay doi thuc su khong bang so luong thong bao!!!');
   ok1:=false;
   exit;
   end;
close(f);
assign(f,fo);reset(f);
readln(f,std);
close(f);
end;
procedure xet;
var
   i,dem:byte;con:boolean;
   chua:array[1..255] of boolean;
begin
fillchar(chua,sizeof(chua),true);
i:=1;dem:=0;
repeat
con:=false;
if chua[tbm[i]] then
   begin i:=tbm[i];chua[i]:=false;inc(dem);con:=true;end;
until not(con);
writeln('So nguoi duoc thong bao: ',dem);
if dem=n then ok1:=true else ok1:=false;
end;
procedure cham;
begin
if not(ok1) then
   begin
   writeln('Khong lap duoc day chuyen thong bao tot!!!');
   writeln('Diem test ',test,' = 0');exit;
   end;
if ok1 then
   begin
   writeln('Tao duoc day chuyen thong bao tot!!!');
   if std=stdhs then writeln('Diem test ',test,' = 3')
   else writeln('Diem test ',test,' = 2')
   end;
end;
BEGIN
clrscr;
write('Cham bai hoc sinh: ');readln(ten);
write('Test thu ');readln(test);
fi:='tb'+test+'.inp';
fo:='tb'+test+'.out';
doc;
if ok1 then xet;
cham;readln;
END.