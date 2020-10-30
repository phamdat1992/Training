uses crt;
const
     fhs='output.txt';
var
   n,s,shs:word;
   fi,fo:string;test:char;
   a:array[1..1000] of word;
   f:text;
procedure nhap;
var
   i:word;
begin
assign(f,fi);reset(f);
readln(f,n);
for i:=1 to n do readln(f,a[i]);
close(f);
assign(f,fo);reset(f);
readln(f,s);
close(f);
end;
function saics(i,j:word):boolean;
var
	s1,s2:boolean;
begin
s1:=(i<1)or(i>n);
s2:=(j<1)or(j>n);
saics:=s1 or s2;end;
procedure cham;
var
   i,j,k,t:word;
begin
assign(f,fhs);reset(f);
readln(f,shs);
k:=0;
while not(seekeof(f)) do
      begin
      inc(k);readln(f,i,j);
      if saics(i,j) then
         begin
         writeln('          Chi so so hang sai!!!');
         writeln(i:10,j:10);
         writeln('          Ket qua sai!!!');exit;
         end;
      t:=a[i];a[i]:=a[j];a[j]:=t;
      end;
close(f);
if k<>shs then
   begin
   writeln('          So lan trao doi thong bao: ',shs);
   writeln('          So lan trao doi thuc su: ',k);
   writeln('          Ket qua sai!!!');exit;
   end;
for i:=1 to n-1 do if a[i]>a[i+1] then
    begin
    writeln('          Chua sap xep dung yeu cau!!!');
    writeln('          Ket qua sai!!!');exit;
    end;
writeln('          Ket qua dung!!!');
writeln('          So lan trao doi cua HS: ',shs);
writeln('          So lan trao doi cua DA: ',s);
end;
BEGIN
clrscr;
writeln;
write('          CHAM TEST THU ');test:=readkey;writeln(test);
writeln;
fi:='input.tx'+test;
fo:='output.tx'+test;
nhap;cham;readln;
END.