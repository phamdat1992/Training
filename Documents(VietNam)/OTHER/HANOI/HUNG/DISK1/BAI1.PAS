uses crt;
const
fi='ki.inp';
var
a:array[1..100,1..100]of integer;
tr,d:array[1..100]of integer;
s,t,n:integer;

procedure nhap;
var
   i,j:integer;
    f:text;
 begin
     assign(f,fi);
     reset(f);
writeln('Ma tran trong so:');
readln(f,n);
writeln(n:3);
for i:=1 to n do
 begin
   for j:=1 to n do
     begin
        read(f,a[i,j]);
        write(a[i,j]:3);
     end;
     writeln;
 end;
readln(f,s,t);
write(s:3);
writeln(t:3);
for i:=1 to n do
for j:=1 to n do
if a[i,j]=0 then
a[i,j]:=1000;
close(f);
end;


procedure inkq;
var
j:integer;
begin
if d[t]>=1000 then
writeln('Khong co duong di!')
Else
begin
write('Duong di: ');
j:=t;
while j<>s do
  begin
    write(j,'<=');
    j:=tr[j];
  end;
end;
write(s);
writeln;
writeln('Do dai duong di ngan nhat:',d[t]);
writeln('Ket thuc!')

end;

procedure xl;
var
k,i,j:integer;
begin
d[s]:=0;
tr[s]:=s;
for i:=1 to n do
begin
d[i]:=a[s,i];
tr[i]:=s;
end;
for k:=1 to n-2 do
for i:=1 to n do
if i<>s then
for j:=1 to n do
if d[i]>d[j]+a[j,i] then
  begin
    d[i]:=d[j]+a[j,i];
    tr[i]:=j;
  end;
end;

begin
clrscr;
 nhap;
 xl;
 inkq;
readln;
end.

5
0 1 0 0 3
0 0 3 3 8
0 0 0 0 -5
0 0 2 0 0
0 0 0 4 0
1 4







