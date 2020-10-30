 uses crt;
 var a,mind1,mind2,b,b1:array[1..500] of word;
     f:text;
     arr:array[1..30,1..30] of word;
     front:array[1..2,1..400] of word;
     n,m,dem,lim,maxh,k:word;

 procedure readfile;
 var i,j:byte;
 begin
  writeln('INPUT:');
  fillchar(front,sizeof(front),0);
  maxh:=0;
  for i:=1 to k do
  begin
   for j:=1 to k do
    begin read(f,arr[i,j]);write(arr[i,j]:4);end;
   writeln;
  end;
   readln(f);
   readln;
   clrscr;
   write('OUTPUT:');
 end;

 procedure doc_mang;
 var i,j:word;
     d1,d2:byte;
 begin
  n:=0;d1:=1;d2:=1;
  j:=k;
  repeat
  for i:=d2 to k do
   begin
     inc(n);a[n]:=arr[d1,i];
   end;
  for i:=d1+1 to k do
   begin
     inc(n);a[n]:=arr[i,k];
   end;
  for i:=k-1 downto d2 do
   begin
     inc(n);a[n]:=arr[k,i];
   end;
  for i:=k-1 downto d1+1 do
   begin
     inc(n);a[n]:=arr[i,d2];
   end;
   dec(k,1);inc(d1);inc(d2);
  until k<=0;
  k:=j;
  writeln;
  for i:=1 to n do
  begin
  write(a[i],'  ');
  if i mod 16=0 then writeln;
  end;
 end;

 procedure xuat;
 var luu:word;
 begin
    dem:=1;
    luu:=m;
    b[dem]:=a[luu];
    while front[2,luu]<>0 do
     begin
       inc(dem);
       b[dem]:=a[front[2,luu]];
       luu:=front[2,luu];
     end;
 end;

 procedure  xuat1;
 var i,luu:integer;
 begin
    dem:=1;
    luu:=lim;
    b[dem]:=luu;
    while front[1,luu]<>0 do
     begin
       inc(dem);
       b[dem]:=front[1,luu];
       luu:=front[1,luu];
     end;
 end;

 procedure  innit;
 var  i:word;
 begin
 for i:=1 to n do mind1[i]:=1;
 end;

 procedure try1;
 var i,j:word;
 begin
  for i:=n-1 downto 1 do
   for j:=i+1 to n do
    if a[i]>a[j] then
     if (mind1[i]<mind1[j]+1) then
      begin
       mind1[i]:=mind1[j]+1;
       front[1,i]:=j;
      end;
 end;

 procedure try2;
 var i,j,max,luu:word;
 begin
  for i:=1 to m do
   for j:=1 to i-1 do
    if a[i]>a[j] then
     if mind2[i]<mind2[j]+1 then
      begin
       mind2[i]:=mind2[j]+1;
       front[2,i]:=j;
      end;
      if (mind2[m]>1) and (mind1[m]+mind2[m]>maxh) then
       begin
         maxh:=mind1[m]+mind2[m];
         lim:=m;
         xuat;
      end;
 end;

 procedure main;
 var i:word;
 begin
  readfile;
  doc_mang;
  writeln;
  innit;
  try1;
  for m:=1 to n do
  if mind1[m]>1 then
  begin
    for i:=1 to n do front[2,i]:=0;
    for i:=1 to m do mind2[i]:=1;
    try2;
  end;
  writeln;
  writeln(maxh-1);
  for i:=mind2[lim] downto 2 do write(b[i],'  ');
  xuat1;
  for i:=1 to dem do
   write(a[b[i]],'  ');
end;

procedure  test;
var dd:byte;
begin
 assign(f,'bai3a.inp');
 reset(f);
 readln(f,n,k);
 for dd:=1 to n do
  begin
  clrscr;
  writeln('BO THU ',dd);
   main;
   readln;
  end;
  close(f);
end;

begin  clrscr;
test;
end.
2 6
