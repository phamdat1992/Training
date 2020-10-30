{$R+}
uses crt;
const
     fhs='piton.out';
var
   n,m:integer;
   fi,fo,test,s:string;
   a:array[1..50] of string;
   f:text;kt,kths,b,bhs:byte;
procedure nhap;
var
   i:integer;
begin
assign(f,fi);reset(f);
readln(f,n,m);
close(f);
assign(f,fo);reset(f);
readln(f,kt);
if kt>0 then readln(f,b)
else for i:=1 to n do readln(f,a[i]);
close(f);
end;
procedure cham;
var
   i:byte;
begin
assign(f,fhs);reset(f);
readln(f,kths);
if kths<>kt then
   begin
   writeln('            Ket luan ve ket thuc sai!!!!');
   close(f);
   exit;
   end;
if kt>0 then
   begin
   readln(f,bhs);
   if b<>bhs then
      begin
      writeln('            So buoc ket thuc sai!!!!');
      close(f);
      exit;
      end;
   end
else
   begin
   for i:=1 to n do
       begin
       readln(f,s);
       if s<>a[i] then
          begin
          writeln('            Dong thu ',i,' cua luoi sai!!!!');
          close(f);
          exit;
          end;
       end;
   end;
close(f);
writeln('            Ket qua dung!!!');
end;
BEGIN
clrscr;
writeln;
write('       CHAM TEST THU ');readln(test);
fi:='piton.in'+test;
fo:='piton.ou'+test;
nhap;cham;readln;
END.