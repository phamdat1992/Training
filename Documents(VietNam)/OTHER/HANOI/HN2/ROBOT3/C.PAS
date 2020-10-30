uses crt;
const
     fhs='robot.out';
     fi='robot.in';
     fo='robot.ou';
var
   a:array[1..100,1..100] of byte;
   h:string;t:char;
   u,v,m,n,s,shs:byte;
   f:text;
procedure doc;
var
   i,j:byte;
begin
assign(f,fi+t);reset(f);
readln(f,m,n);
for i:=1 to m do
for j:=1 to n do read(f,a[i,j]);
close(f);
assign(f,fo+t);reset(f);
readln(f,s);
close(f);
end;
procedure r(var u,v:byte);
begin
inc(v);
end;
procedure d(var u,v:byte);
begin
inc(u);
end;
function ngoai(u,v:byte):boolean;
begin
ngoai:=(u<1)or(u>m)or(v<1)or(v>n);
end;
procedure cham;
var
   i,j,k:byte;
begin
assign(f,fhs);reset(f);
readln(f,shs);
writeln('        So ro bot cua HS: ',shs);
writeln('        So ro bot cua DA: ',s);
for i:=1 to shs do
    begin
    u:=1;v:=1;a[u,v]:=0;
    readln(f,h);k:=length(h);
    if k<>m+n-2 then
       begin
       writeln('        Do dai HT ro bot thu ',i,' khac M+N-2 !!!');
       writeln('        Ket qua sai!!!');
       close(f);exit;
       end;
    for j:=1 to k do
    begin
    if (h[j]<>'D')and(h[j]<>'R') then
       begin
       writeln('        Mo ta HT ro bot thu ',i,' khong dung: dung chu ',h[j]);
       writeln('        Ket qua sai!!!');
       close(f);exit;
       end;
    case h[j] of
    'D':d(u,v);'R':r(u,v);
    end;
    if ngoai(u,v) then
       begin
       writeln('        Ro bot thu ',i,' di ra ngoai xuong o buoc thu ',j);
       writeln('        Ket qua sai!!!');
       close(f);exit;
       end;
    a[u,v]:=0;
    end;
    end;
close(f);
for i:=1 to m do
for j:=1 to n do if a[i,j]=1 then
    begin
    writeln('        Ro bot khong don het san pham!!!');
    writeln('        Ket qua sai!!!');exit;
    end;
writeln('        Ro bot don het san pham');
end;
BEGIN
clrscr;
writeln;
write('CHAM TEST THU ');t:=readkey;writeln(t);
writeln;
doc;cham;readln;
END.