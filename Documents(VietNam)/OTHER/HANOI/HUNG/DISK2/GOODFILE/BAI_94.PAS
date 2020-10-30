  uses crt;
  type  mang=array[1..30] of integer;
  var  a:mang;
       stl,front:array[0..30,0..1000] of shortint;
       m,n,dem:byte;

  procedure  readfile;
  var  i:byte;f:text;
  begin
    writeln('INPUT:');
    assign(f,'bai_94.inp');
    reset(f);
    readln(f,n,m);
   writeln(n,m:6);
   for i:=1 to n do
    begin
        read(f,a[i]);
        write(a[i]:6);
     end;
     close(f);
  end;

  function  max(i,j:byte):byte;
  begin
     max:=i;
     if j>i then max:=j;
  end;

  procedure  tim;
  var  i,j,k,luu1,luu2:byte;
  begin
   fillchar(stl,sizeof(stl),0);
     for j:=1 to m do
       for i:=1 to n do
         if a[i]<=j then
           if stl[i,j]<max(stl[i-1,j-a[i]]+a[i],stl[i-1,j]) then
             begin stl[i,j]:=max(stl[i-1,j-a[i]]+a[i],stl[i-1,j]);front[i,j]:=i;end;
       writeln;
          luu2:=m;
        while stl[n,m]=stl[n,luu2] do dec(luu2);
        inc(luu2);
        for i:=n downto 1 do
           if stl[i,luu2]<>stl[i-1,luu2] then
           begin
              inc(dem);
              write(i:6);
              luu2:=luu2-a[i];
              a[i]:=0;
           end;
    end;

   procedure  main;
   var  d:byte;
   begin
     d:=0;
     while dem<n do
      begin
         tim;
         inc(d);
      end;
      writeln;
      writeln(d);
   end;

   begin  clrscr;
   readfile;
   WRITELN;
   writeln('OUTPUT:');
   dem:=0;
   main;
   readln;
   end.

  11 10
  2 3 4 5 6 9 8 2 3 4 3