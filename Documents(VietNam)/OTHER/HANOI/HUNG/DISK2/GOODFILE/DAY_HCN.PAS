 uses crt;
 type  mang=array[1..4] of byte;
 var  a:array[1..1000] of mang;
      b:array[1..200,1..200] of boolean;
      nb,spt,front,front1,dtm,dt:array[1..1000] of integer;
      f:text;
      n:byte;

 procedure  readfile;
 var  i,j:byte;
 begin
   assign(f,'day_hcn.inp');
   reset(f);
   readln(f,n);
   writeln(n);
   for i:=1 to n do
    begin
    for j:=1 to 4 do
      begin
        read(f,a[i][j]);write(a[i][j]:4);
      end;
      writeln;
      nb[i]:=i;
    end;
   close(f);
 end;

 function oko(x,y:integer;i:byte):boolean;
 begin
  oko:=true;
  if (x>=a[i][1]) and (x<=a[i][3]) and (y>=a[i][2]) and (y<=a[i][4]) then exit;
  oko:=false;
 end;

 function ccw(i,j:byte):boolean;
 begin
   ccw:=true;
   if oko(a[i][1],a[i][2],j) then exit;
   if oko(a[i][3],a[i][4],j) then exit;
   if oko(a[i][1],a[i][4],j) then exit;
   if oko(a[i][3],a[i][2],j) then exit;
   ccw:=false;
 end;

 procedure maxssquare;
 var  i,j,luus:byte;max:longint;
 begin
  max:=0;luus:=0;
  i:=1;
  while (i<=n) and (i>0) do
   begin
    j:=1;
    while (j<=n) and (j>0) do
    begin
      if (j<>i) and ccw(j,i) then j:=0
      else inc(j);
    end;
    if j>0 then
      if (a[i][3]-a[i][1])*(a[i][4]-a[i][2])>max then
      begin
        max:=(a[i][3]-a[i][1])*(a[i][4]-a[i][2]);
        luus:=i;
        inc(i);
      end;
      inc(i);
   end;
   writeln('OUPUT:');
   if i=0 then write('tat ca cac hinh chu nhat cat deu co ban doi')
   else write(luus,'  ',max);
   writeln;
 end;

 procedure tao_mang;
 var  i,j,k:integer;
 begin
    fillchar(b,sizeof(b),false);
    for i:=1 to n-1 do
     for j:=i+1 to n do
       if (a[i][1]<=a[j][1])and (a[i][2]<=a[j][1])
       and (a[i][3]>=a[j][3])and (a[i][4]>=a[j][4])  then b[i,j]:=true;
    for i:=1 to n do
     dt[i]:=(a[i][3]-a[i][1]+1)*(a[i][4]-a[i][2]+1);
 end;

 procedure  sort;
 var i,j,gt:integer;
    tg:mang;
 begin
  for i:=1 to n-1 do
   for j:=i+1 to n do
    if abs(a[i][1]-a[i][3])<abs(a[j][1]-a[j][3]) then
     begin;
        tg:=a[i];
        a[i]:=a[j];
        a[j]:=tg;
        gt:=nb[i];
        nb[i]:=nb[j];
        nb[j]:=gt;
        gt:=dt[i];
        dt[i]:=dt[j];
        dt[j]:=gt;
     end;
 end;


 procedure  xuli;
 var  i,j,k:integer;
 begin
   for i:=1 to n do
   begin spt[i]:=1;dtm[i]:=dt[i];end;
   for i:=n-1 downto 1 do
    for j:=i+1 to n do
     if b[i,j] then
     begin
      if spt[i]<spt[j]+1 then
       begin
              spt[i]:=spt[j]+1;
              front[i]:=j;
       end;
      if dtm[i]<dtm[j]+dt[j] then
       begin
          dtm[i]:=dtm[j]+dt[j];
          front1[i]:=j;
       end;
      end;
      i:=1;
       for j:=1 to n do
        if spt[j]>spt[i] then i:=j;
       writeln(spt[i]);
       k:=i;j:=1;
       while (j<=spt[i]) do
        begin
         write(nb[k]:4);
         k:=front[k];
         inc(j);
         end;
       i:=1;
       for j:=1 to n do
        if dtm[j]>dtm[i] then i:=j;
       writeln;
       writeln(dtm[i]);
       k:=i;
        repeat
         write(nb[k]:4);
         k:=front1[k];
       until k>0;
       write(nb[k]:4);
  end;

 begin  clrscr;
 readfile;
 maxssquare;
 sort;
 tao_mang;
 xuli;
 readln
 end.

 10
 0 0 1 1
 0 0 5 5
 4 4 100 100
 0 0 2 2
 0 0 3 3
 5 5 80 80
 3 6 8 7
 1 3 5 4
 0 0 4 4
 0 0 4 5

