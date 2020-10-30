 uses crt;
 type mang1=array[1..50] of byte;
      mang2=array[1..50,1..50] of byte;
  var    a,d:mang1;
         luu:mang2;
         F:TEXT;
         n:byte;
 procedure  readfile;
 var i:byte;
 begin
      assign(f,'inp.noi');
      reset(f);
      readln(f,n);
      for i:=1 to n do read(f,a[i]);
      close(f);
      writeln('INPUT');
      for i:=1 to n do writeln('so dinh can noi cua dinh  ',i,' :',a[i]);
      for i:=1 to  n do d[i]:=i;
 end;

 procedure  sort;
 var i,j,tg:byte;
 begin
   for i:=1 to n-1 do
    for j:=i+1 to n do
    if a[i]<a[j] then
    begin tg:=a[i];a[i]:=a[j];a[j]:=tg;
          tg:=d[i];d[i]:=d[j];d[j]:=tg;
    end;
 end;

 procedure  noi_doan;
 var j,i,dem,dem1:byte; dk:boolean;
 begin fillchar(luu,sizeof(luu),0);
      dem:=1;
   repeat
      sort;
         for j:=2 to a[1]+1 do
           if a[j]> 0then
            begin luu[d[1],d[j]]:=1;luu[d[j],d[1]]:=1;dec(a[1]);dec(a[j]);end;
     inc(dem);
   until dem>n;
     writeln('OUTPUT');
      i:=n;
      while (a[i]<=0) and (i>0)do dec(i);
      if i>0 then dem1:=0;
      if  (dem1=0 ) then writeln('khong noi duoc')
     else
     for i:=1 to n do
      begin write('dinh  ',i,' noi voi cac dinh: ');
          for j:=1 to n do if luu[i,j]=1 then write(j:3);
          writeln;
      end;
   end;

  BEGIN  CLRSCR;
  readfile;
  noi_doan;
  readln
  END.

  5
  2
  1
  3

  4
  2
  5
  3
  4
  2
  3

  8
  3
  5
  4
  3
  3
  2
  4
  4

  9
  3
  5
  4
  3
  4
  3
  5
  4
  3

 5
 1
 2
 4
 1
 2
