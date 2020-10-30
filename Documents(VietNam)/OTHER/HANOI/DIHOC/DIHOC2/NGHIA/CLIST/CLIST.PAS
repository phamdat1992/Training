const
   fin: string = 'CLIST.IN0';
   fou: string = 'CLIST.OUT';
var
   list: array[1..200] of integer;
   a,b,c: longint;
   f: text;
   h, x, n, k, l, i, ofs, r: longint;


BEGIN
  assign(f,fin); reset(f);
  readln(f,n,k,l);
  for i:=1 to n do read(f,list[i]);
  read(f,x);
  close(f);
  k:=k mod n;
  l:=l mod n;
  if k>l then
      x:= (x mod n)*(k-l) mod n
  else
      x:= - (x mod n)*(l-k) mod n;
  writeln('x = ',x);
  assign(f, fou); rewrite(f);
  for i:=1 to n do
  begin
    r:= (i+x) mod n;
    write(r,'  ');
    if r<=0 then r:=r+n;
    if r>n then r:= r-n;
    write(f,list[r]);
    if i<n then write(f,' ');
  end;
  close(f);
{  readln;}
END.
5 2 1
1 2 3 4 5
11
