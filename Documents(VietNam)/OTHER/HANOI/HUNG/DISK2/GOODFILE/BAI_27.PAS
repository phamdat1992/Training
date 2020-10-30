 uses crt;
 type  mang=array[1..100,1..100] of  byte;
 var  b,a:mang;
      n,max,l1,l2:byte;
      f:text;

 procedure readfile;
 begin
   fillchar(a,sizeof(a),0);
   assign(f,'bai_27.inp');
   reset(f);
   readln(f,n);
   writeln(n);
   close(f);
  end;

  function  ok(i,j,k,l:byte):boolean;
  begin
   ok:=true;
   if (i=j) or (k=l) or(i-j=k-l) or (i+j=k+l) then exit;
   ok:=false;
   end;

  procedure sl_maxd(var max,l1,l2:byte);
  var i,j,k,l,dem:byte;
  begin
    max:=0;
    for i:=1 to n do
      for j:=1 to n do
        if a[i,j]=0 then
          begin
           dem:=0;
           for k:=1 to n do
             begin
               if (k<>j) and (a[i,k]=0) then inc(dem);
               if (k<>i) and (a[k,j]=0) then inc(dem);
             end;
            for k:=1 to n do
             for l:=1 to n do
              if (k-l=i-j) or (k+l=i+j) and (i<>k) and(a[k,l]=0) then inc(dem);
             if dem>max then
               begin
                  max:=dem;l1:=i;l2:=j;
               end;
       end;
   end;

  procedure cau_1;
  var i,j:byte;
  begin
   writeln('OUTPUT1:');
   for i:=1 to n do
    for j:=1 to n do a[i,j]:=(i+j) mod n+1;
   for i:=1 to n do
    begin
     for j:=1 to n do write(a[i,j]:4);
     writeln;
    end;
  end;

  begin  clrscr;
  readfile;
  cau_1;
  readln
  end.
  6