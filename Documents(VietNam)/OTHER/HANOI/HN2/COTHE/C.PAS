uses crt;
const
     fi='chess.in';
     fo='chess.ou';
     fhs='chess.out';
var
   f:text;
   test:char;s,st:word;
   t1,t2:array[1..4,1..4] of byte;
   x,y,z,t,tg:byte;
procedure nhap;
var
   i,j:byte;c:char;code:integer;
begin
assign(f,fi+test);reset(f);
for i:=1 to 4 do
    begin
    for j:=1 to 4 do begin read(f,c);val(c,t1[i,j],code);end;
    readln(f);
    end;
for i:=1 to 4 do
    begin
    for j:=1 to 4 do begin read(f,c);val(c,t2[i,j],code);end;
    readln(f);
    end;
close(f);
assign(f,fo+test);reset(f);
readln(f,st);
close(f);
end;
function cd(x,y,z,t:byte):boolean;
begin
cd:=(x=z)and(abs(y-t)=1);
end;
function cc(x,y,z,t:byte):boolean;
begin
cc:=(y=t)and(abs(x-z)=1);
end;
function bang:boolean;
var
   u,v:byte;
begin
bang:=true;
for u:=1 to 4 do
for v:=1 to 4 do if t1[u,v]<>t2[u,v] then
    begin bang:=false;exit;end;
end;
procedure cham;
var
   i:word;
begin
assign(f,fhs);reset(f);
readln(f,s);
if s>0 then
   for i:=1 to s do
       begin
       readln(f,x,y,z,t);
       if (x<1)or(y<1)or(z<1)or(t<1)or(x>4)or(y>4)or(z>4)or(t>4) then
          begin
          writeln('        Ket qua sai!!!');
          writeln('        Chi so dong cot khong dung!!!');
          close(f);exit;
          end;
       if not(cd(x,y,z,t)) and not(cc(x,y,z,t)) then
          begin
          writeln('        Ket qua sai!!!');
          writeln('        Khong cung dong/cot!!!');
          close(f);exit;
          end;
       if (t1[x,y]<>1)or(t1[z,t]<>0) then
          begin
          writeln('        Ket qua sai tu buoc thu ',i);
          if t1[x,y]<>1 then
          writeln('        Khong di chuyen quan co');
          if t1[z,t]<>0 then
          writeln('        Khong di chuyen vao o trong');
          close(f);exit;
          end;
       t1[x,y]:=0;t1[z,t]:=1;
       end;
close(f);
if bang then
   begin
   writeln('        Ket qua bien doi dung');
   writeln('        So phep bien doi cua HS: ',s);
   writeln('        So phep bien doi cua DA: ',st);
   end
else
   begin
   writeln('        Ket qua bien doi sai');
   end;
end;
BEGIN
clrscr;
writeln;
write('         CHAM TEST THU ');test:=readkey;writeln(test);
writeln;
nhap;cham;readln;
END.
