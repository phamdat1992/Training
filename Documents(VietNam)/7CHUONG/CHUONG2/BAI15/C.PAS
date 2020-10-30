uses crt;
const
     fhs='td.out';
     fo='td.ou';
var
   f,g:text;c:char;
   x,y,xhs,yhs,m,mhs:longint;
procedure cham;
begin
assign(f,fhs);reset(f);
assign(g,fo+c);reset(g);
readln(f,mhs);readln(g,m);
if m<>mhs then
   begin
   writeln('        Ket qua sai!!!');
   writeln('        Ket luan sai ve tinh mau thuan');
   writeln('        Diem test ',c,' bang 0');
   close(f);close(g);exit;
   end;
if m=0 then
   begin
   while not(seekeof(g)) do
         begin
         readln(f,xhs,yhs);readln(g,x,y);
         if (x<>xhs)or(y<>yhs) then
            begin
            writeln('        Ket qua sai!!!');
            writeln('        Thong bao sai ve ty gia');
            writeln('        Diem test ',c,' bang 0');
            close(f);close(g);exit;
            end;
         end;
   end;
close(f);close(g);
writeln('        Ket qua dung!!!');
writeln('        Diem test ',c,' bang 1');
end;
BEGIN
clrscr;
writeln;
write('          CHAM TEST THU ');c:=readkey;writeln(c);
writeln;
cham;readln;
END.