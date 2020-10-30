(* co mot vat rat nhay cam voi nhiet do nguoi ta can dua vat do tu dia diem
   a-->b. tim lo tring di tu a-->b phi lan luot qua cac dia diem jhac sao cho su thay doi
   nhiet do lon nhat khi di tu dia diem nay sang dia diem khac tren
   lo trinh la thap nhat ,moi dia diem co mot nhiet do xac dinh.du lieu la mot day so thuc
   bieu dien nhiet do cua cac dia diem.so dau tien trong day la nhoet do tai dia diem a.
   va so cuoi cung trong day *)
   uses crt;
   var chiso,fb,a,a1:array[1..5000] of word;
       n,dem,u,v:integer;
       f:text;

   procedure  readfile;
   var i:integer;
   begin
    writeln('INPUT:');
    assign(f,'degree.inp');
    reset(f);
    readln(f,n);
    writeln(n);
    for i:=1 to n do begin chiso[i]:=i;read(f,a[i]);write(a[i],'  ');end;
    readln(f);
    readln(f,u,v);
    close(f);writeln;
    writeln(u,'  ',v);
    writeln('OUTPUT:');
    a1:=a;
   end;

   procedure sort;
   var i,j,tg:integer;
   begin
    for i:=1 to n-1 do
     for j:=i+1 to n do
      if a[j]<a[i] then
       begin
        tg:=a[i];
        a[i]:=a[j];
        a[j]:=tg;
        tg:=chiso[i];
        chiso[i]:=chiso[j];
        chiso[j]:=tg;
       end;
    end;

   procedure  xu_li;
   var  d1,d2,d:integer;
   begin
      d1:=1;d2:=1;
      while (chiso[d1]<>u) or (chiso[d2]<>v) do
       begin
        if chiso[d1]<>u then inc(d1);
        if chiso[d2]<>v then inc(d2);
       end;
      d:=d1;dem:=0;
      while d>0 do
       begin
         inc(dem);
         fb[dem]:=d;
         fb[d1-dem+1]:=d-1;
         dec(d,2);
       end;
       for d:=d1+1 to d2-1 do fb[d]:=d;
       d:=d2;dem:=0;
       while d<=n do
        begin
          fb[dem+d2]:=d+1;
          fb[n-dem]:=d;
          inc(d,2);
          inc(dem);
        end;
       d:=1;
       d1:=0;
       for d:=1 to n do write(a1[chiso[fb[d]]],'  ');
   end;

 begin  clrscr;
 readfile;
 sort;
 xu_li;
 readln
 end.
 11
 1 3 5 1 4 58 4 4 54 1 14
 3 9
