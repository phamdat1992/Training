{Giai bai 2 thi hoc sinh gioi 2002-2003}
uses crt;
const fi='BAi3.INP';
      fo='BAI2.OUT';
{----------------------}
var f,g:text;
    k,kmax,d,dmax,n,nmax,i,j:integer;
    dodaixau:integer;
    s:string[80];
    a:ARRAY[1..5000] of integer;
Procedure readwrite;
begin
 assign(f,fi);reset(f);
 assign(g,fo); rewrite(g);
 dodaixau:=0;i:=0;
 while not eof(f) do
 begin
  readln(f,s);
  dodaixau:=dodaixau+length(s);
  writeln(s);
  for j:=1 to length(s) do
    begin
     i:=i+1;
     a[i]:=ord(S[j]);
    end;
  end;
  writeln(g,dodaixau);
  for j:=1 to dodaixau do
  if j mod 50 =0 then
    begin write(g,a[j],' ');writeln(g);end
  else write(g,a[j],' ');
  close(f);
  close(g);
end;
{---------------------------}
procedure xautangdai(var k,kmax:integer);
var i,j,m:integer;
begin
  k:=1;kmax:=1;
  for i:=1 to dodaixau-1 do
  begin
    j:=i;m:=1;
    while a[j+1]>a[j] do
    begin
      m:=m+1;
      if m>kmax then begin kmax:=m;k:=i;end;
      j:=j+1;
    end;
 End;
END;
{----------------------------------------}
procedure capcongdai(var d,dmax:integer);
var i,j,m,cs:integer;
begin
  d:=1;dmax:=1;
  for i:=1 to dodaixau-1 do
  begin
    j:=i;m:=1;
    cs:=a[j+1]-a[j];
    while a[j+1]-a[j]=cs do
    begin
      m:=m+1;
      if m>dmax then begin dmax:=m;d:=i;end;
      j:=j+1;
    end;
 End;
 dmax:=dmax;
END;

procedure capnhandai(var n,nmax:integer);
var i,j,m,cb:integer;
begin
  n:=1;nmax:=1;
  for i:=1 to dodaixau-1 do
  begin
    j:=i;m:=1;
    if (a[j+1]>a[j]) and (a[j+1] mod a[i]=0) then cb:=a[j+1] div a[j];
    while (a[j+1]=a[j]*cb) do
    begin
      m:=m+1;
      if m>nmax then begin nmax:=m;n:=i;end;
      j:=j+1;
    end;
 End;
 nmax:=nmax+1;
END;

BEGIN
  clrscr;
  readwrite;
  writeln(dodaixau);
  xautangdai(k,kmax);
  for i:=k to k+kmax-1 do
  write(chr(a[i]));writeln;
  writeln('--------------------');
  writeln(k);
  writeln(kmax);
  for i:=k to k+kmax-1 do
  write(chr(a[i]));writeln;
  writeln('--------------------');

  for i:=k to k+kmax-1 do
  write(chr(a[i]));writeln;
  writeln('--------------------');

  capcongdai(d,dmax);
  writeln(dmax);
  for i:=d to d+dmax-1 do
  write(chr(a[i]));writeln;
  writeln('--------------------');

  capnhandai(n,nmax);
  writeln(n);
  writeln(nmax);
  for i:=n to n+nmax-1 do
  write(chr(a[i]));writeln;
  writeln('--------------------');
  readln;
END.

