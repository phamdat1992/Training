uses crt;
type mang1=array[0..50,0..50] of byte;
     mang2=array[1..50] of byte;
 var a,d1,b:mang1;
     f:text;    n:byte;
 procedure  readfile;
 var i,j:byte;
 begin assign(f,'inp.cho');
       reset(f);
       readln(f,n);
       for i:=1 to n do
        begin for j:=1 to n do
                read(f,a[i,j]);
                readln(f);
         end;
         readln(f);
         for i:=1 to n do
          begin for j:=1 to n do
                  read(f,b[i,j]);
                  readln(f);
           end;
         close(f);
  end;

  procedure watch;
  var i,j:byte;
  begin
      for i:=1 to n do
       begin for j:=1 to n do
             write(a[i,j], '  ');
             writeln;
       end;
       READLN;
       for i:=1 to n do
       begin
            for j:=1 to n do
            write(b[i,j],'  ');
            writeln;
       end;
  end;

  PROCEDURE choice_job;
  var d2,ok:mang2;
      w,i,j,tg:byte;
 begin
     fillchar(ok,sizeof(ok),0);
     fillchar(d2,sizeof(d2),0);
     for i:=1 to n do
      d1[i,0]:=n+1;
      for i:=1 to n do
       begin j:=i;
         repeat
           inc(d2[j]);
           w:=a[j,d2[j]];
           if d1[w,j]<d1[w,ok[w]] then
            begin tg:=ok[w];
                  ok[w]:=j;
                  j:=tg;
            end;
         until j=0;
       end;
     write('        CONG VIEC DUOC CHON LA');writeln;
     FOR I:=1 TO N DO
     WRITEln('nguoi  ',ok[i]:3, ' lam viec  ' ,i);
 end;

  BEGIN clrscr;
   readfile;
   writeln(n);
   writeln('INPUT');
   watch;
   READLN;CLRSCR;
   WRITELN('OUTPUT');
   choice_job;
   readln;
   END.

   15
   2 5 1 3 4 6 8 7 9 10 12 13 15 14 11
   1 2 3 4 5 7 6 8 11 12 15 14 13 9 10
   2 3 5 4 1 12 15 14 13 9 8 7 6 10 11
   1 3 2 4 5 15 14 13 12 11 10 9 8 7 6
   5 3 2 1 4 9 7 6 8 10 12 11 15 14 13
   5 1 4 2 3 12 13 15 14 6 9 8 7 11 10
   4 5 2 1 3 15 11 12 6 7 8 9 10 14 13
   1 4 2 3 5 6 7 8 9 15 14 13 12 11 10
   3 2 4 1 5 10 11 12 13 14 15 8 6 7 9
   4 2 3 5 1 15 14 6 7 8 10 9 13 12 11
   1 3 2 4 5 15 14 13 12 11 10 9 8 7 6
   5 3 2 1 4 9 7 6 8 10 12 11 15 14 13
   5 1 4 2 3 12 13 15 14 6 9 8 7 11 10
   4 5 2 1 3 15 11 12 6 7 8 9 10 14 13
   1 4 2 3 5 6 7 8 9 15 14 13 12 11 10

   1 4 2 3 5 6 7 8 9 15 14 13 12 11 10
   3 2 4 1 5 10 11 12 13 14 15 8 6 7 9
   4 2 3 5 1 15 14 6 7 8 10 9 13 12 11
   1 3 2 4 5 15 14 13 12 11 10 9 8 7 6
   5 3 2 1 4 9 7 6 8 10 12 11 15 14 13
   5 1 4 2 3 12 13 15 14 6 9 8 7 11 10
   4 5 2 1 3 15 11 12 6 7 8 9 10 14 13
   1 4 2 3 5 6 7 8 9 15 14 13 12 11 10
   5 1 4 2 3 12 13 15 14 6 9 8 7 11 10
   4 5 2 1 3 15 11 12 6 7 8 9 10 14 13
   1 4 2 3 5 6 7 8 9 15 14 13 12 11 10
   3 2 4 1 5 10 11 12 13 14 15 8 6 7 9
   4 2 3 5 1 15 14 6 7 8 10 9 13 12 11
   1 3 2 4 5 15 14 13 12 11 10 9 8 7 6
   5 3 2 1 4 9 7 6 8 10 12 11 15 14 13
