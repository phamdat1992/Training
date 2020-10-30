{$R+}
uses crt;
const
     fhs='rot.out';
var
   fi,fo,kqhs,test:string;
   muc:array[0..20] of integer;
   so,kq,t1,t2,t3,s1,s2,s3,n:integer;
   r,rhs:word;f:text;
procedure nhap;
var
   i:integer;
begin
fillchar(muc,sizeof(muc),0);
assign(f,fi);reset(f);
readln(f,n);
for i:=1 to n do read(f,muc[i]);
close(f);
assign(f,fo);reset(f);
readln(f,kq);
readln(f,r);
close(f);
end;
function dung12:boolean;
var
   i:integer;
begin
if (s1<0)or(s2<0) then
    begin
    dung12:=false;exit;
    end;
for i:=0 to n do if s1=muc[i] then
    begin
    dung12:=true;exit;
    end;
for i:=0 to n do if s2=muc[i] then
    begin
    dung12:=true;exit;
    end;
dung12:=false;
end;
function dung13:boolean;
var
   i:integer;
begin
if s1<0 then
    begin
    dung13:=false;exit;
    end;
for i:=0 to n do if s1=muc[i] then
    begin
    dung13:=true;exit;
    end;
dung13:=false;
end;
function dung23:boolean;
var
   i:integer;
begin
if s2<0 then
    begin
    dung23:=false;exit;
    end;
for i:=0 to n do if s2=muc[i] then
    begin
    dung23:=true;exit;
    end;
dung23:=false;
end;
function dung32:boolean;
var
   i:integer;
begin
if s3<0 then
    begin
    dung32:=false;exit;
    end;
if s3=0 then
    begin
    dung32:=true;exit;
    end;
for i:=0 to n do if s2=muc[i] then
    begin
    dung32:=true;exit;
    end;
dung32:=false;
end;
function dung31:boolean;
var
   i:integer;
begin
if s3<0 then
    begin
    dung31:=false;exit;
    end;
if s3=0 then
    begin
    dung31:=true;exit;
    end;
for i:=0 to n do if s1=muc[i] then
    begin
    dung31:=true;exit;
    end;
dung31:=false;
end;
procedure cham;
var
   x,y,z:integer;
begin
s1:=100;s2:=0;s3:=0;
assign(f,fhs);reset(f);
readln(f,kqhs);
if ((kq=1)and(kqhs<>'CO'))or((kq=0)and(kqhs<>'KHONG')) then
   begin
   writeln('Ket qua sai!!!');
   writeln('Diem test ',test,' bang 0');
   exit;
   end;
if kq=1 then
begin
readln(f,rhs);
while not(eof(f)) do
      begin
      readln(f,x,y,z);
      if (x=1)and(y=2) then
         begin
         s1:=s1-z;s2:=s2+z;
         if not(dung12) then
            begin
            writeln('Rot khong dung quy dinh!!!');
            writeln('Diem test ',test,' bang 0');
            exit;
            end;
         end;
      if (x=2)and(y=1) then
         begin
         s1:=s1+z;s2:=s2-z;
         if not(dung12) then
            begin
            writeln('Rot khong dung quy dinh!!!');
            writeln('Diem test ',test,' bang 0');
            exit;
            end;
         end;
      if (x=1)and(y=3) then
         begin
         s1:=s1-z;s3:=s3+z;
         if not(dung13) then
            begin
            writeln('Rot khong dung quy dinh!!!');
            writeln('Diem test ',test,' bang 0');
            exit;
            end;
         end;
      if (x=2)and(y=3) then
         begin
         s2:=s2-z;s3:=s3+z;
         if not(dung23) then
            begin
            writeln('Rot khong dung quy dinh!!!');
            writeln('Diem test ',test,' bang 0');
            exit;
            end;
         end;
      if (x=3)and(y=1) then
         begin
         s1:=s1+z;s3:=s3-z;
         if not(dung31) then
            begin
            writeln('Rot khong dung quy dinh!!!');
            writeln('Diem test ',test,' bang 0');
            exit;
            end;
         end;
      if (x=3)and(y=2) then
         begin
         s2:=s2+z;s3:=s3-z;
         if not(dung32) then
            begin
            writeln('Rot khong dung quy dinh!!!');
            writeln('Diem test ',test,' bang 0');
            exit;
            end;
         end;
      end;
if s3<>1 then
   begin
   writeln('Sau khi rot, binh 3 khong chua 1 don vi nuoc!!!');
   writeln('Diem test ',test,' bang 0');
   exit;
   end;
close(f);
writeln('Qua trinh rot dung!!!');
writeln('So lan rot cua hoc sinh: ',rhs);
writeln('So lan rot it nhat: ',r);
writeln('Diem test ',test,' bang ',100-rhs+r);
exit;
end;
writeln('Ket qua dung!!!');
writeln('Khong rot duoc!!!');
end;
BEGIN
clrscr;
write('Cham test thu ');readln(test);
fi:='rot.in'+test;
fo:='rot.ou'+test;
nhap;
cham;
readln;
END.