(* doi tien voi so luong to it nhat va co gioi han ve so luong to*)

 uses crt;
 type  mang=array[0..15000] of word;
  var fb,luu:mang;
      a,b:array[1..200] of word;
      n:byte;
      k:integer;
      min,max:longint;
      f:text;
      t1:longint  absolute 0:$46c;
      t2:longint;

 procedure readfile;
 var i:byte;
 begin
   writeln('INPUT:');
   max:=0;
   min:=maxlongint;
   assign(f,'menh_gia.inp');
   reset(f);
   readln(f,n,k);
   writeln(n,'  ',k);
   for i:=1 to n do
   begin
     readln(f,a[i],b[i]);
     writeln(a[i],'  ',b[i]);
     if a[i]<min then min:=a[i];
     max:=max+a[i]*b[i];
   end;
   close(f);
   writeln('OUTPUT:');
  end;

  procedure innit;
  begin
   fillchar(fb,sizeof(fb),0);
   luu:=fb;
   fb[0]:=1;
  end;

  function ok(i:byte;j:word):boolean;
  var kt:array[0..200] of word;
      dem,d,i1:byte;k:word;
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
      (* con nam mo a di da phat*)

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
  t2:=t1;
   if max>=k then
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
         writeln;writeln;
         writeln('TIMERUN:',((T1-T2) /18.21):6:6)
  end;

 begin  clrscr;
   readfile;
   innit;
   xu_li;
   readln
 end.
  4 64
  1 10
  2 5
  3 6
  4 8
  4 11754
  1  3000
  200 40
  50 40
  3000 2
  3 20
  2 3
  5 2
  8 1



