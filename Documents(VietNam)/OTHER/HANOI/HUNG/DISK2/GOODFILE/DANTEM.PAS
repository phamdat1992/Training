 (*tim cach dan tem sao cho so tem khong vuot qua so luong cho truoc va buu phi
   khong nhay cat co the  dan duoc cac buu phi tu 1 den 13 xu. nhung khong dan
   duoc buu phi 14 xu va lai gian duoc buu phi 15 xu thi ta noi do bao phu lon
   nhat la 13.
   input: dong dau cua du lieu la so nguyen f cho biet so tem lon nhat co the
   dan tren phong bi dong tiep theo la mot so nguyen n la so cac tap tem trong
   bo du lieu .moi day trong so n dong tiep theo chua day tem,so dau tien la so
   tem cua day,sau do la gia cac tem thu tu tu nho den lon f<=10.n<=10.so tem
   trong mot tap <=100.du lieu vao ket thuc boi so 0.
   output:
   vi du:

   2 5
   1 4 12 21
   1 5 12 28
   ca hai deu co do phu lon nhat la 71 nhung tap mot duoc chon vi gia tri lon
   nhat la 21<28 cua tap thu hai
   *)

   uses crt;
   type  mang=array[1..100,0..10] of byte;
   var  a:mang;
        f:text;
        n,m:byte;
        spt:array[0..1000] of longint;

   procedure  readfile;
   var  i:byte;
   begin
     writeln('INPUT:');
     assign(f,'inp.dt');
     reset(f);
     readln(f,n,m);
     writeln(n,m:6);
     for i:=1 to n do
     begin
      while not(eoln(f)) do
       begin
         inc(a[i,0]);
         read(f,a[i,a[i,0]]);
         write(a[i,a[i,0]]:5);
       end;
       writeln;
       readln(f);
      end;
   end;

   procedure  tim;
   var  d,d1,luu,k,luu1:longint;
        j,max,max1,max2:longint;
        ok:boolean;
   begin
      max2:=1;luu1:=1;max1:=maxint;
      for d:=1 to n do
      if a[d,1]=1 then
      begin
      d1:=1;
      fillchar(spt,sizeof(spt),0);
      spt[1]:=1;
      repeat
      ok:=true;
       inc(d1);
       for j:=1 to a[d,0] do
        if a[d,j]<=d1 then
         if spt[d1-a[d,j]]<m then
         if (spt[d1-a[d,j]]<spt[d1]) or (spt[d1]=0) then
           begin  spt[d1]:=spt[d1-a[d,j]]+1;ok:=false;end;
      until ok;
      if ((d1=max2) and(a[d1,a[d1,0]]<max1)) or (d1>max2)then
        begin max2:=d1-1;luu1:=d;max1:=a[d1,a[d1,0]];end;
     end;
     writeln('OUTPUT:');
     writeln(max2,luu1:6);
     end;

   begin  clrscr;
   readfile;
   tim;
   readln
   end.

  1 6
  1 6 8 15 18 21

  2 10
  1 7 16 31 88
  1 15 52 67 99

  2 6
  1 5  8
  1 5 7 8