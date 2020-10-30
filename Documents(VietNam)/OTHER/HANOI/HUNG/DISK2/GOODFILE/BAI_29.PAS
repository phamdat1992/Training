 (* tim tong con ,tong con duong,va ccah bieu dien*)
 uses crt;
 type mang=array[1..7000] of integer;
  var a,b,a1,b1:mang;
      n,d,luu:integer;
      maxd,k1:integer;
      chiso:array[1..7000] of byte;
      f:text;

 procedure  readfile;
 var i:integer; name:string;
 begin
  fillchar(a,sizeof(a),0);
  b:=a;
  write('filename input:');readln(name);
  assign(f,name);
  reset(f);
  readln(f,n);
  for i:=1 to n do read(f,a[i]);
  close(f);
  writeln(n);
  for i:=1 to n do write(a[i]:4);writeln;
  end;

  procedure  taomang(a:mang);
  var i:byte;
  begin
    i:=1; d:=0;
    while i<=n do
     begin
        inc(d);
        b[d]:=a[i];
        chiso[d]:=i;
        inc(i);
        while a[i-1]*a[i]>0 do
         begin b[d]:=b[d]+a[i];inc(i);end;
     end;

    end;

   procedure  tim_tong_con_max;
   var  i,max,luu1,luu2,j:integer;
   begin
      i:=1;
      while b[i]<0 do inc(i);
      maxd:=b[i];j:=i;
      repeat
        i:=j;
        luu1:=i;
       max:=b[i];
       while b[i+2]+b[i+1]>0 do
       begin
          max:=max+b[i+1]+b[i+2];
          i:= i+2;
        end;
        if max>maxd then begin maxd:=max;luu:=i;luu2:=luu1;end;
         j:=j+2;
        until i>n;
        writeln('output1:');
        writeln(maxd);
        for i:=chiso[luu2] to chiso[luu+1]-1 do write(a[i]:4);
        writeln;
    end;

   procedure tong_duong;
   var i:byte;
    begin    maxd:=0;
        for i:=1 to d do
        if b[i]>maxd then begin  luu:=i;maxd:=b[i];end;
     end;

   procedure tim_cach_bieu_dien;
   var  i,j,dd:byte;maxp,k:integer;
   begin        maxp:=0; b1:=a;
      writeln;writeln(n,'   ',k1);
      i:=1;
      while a[i]<0 do inc(i);a1:=a;
      repeat
       k:=k1;
       j:=i;
       if a[j]<0 then
      begin  while (j<=n) and (k+a1[j]>0) do
        begin
             if (a1[j]<0) and (k+a1[j]>0)then
              begin
	            k:=k+a1[j]-1;
                    a1[j]:=1;
              end;
              inc(j);
         end;
         if k>0 then a1[j-1]:=a1[j-1]+k;
         taomang(a1);
         tong_duong;
         if maxd>maxp then
          begin b1:=a1;maxp:=maxd;end
       end;
         inc(i);
         a1:=a;
         until i>n;
         writeln(maxp);
         for dd:=1 to n do  write(b1[dd]:4);
    end;

   begin clrscr;
   readfile;
   taomang(a);
   tim_tong_con_max;
   tong_duong;
   writeln('output2:');
   writeln(maxd);
   for k1:=chiso[luu] to chiso[luu+1]-1 do write(a[k1]:4);
   writeln;
   write('k=');readln(k1);
   writeln('output3:');
   tim_cach_bieu_dien;
   readln
   end.
   19
   29 -20  25 -8 -9 7 6 9 8 -5 5 6 9 -4 7 -6 -54 -4 2