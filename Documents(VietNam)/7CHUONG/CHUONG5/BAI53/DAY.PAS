{$R+}{$M 65000,0,0}
const
     fi='day.inp';
     fo='day.out';
var
   a,b,c:array[1..50] of integer;
   f:text;s,s1,dem:longint;n:integer;
procedure nhap;
var
   x:integer;
begin
assign(f,fi);reset(f);
readln(f,n);
for x:=1 to 2*n+1 do read(f,b[x]);readln(f);
readln(f,s);
close(f);
end;
function bang:boolean;
var
   x:integer;
begin
for x:=2 to 2*n do if a[x]<>b[x] then begin bang:=false;exit;end;
bang:=true;
end;
procedure sinh(i:integer);
var
   j,t:integer;
begin
t:=a[i-1];
if t=0 then
   begin
   a[i]:=1;
   if (i<2*n+1) then sinh(i+1);
   end
else
    begin
    a[i]:=t-1;
    if (i=2*n+1) then
    begin
    if a[i]=0 then
       begin
       inc(dem);
       if dem=s then c:=a;
       if bang then s1:=dem;
       end;
    end
    else sinh(i+1);
    a[i]:=t+1;if (i<2*n+1) then sinh(i+1);
    end;
end;
procedure viet;
var
   x:integer;
begin
assign(f,fo);rewrite(f);
writeln(f,dem);
writeln(f,s1);
for x:=1 to 2*n+1 do write(f,c[x]:4);writeln(f);
close(f);
end;
BEGIN
nhap;
a[1]:=0;dem:=0;
sinh(2);
viet;
END.