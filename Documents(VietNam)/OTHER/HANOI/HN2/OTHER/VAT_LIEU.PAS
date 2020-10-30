 uses crt;
 var a,b,d:array[0..30] of word;
     mind,front:array[0..30,0..500] of word;
     n:byte;
     r:word;
     f:text;

 procedure readfile;
 var i:byte;
 begin
   writeln('INPUT:');
   assign(f,'vat_lieu.inp');
   reset(f);
   readln(f,n,r);
   writeln(n:5,r:5);
   for i:=1 to n do begin read(f,d[i]);write(d[i]:5);end;
   readln(f);writeln;
   for i:=1 to n do begin read(f,a[i]);write(a[i]:5);end;
   readln(f);writeln;
   for i:=1 to n do begin read(f,b[i]);write(b[i]:5);end;
   close(f);
 end;

 function min(i,j:byte):byte;
 begin
  min:=i;
  if j<i then min:=j;
 end;

 procedure innit;
 var i,j:word;
 begin
  fillchar(mind,sizeof(mind),0);
  for i:=0 to r do
   for j:=0 to min(i,d[1]) do
    if (mind[1,i]=0) or (mind[1,i]>j*a[1]+(d[1]-j)*b[1]) then
     begin
        mind[1,i]:=j*a[1]+(d[1]-j)*b[1];
        front[1,i]:=j;
     end;
 end;

 procedure xuat;
 var i:byte;
 begin
  writeln;
  writeln('OUTPUT:');
  writeln(mind[n,r]:7);
  writeln('          A      B');
  for i:=n downto 1 do
   begin
    writeln(i:4,front[i,r]:7,d[i]-front[i,r]:7);
    r:=r-front[i,r];
   end;
 end;

 procedure xu_li;
 var i,j,k:word;
 begin
  innit;
  for i:=2 to n do
   for j:=0 to r do
    for k:=0 to min(d[i],j) do
     if (mind[i,j]=0) or (mind[i,j]>k*a[i]+(d[i]-k)*b[i]+mind[i-1,j-k]) then
      begin
       mind[i,j]:=k*a[i]+(d[i]-k)*b[i]+mind[i-1,j-k];
       front[i,j]:=k;
      end;
      xuat;
  end;

  begin  clrscr;
  readfile;
  xu_li;
  readln
  end.
 8 20
 10 20 1 5 4 7 5 5
 3 2 1 4 2 4 5 1
 3 6 9 8 7 4 1 2

