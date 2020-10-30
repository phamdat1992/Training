     program  tim_he_thong_hoan_thien;
     uses crt;
     type  mang=array[1..50] of byte;
     var a:mang;
         b:array[1..50,0..50] of byte;
         n:byte;
         ok1:array[1..50] of boolean;
         f:text;

     procedure  readfile;
     var i:byte;
     begin
       assign(f,'ht.inp');
       reset(f);
       readln(f,n);
       for i:=1 to n do  readln(f,a[i]);
       close(f);
       writeln('input:');
       for i:=1 to n do
       writeln(i:4,a[i]:4);
       writeln;
     end;

     function ok(i,d:byte):boolean;
     var d1:byte;
     begin
      ok:=false;
      for d1:=1 to b[i,0] do
       if b[i,d1]=d then exit;
       ok:=true;
      end;

     procedure tim_chuoi;
     var i,d:byte;
     begin
     i:=0;
     repeat
       inc(i);
       d:=a[i];
       inc(b[i,0]);
       b[i,b[i,0]]:=i;
       repeat
            if ok(i,d) then
            begin
               inc(b[i,0]);
               b[i,b[i,0]]:=d;
               d:=a[d];
            end;
       until  ok(i,d)=false;
     until i>=n;
      end;

    procedure giai_phong;
    var  i,j:byte;
    begin
      for i:=1 to n do
       if ok1[i] then
        begin
          j:=1;
          while (j<=b[i,0]) and (ok1[b[i,j]]=true) do  inc(j);
          b[i,0]:=j-1;
        end;
     end;


    procedure  xu_li;
    var  dem,i,max,luu:byte;

         dd,val:array[0..50] of byte;
         dk:boolean;
    begin
     dem:=0;
     fillchar(ok1,sizeof(ok1),true);
     repeat
        luu:=0;
        dk:=true;
        max:=0;
        for i:=1 to n do
         if ok1[i] then
          if b[i,0]>max then
            begin
                   luu:=i;
                   max:=b[i,0];
                   dk:=false;
            end;
          if luu<>0 then
          begin
           inc(dem);
           val[dem]:=luu;
           for i:=1 to b[luu,0] do ok1[b[luu,i]]:=false;
           giai_phong;
          end;
     until dk;
     readln;
     clrscr;
     writeln('OUTPUT:');
     if dem>1 then
     begin
      writeln(' He thong khong hoan thien:');
      writeln('So cap ke tiep phai thay la:',dem);
      writeln('Do la:');
      val[dem+1]:=val[1];
      for i:=1 to dem do
      begin
          write('Cap (',b[val[i],b[val[i],0]],'.',a[b[val[i],b[val[i],0]]], ')');
          write('Thay boi cap (',b[val[i],b[val[i],0]],'.',val[i+1], ')');
          a[b[val[i],b[val[i],0]]]:=val[i+1];
          writeln;
      end;
     end
     else  writeln('He thong hoan thien');
     writeln;
     writeln('He thong luc do la:');
     for i:=1 to n do
     writeln(i,'  ',a[i]);
   end;

   BEGIN  CLRSCR;
   readfile;
   tim_chuoi;
   xu_li;
   readln
   end.
   10
   6
   9
   2
   7
   3
   1
   10
   3
   6
   9

   6
   2
   3
   4
   3
   1
   3

   18
   2
   3
   4
   5
   6
   3
   5
   9
   10
   5
   8
   11
   17
   18
   6
   15
   16
   17
   9
