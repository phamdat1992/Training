{$r+}
program test ;
uses crt ;
const
     fi:string ='km.in';
     fo='km.out';
type
point =record
x,y,z,l : word ;
end;
arr1=array[0..100,0..100]of word ;
arr2=array[0..5000]of point ;
var
f:text ;
time,cp:^arr1;
a:arr2;
b:array[0..5000]of integer;
n,m,k,total,ttt,i,j:longint;
chon:string;
begin
new(time);
new(cp);
clrscr;
write ( '           Cham Test :    '  ) ;
readln ( chon ) ;
assign ( f , fi + chon ) ;
reset(f);
readln (f,n,m,k);
for i:=1 to k do
with a[i] do
begin
readln (f,x,y,z);
a[i].l:=i;
end;
for i:=0to n do
 for j :=0 to n do
  read ( f ,time^[i,j]);
for i :=0 to n do
 for j := 0 to n do
 read ( f , cp^[i,j]);
close ( f ) ;
assign(f,fo);reset(f);
readln(f,total);
i:=0;
while not seekeof(f) do
 begin
 inc(i);
 readln ( f , b [ i ] ) ;
 end;
 j:=i;
close (f);
b[0]:=0;
ttt:=0;
a[0].x:=0;a[0].y:=0;a[0].z:=0;a[0].l:=0;
for i:=1 to j do
 begin
      if (a[b[i]].y<a[b[i-1]].y+time^[a[b[i-1]].x,a[b[i]].x])or(a[b[i]].y+time^[a[b[i]].x,0]>m)then
      begin
                writeln('             Sai Duong Di ' ) ;
                readln ;
                halt;
      end;
 end;
writeln('               Ban dung !!');
write('               Toi da cua ban :    ' ) ;
writeln(total:10);

readln;
dispose(time);
dispose(cp);
end.