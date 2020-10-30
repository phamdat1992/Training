(* doi tien voi so luong to it nhat*)
 uses crt;
 type  mang=array[0..15000] of word;
  var fb,luu:mang;
      a,b:array[1..200] of word;
      n:byte;
      k:integer;
      min,max:longint;
      f:text;

 procedure readfile;
 var i:byte;
 begin
   max:=0;
   min:=maxlongint;
   assign(f,'menh_gia.inp');
   reset(f);
   readln(f,n,k);
   for i:=1 to n do
   begin
     readln(f,a[i],b[i]);
     if a[i]<min then min:=a[i];
     max:=max+a[i]*b[i];
   end;
   close(f);
  end;

  procedure innit;
  begin
   fillchar(fb,sizeof(fb),0);
   luu:=fb;
   fb[0]:=1;
  end;

  function ok(i:byte;j:word):boolean;
  var kt:array[0..200] of word;
      dem,d,i1,k:word;
  begin
    k:=j-a[i];dem:=0;
    while k>0 do
     begin
      inc(dem);
      kt[dem]:=luu[k];
      k:=k-a[luu[k]];
     end;
     d:=0;
     for i1:=1 to dem do
      if kt[i1]=i then inc(d);
     if d<b[i] then ok:=true
     else ok:=false;
  end;


  procedure xuat(i:integer);
  begin
    if i<>0 then
    begin
    xuat(i-a[luu[i]]);
    write(a[luu[i]]:8);
    end;
  end;

  procedure xu_li;
  var i,j:integer;
  begin
   if max >=k then
    for i:=min to k do
     for j:=1 to n do
      if i>=a[j] then
       if (fb[i-a[j]]>0) and (ok(j,i)) then
         if (fb[i]=0) or (fb[i]>fb[i-a[j]]+1) then
          begin
            fb[i]:=fb[i-a[j]]+1;
            luu[i]:=j;
          end;
         if fb[k]>1 then begin writeln(fb[k]-1);xuat(k)end
         else writeln('0');
  end;

 begin  clrscr;
   readfile;
   innit;
   xu_li;
   readln
 end.
 14 15000
 1 1
 2 1
 4 1
 8 1
 16 1
 32 1
 65 1
 129 1
 257 1
 513 1
 1025  1
 2506 1
 6000 1
 12000 1

 5 96
 3 3
 6 3
 9 3
 12 3
 15 3




