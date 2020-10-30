uses crt;
const
     fi='robot.in1';
     fhs='robot.ou1';
     bb='rb.';
var
   f,g:text;t:char;ten:string;
   a:array[-101..100,-101..100] of byte;
   s,min:longint;
   tx,ty,px,py:longint;
procedure nhap;
var
   c:char;k,i,x,y:longint;
begin
assign(f,fi+t);reset(f);
fillchar(a,sizeof(a),0);
readln(f,x,y);
while not(seekeof(f)) do
      begin
      read(f,c);readln(f,k);
      case c of
      'U':
          for i:=1 to k do
          begin
          a[x,y]:=a[x,y] or 8;a[x-1,y]:=a[x-1,y] or 2;
          inc(y);
          end;
      'D':
          for i:=1 to k do
          begin
          a[x,y-1]:=a[x,y-1] or 8;a[x-1,y-1]:=a[x-1,y-1] or 2;
          dec(y);
          end;
      'L':
          for i:=1 to k do
          begin
          a[x-1,y]:=a[x-1,y] or 4;a[x-1,y-1]:=a[x-1,y-1] or 1;
          dec(x);
          end;
      'R':
          for i:=1 to k do
          begin
          a[x,y]:=a[x,y] or 4;a[x,y-1]:=a[x,y-1] or 1;
          inc(x);
          end;
      end;
      end;
close(f);
end;
procedure cham;
var
   i,j:longint;
begin
assign(f,fhs);reset(f);
readln(f,tx,ty);readln(f,px,py);
close(f);
if (abs(tx)>100)or(abs(ty)>100)or(abs(px)>100)or(abs(py)>100) then
   begin
   writeln(g,'    Ket qua sai');
   writeln(g,'    Chu nhat nam ngoai pham vi cho phep');
   exit;
   end;
if px=tx+1 then
   begin
   if py=ty+1 then
      begin
      if a[tx,ty]=15 then writeln(g,'    Ket qua dung, DT = 1')
      else writeln(g,'    Ket qua sai');
      exit;
      end;
   if a[tx,ty]<>14 then
      begin
      writeln(g,'    Ket qua sai');
      exit;
      end;
   if a[tx,py-1]<>11 then
      begin
      writeln(g,'    Ket qua sai');
      exit;
      end;
   if py>ty+2 then for i:=ty+1 to py-2 do if a[tx,i]<>10 then
      begin
      writeln(g,'    Ket qua sai TQ');
      exit;
      end;
   writeln(g,'    Ket qua dung: DT = ',py-ty);
   end;
if py=ty+1 then
   begin
   if px=tx+1 then
      begin
      if a[tx,ty]=15 then writeln(g,'    Ket qua dung, DT = 1')
      else writeln(g,'    Ket qua sai');
      exit;
      end;
   if a[tx,ty]<>13 then
      begin
      writeln(g,'    Ket qua sai');
      exit;
      end;
   if a[px-1,ty]<>7 then
      begin
      writeln(g,'    Ket qua sai');
      exit;
      end;
   if px>tx+2 then for i:=tx+1 to px-2 do if a[i,ty]<>5 then
      begin
      writeln(g,'    Ket qua sai');
      exit;
      end;
   writeln(g,'    Ket qua dung: DT = ',px-tx);
   exit;
   end;
if a[tx,ty]<>12 then
   begin
   writeln(g,'    Ket qua sai');
   writeln(g,'    Goc trai duoi khong dung');
   exit;
   end;
if a[tx,py-1]<>9 then
   begin
   writeln(g,'    Ket qua sai');
   writeln(g,'    Goc trai tren khong dung');
   exit;
   end;
if a[px-1,py-1]<>3 then
   begin
   writeln(g,'    Ket qua sai');
   writeln(g,'    Goc phai tren khong dung');
   exit;
   end;
if a[px-1,ty]<>6 then
   begin
   writeln(g,'    Ket qua sai');
   writeln(g,'    Goc phai duoi khong dung');
   exit;
   end;
if px>tx+2 then for i:=tx+1 to px-2 do
begin
if a[i,ty]<>4 then
   begin
   writeln(g,'    Ket qua sai');
   writeln(g,'    Canh duoi khong dung');
   exit;
   end;
if a[i,py-1]<>1 then
   begin
   writeln(g,'    Ket qua sai');
   writeln(g,'    Canh tren khong dung');
   exit;
   end;
end;
if py>ty+2 then for i:=ty+1 to py-2 do
begin
if a[tx,i]<>8 then
   begin
   writeln(g,'    Ket qua sai');
   writeln(g,'    Canh trai khong dung');
   exit;
   end;
if a[px-1,i]<>2 then
   begin
   writeln(g,'    Ket qua sai');
   writeln(g,'    Canh phai khong dung');
   exit;
   end;
end;
if (px>tx+2)and(py>ty+2) then
for i:=tx+1 to px-2 do
for j:=ty+1 to py-2 do if a[i,j]<>0 then
   begin
   writeln(g,'    Ket qua sai');
   writeln(g,'    Cac o giua khong dung');
   exit;
   end;
writeln(g,'    Ket qua dung: DT = ',(px-tx)*(py-ty));
end;
BEGIN
clrscr;
writeln;
write('CHAM TEST THU ');t:=readkey;writeln(t);
writeln;
write('Bai cua HS ');readln(ten);
nhap;
assign(g,bb+t);append(g);
writeln(g,'Cham bai HS ',ten,' test thu ',t);
cham;
writeln(g,'     **********');
close(g);
END.
