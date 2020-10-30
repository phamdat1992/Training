 uses crt;
 const fi='fib.inp';
       fo='fib.out';
 var s1,s2,s,f1,f2,s3,ss1,ss2:string;
     f,ff:text;
     n:byte;
     k:longint;

 procedure readfile;
 begin
  assign(f,fi);
  reset(f);
  readln(f,n);
  readln(f,s1);
  readln(f,s2);
  ss1:=s1;ss2:=s2;
 end;

 procedure init;
 var  tg:string;
 begin
  k:=3;
  s1:=ss1;s2:=ss2;
  while length(s1)<=length(s)+1 do
   begin
    inc(k);
    tg:=s2;
    s2:=s2+s1;
    s1:=tg;
   end;
   s3:=s2+s1;
 end;

 function  SoLanXuatHien(si,sj:string):byte;
 var dem,i:byte;
 begin
    dem:=0;
    for i:=1 to length(si)-length(sj)+1 do
     if sj=copy(si,i,length(sj)) then inc(dem);
    SoLanXuatHien:=dem;
 end;

 procedure  xuli;
 var tl,p1,p2,fb1,fb2,dd,i,fb:longint;
 begin
  init;
  p1:=SoLanXuatHien(s1,s);
  p2:=SoLanXuatHien(s2,s);
  f1:=copy(s2,length(s2)-length(s)+2,length(s)-1)+copy(s1,length(s1)-length(s)+2,length(s)-1);
  f2:=copy(s3,length(s3)-length(s)+2,length(s)-1)+copy(s2,length(s2)-length(s)+2,length(s)-1);
  fb1:=solanxuathien(f1,s);
  fb2:=solanxuathien(f2,s);
  dd:=0;i:=0;
  while k<=n do
   begin
     if odd(i) then fb:=fb2
     else fb:=fb1;
     tl:=p2;
     dd:=p1+p2+fb;
     p2:=dd;p1:=tl;
     inc(i);
     inc(K);
   end;
   writeln(ff,dd);
 end;

 procedure  main;
 begin
  assign(ff,fo);
  rewrite(ff);
  readfile;
  while not eof(f) do
   begin
     readln(f,s);
     xuli;
   end;
   close(f);
   close(ff);
 end;

 begin  clrscr;
    main;
 end.
8
A
B
AB
BBA
ABBA






































































































































































































































































































































































































































































































































































































