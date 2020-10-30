{$R+}
uses crt;
const
     fhs='day.out';
     m:array['1'..'5'] of integer=(8,10,11,12,13);
var
   fo:string;test:char;f:text;
   n:integer;s,shs,c,chs:longint;
   bhs,b:array[1..50] of integer;
procedure nhap;
var
   i:integer;
begin
assign(f,fo);reset(f);
readln(f,s);
for i:=1 to 2*n+1 do read(f,b[i]);readln(f);
readln(f,c);
close(f);
end;
function bang:boolean;
var
   x:integer;
begin
for x:=2 to 2*n do if bhs[x]<>b[x] then begin bang:=false;exit;end;
bang:=true;
end;
procedure cham;
var
   i:integer;
begin
assign(f,fhs);reset(f);
readln(f,shs);
if s<>shs then
   begin
   writeln('      So luong day sai: cua HS: ',shs,' - Dap an: ',s);
   end;
for i:=1 to 2*n+1 do read(f,bhs[i]);readln(f);
if not(bang) then
   begin
   writeln('      Day sai!!!');
   end;
readln(f,chs);
if c<>chs then
   begin
   writeln('      So hieu sai!!!');
   end;
close(f);
end;
begin
clrscr;writeln;
write('        CHAM TEST THU ');readln(test);
fo:='day.ou'+test;n:=m[test];
nhap;cham;readln;
end.