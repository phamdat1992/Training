(*
   Bai Toan Cac Con Ro Bot Va Nha Du Hanh  Vu Tru:
        Thuat Toan :Loang Moi Cach Di Cua Ro Bot
                   :Co The Dung Chieu Rong
                   :Chu Y Rang Neu Ro Bot Ton Tai Qua max(M<N) Thi No
                    Se Ton Tai Mai Mai.
                   :Duoi Day La chuong Trinh Duyet Theo Chieu Sau  
                    Lap Trinh Vien  :RONAlDO Khoi Chuyen Toan Tin PBC
      *)
   
 uses crt;
 const ch:array[0..3] of char=('o','$','*','#');
       b:array[1..9] of shortint=(0,-1,0,1,0,-1,-1,1,1);
       c:array[1..9] of shortint=(0,0,1,0,-1,-1,1,1,-1 );
       fin='ro_bot.inp';
 type  mang=array[1..20,1..20] of byte;
 var   a,a1:mang;
       maxarr,tgarr:array[1..1000] of integer;
       m,n,x,y,sobuoc,max,x1,y1:word;
       f:text;


 function HetRoBot:boolean;
 var  i,j:byte;
 begin
  HetRoBot:=false;
  for i:=1 to m do
   for j:=1 to n do
    if a1[i,j]=2 then exit;
  HetRoBot:=true;
 end;

 procedure  chuthich;
 begin
  textcolor(yellow);
  write('                                *');
  textcolor(white);
  writeln(' : Tuong Trung Cho Ro Bot');
  textcolor(red);
  write('                                #');
  textcolor(white);
  writeln(' : Tuong Trung Cho O Nguy Hiem');
  textcolor(green);
  write('                                $');
  textcolor(white);
  writeln(' : Tuong Trung Cho Nha Du Hanh');
 end;

 procedure Watch(a:mang);
 var  i,j:integer;
 begin
    clrscr;
    chuthich;
    writeln(x,'  ',y);
    for i:=1 to m do
      begin
          for j:=1 to n do
           begin
              if a[i,j]=1 then textcolor(green);
              if a[i,j]=2 then textcolor(yellow);
              if a[i,j]=3 then textcolor(red);
              if a[i,j]=0 then textcolor(white);
              write(ch[a[i,j]],'  ');
           end;
           writeln;
       end;
       writeln;
    if hetrobot then
    begin
       writeln('HOAN HO !??! Bon Ro Bot Ngu Si The La Tieu Tung');
       writeln('             Ta Song Mai Mai Roi !  :');
       writeln('             Hay Den Cuu Ta Keo Binh Duong Khi Het ??  ');
    end;
 end;

 procedure readfile;
 var  i,j:integer;
 begin
  max:= 0;
  assign(f,fin);
  reset(f);
  readln(f,m,n);
  for i:=1 to m do
   for j:=1 to n do
   begin
    read(f,a[i,j]);
    if a[i,j]=1 then begin x:=i;y:=j;end;
    end;
    a1:=a;x1:=x;y1:=y;
    watch(a);delay(1000);
    close(f);
 end;

 function maxx(i,j:integer):integer;
 begin
   maxx:=i;
   if i<j then maxx:=j;
 end;

 function AnToan(i,j,k:integer):boolean;
 begin
  AnToan:=false;
  if (i+b[k]<0) or (j+c[k]<0) or (i+b[k]>m) or (j+c[k]>n) then exit;
  AnToan:=true;
 end;

 Function O_AnToan(k:integer):boolean;
 var j:integer;
 begin
   O_AnToan:=false;
   if not AnToan(x,y,k) then exit;
   if a[x+b[k],y+c[k]]>1 then exit;
   for j:=1 to 9 do
    if AnToan(x+b[k],y+c[k],j) then
     if a[x+b[k]+b[j],y+c[k]+c[j]]=2 then exit;
  O_AnToan:=true;
 end;

 procedure Di_Chuyen;
 var  i,j,dem,k:integer;
      sl:array[1..100,1..3] of byte;
      min:integer;
 begin
  fillchar(sl,sizeof(sl),0);
  dem:=0;
  for i:=1 to m do
   for j:=1 to n do
    if a[i,j]=2 then
     begin
        min:=500;
        inc(dem);
        sl[dem,1]:=i;sl[dem,2]:=j;
        for k:=1 to 9 do
         if AnToan(i,j,k) then
           begin
           if min>sqr(abs(x-i-b[k]))+sqr(abs(y-j-c[k])) then
            begin
              min:=sqr(abs(x-i-b[k]))+sqr(abs(y-j-c[k]));
              sl[dem,3]:=k;
            end;
           end;
     end;
     for i:=1 to dem do
      begin
       dec(a[sl[i,1],sl[i,2]],2);
       inc(a[sl[i,1]+b[sl[i,3]],sl[i,2]+c[sl[i,3]]],2);
      end;
     for i:=1 to m do
      for j:=1 to n do
       if a[i,j]>2 then a[i,j]:=3;
 end;

 procedure xuat(p:byte);
 var  i:byte;
 begin
    i:=1;
    while  i<=max do
     begin
        x:=x1;y:=y1;
        a:=a1;
        a[x,y]:=0;
        x:=x+b[maxarr[i]];y:=y+c[maxarr[i]];
        a[x,y]:=1;
        di_chuyen;
        watch(a);delay(1000);
        x1:=x;y1:=y;
        inc(i);
        a1:=a;
       if hetrobot and (I<max) then
       begin
         watch(a);delay(2000);halt;
       end;
     end;
     if (p>0) and not hetrobot then
     begin
      writeln('Oi Cha Me Oi Con Chet Roi !!??!  HELP!  HELP!');
      writeln(' Ta Chi Ton Tai Tren Hanh Tinh Nay: ',max,' Giay Thoi Sao  ?  Hu Hu..u u..');
      readln;
      end
     else
       if p>0 then
       begin
         writeln;
         writeln('Ui Troi Oi May Man Lam Sao !! Bon Be La Lua Nhung Ta Van Song.');
         writeln('Cuu Ta Mau Len !!!  No..ong..ong Qu..a..a..a');
         delay(8000);
       end;
 end;

 procedure ghi_nhan;
 begin
  max:=sobuoc;
  maxarr:=tgarr;
  if max>maxx(m,n) then begin  xuat(0);delay(1000);halt;end;
 end;

 procedure Try;
 var i:byte;
     luumang:mang;
 begin
     for i:=1 to 5 do
      if O_AnToan(i) then
       begin
        luumang:=a;
        a[x,y]:=0;
        inc(sobuoc);
        tgarr[sobuoc]:=i;
        x:=x+b[i];y:=y+c[i];
        a[x,y]:=1;
        di_chuyen;
        if sobuoc>max then ghi_nhan;
        try;
        dec(sobuoc);
        x:=x-b[i];
        y:=y-c[i];
        a:=luumang;
       end;
 end;

 begin  clrscr;
  readfile;
  try;
  xuat(1);
 end.

 7 8
 0 0 0 0 0 0 0 0
 0 2 0 0 0 0 0 0
 2 0 0 0 1 0 0 0
 0 2 0 0 0 0 0 0
 2 0 0 0 0 0 0 0
 0 2 0 2 0 2 0 2
 2 0 2 0 0 0 0 0
 10 10
 0 0 0 0 0 0 0 0 0 0
 0 0 0 2 0 0 0 0 2 0
 0 0 2 0 2 0 2 0 0 0
 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 2 0 0 0 0 0
 0 0 0 0 0 0 0 0 1 0
 0 0 2 0 0 0 0 0 0 0
 0 0 0 0 0 2 0 0 0 0
 0 0 0 0 0 2 0 0 0 0
 0 0 0 2 0 0 0 0 0 0

 11 15
 0 0 0 0 0 0 0 2 0 0 0 2 0 2 0
 0 0 0 2 0 2 0 0 0 0 0 0 2 0 0
 0 2 0 0 2 0 0 2 0 0 0 0 0 0 0
 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0
 0 0 0 0 0 2 0 0 2 0 0 2 0 0 0
 0 3
 15 15
 0 0 0 0 0 0 0 2 0 0 0 2 0 2 0
 0 0 0 2 0 2 0 0 0 0 0 0 2 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0
 0 3 0 0 0 0 3 0 0 0 0 0 0 0 0
 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0
 0 0 2 0 0 0 0 0 0 0 0 0 2 0 0
 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0
 0 0 2 0 0 0 0 0 0 0 0 2 0 0 0
 0 0 0 0 0 0 0 0 0 3 0 0 0 0 0
 0 0 0 0 0 0 0 2 0 2 0 0 0 0 0
 0 0 2 0 0 0 0 0 0 0 0 3 0 0 0
 0 0 2 0 0 2 0 0 0 0 3 0 0 0 0
 0 0 0 0 0 0 0 0 2 0 0 0 0 2 0
 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0

 15 15
 0 2 2 2 2 2 2 0 2 2 2 2 2 2 0
 2 0 0 0 0 0 0 0 0 0 0 0 0 0 2
 2 0 0 0 0 0 0 0 0 0 0 0 0 0 2
 2 0 0 0 0 0 0 0 0 0 0 0 0 0 2
 2 0 0 0 0 0 0 0 0 0 0 0 0 0 2
 2 0 0 0 0 0 0 0 0 0 0 0 0 0 2
 2 0 0 0 0 0 0 0 0 0 0 0 0 0 2
 2 0 0 0 0 0 0 1 0 0 0 0 0 0 2
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2 0 0 0 0 0 0 0 0 0 0 0 0 0 2
 2 0 0 0 0 0 0 0 0 0 0 0 0 0 2
 2 0 0 0 0 0 0 0 0 0 0 0 0 0 2
 2 0 0 0 0 0 0 0 0 0 0 0 0 0 2
 2 0 0 0 0 0 0 0 0 0 0 0 0 0 2
 0 2 2 2 2 2 2 0 2 2 2 2 2 2 0

  15 15
 0 0 0 0 0 0 0 2 0 0 0 2 0 2 0
 0 0 0 2 0 2 0 0 0 0 0 0 2 0 0
 0 2 0 0 0 0 3 0 3 0 0 0 0 0 0
 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0
 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 3 0 0 0 0
 0 0 2 0 0 0 0 0 3 0 0 0 3 0 0
 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0
 0 0 2 0 0 0 0 0 0 0 0 2 0 0 0
 0 0 0 0 0 0 0 3 0 3 0 0 0 0 0
 0 0 0 0 0 0 0 2 0 2 0 0 0 0 0
 0 0 2 0 0 0 0 0 0 0 0 3 0 0 0
 0 0 2 0 0 20 0 0 0 0 3 0 0 0 0
 0 0 0 0 0 0 0 0 2 0 0 0 0 2 0
 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0
 9 9
 0 2 2 2 0 2 2 2 0
 2 0 0 0 0 0 0 0 2
 2 0 0 0 0 0 0 0 2
 2 0 0 0 0 0 0 0 2
 0 0 0 0 1 0 0 0 0
 2 0 0 0 0 0 0 0 2
 2 0 0 0 0 0 0 0 2
 2 0 0 0 0 0 0 0 2
 0 2 2 2 0 2 2 2 0
 13 16
 0 0 0 0 0 2 0 2 0 2 0 2 0 2 0 2
 0 0 0 2 0 0 0 0 0 0 0 0 0 2 0 0
 0 0 0 0 0 2 0 0 2 0 0 0 0 0 0 0
 0 0 2 0 0 0 0 0 0 0 0 2 0 2 0 0
 0 0 0 0 0 0 3 0 0 0 0 0 0 0 0 0
 0 0 2 0 0 0 0 0 0 0 0 3 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2
 0 0 0 0 0 0 0 3 0 0 0 0 3 0 0 0
 0 0 0 0 0 0 0 0 1 0 0 0 3 0 0 0
 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 2 0 0 3 0 3 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 2 0 0 0 0 0 2
 0 0 0 0 0 2 0 0 2 0 3 0 0 0 0 0

