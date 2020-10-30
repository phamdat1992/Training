 uses crt;
 type
   tron=record
    x,y,r:real;
   end;
 var
  a:array[1..100] of tron;
  n,dem:byte;
  f:text;

 procedure readfile;
 var i:byte;
 begin
  assign(f,'hinhtron.inp');
  reset(f);
  readln(f,n);
  for i:=1 to n do
  with a[i] do
    readln(f,x,y,r);
  close(f);
 end;

 function ok(i,j:byte):boolean;
 begin
    ok:=false;
    if sqrt(sqr(a[i].x-a[j].x)+sqr(a[i].y-a[j].y))<=a[i].r-a[j].r
    then ok:=true;
 end;

 procedure readfile_and_movefile;
 var i,j:byte;
     f1,f2:text;
 begin
  assign(f1,'hinhtron.out');
  rewrite(f1);
  assign(f2,'inp.dat');
  reset(f2);
  writeln(f1,dem-1);
  for i:=1 to dem do
  begin
   while not eoln(f2) do
    begin
     read(f2,j);write(f1,j:5);
    end;
    readln(f2);
    writeln(f1);
  end;
  close(f2);
  close(f1);
 end;

 procedure numbering;
 var
     i,j:byte;
     bac:array[1..100] of byte;
     t,t1:set of byte;
     f1:text;
 begin
   assign(f1,'inp.dat');
   rewrite(f1);
   fillchar(bac,sizeof(bac),0);
   for i:=1 to n do
     for j:=1 to n do
      if i<>j then
       if ok(i,j) then inc(bac[j]);
       t:=[];dem:=0;
   repeat
      t1:=[];
      for i:=1 to n do
       if (bac[i]=0) and (not(i in t1 )) and ( not (i in t)) then
         begin write(f1,i:5);t1:=t1+[i];end;
         writeln(f1);inc(dem);
      for i:=1 to n do
       if (bac[i]=0) and (not(i in t )) and (i in t1) then
        begin
         t:=t+[i];
         for j:=1 to n do
          if not(j in t) then
           if ok(i,j) then dec(bac[j]);
        end;
   until t1=[];
   close(f1);
 end;

 begin  clrscr;
 readfile;
 numbering;
 readfile_and_movefile;
 end.

 2
 0 0 1
 0 0 2
8
2 2 1
4 1 2
6 4 2
6 4 1
8 5 1
2 2 4
0 0 9
7 4 3
3
    7    8
    2    3    5    6
    1    4















































