(* chuong trinh tim duong cho diep vien:*
   tap de lvt
 *)
 program  diep_vien_hoc_ngoai_ngu;
 uses crt;
 const fin='diepvien.inp';
       fou='diepvien.out';
 type
    tapso=set of byte;
 var
     tt:array[1..200] of tapso;
     d,mind,luud:array[1..200] of integer;
     a:array[1..200,1..200] of 0..1;
     f:text;
     n,s,st:byte;

 procedure readfile;
 var i,j:byte;
 begin
  writeln('INPUT:');
  assign(f,fin);
  reset(f);
  readln(f,n,s,st);
  writeln(n,'  ',s,'  ',st);
  for i:=1 to n do begin read(f,d[i]);write(d[i],'  ');end;writeln;
  readln(f);
  for i:=1 to n do
   begin
    for j:=1 to n do
     begin  read(f,a[i,j]);write(a[i,j],'  ');end;
    writeln;
   end;
  close(f);
 end;

 procedure innit;
 var i,j,ss:integer;
     t:tapso;
 begin
  fillchar(mind,sizeof(mind),0);luud:=mind;
  for i:=1 to n do tt[i]:=[s];
  for i:=1 to n do
   if a[s,i]>0 then
   begin
     t:=[s,i];ss:=d[i]+d[s];
     for j:=1 to n do
      if (a[i,j]>0) and (j<>s) and not (j in t) then
       begin
         t:=t+[j];
         ss:=ss+d[j];
       end;
    mind[i]:=ss;
    tt[i]:=t;
    luud[i]:=s;
  end;
 end;

 procedure xuat;
 var dem:byte;
     dd:array[1..200] of byte;
 begin
  dem:=1;fillchar(dd,sizeof(dd),0);
  writeln('OUTPUT:');
  writeln(mind[st]);
  dd[1]:=st;
  while luud[st]>0 do
   begin
     inc(dem);
     dd[dem]:=luud[st];
     st:=luud[st];
   end;
   for st:=dem downto 1 do write(dd[st],'  ');
 end;

 Procedure  Prosses;
 Var  i,j,ss,luu,min,dt:integer;
      t,tap:tapso;
      dk:boolean;
 Begin
  tap:=[s];
  for dt:=1 to n-2 do
  begin
   dk:=false;
   min:=100;
   for i:=1 to n do
    if not (i in tap) and (mind[i]>0) then
     if mind[i]<min then
      begin
       min:=mind[i];
       luu:=i;
      end;
    tap:=tap+[luu];
    for i:=1 to n do
     if not (i in tap) then
      if a[luu,i]>0 then
       begin
        ss:=mind[luu];
        t:=tt[luu];
        for j:=1 to n do
         if not (j in t) and (a[i,j]>0) then
          begin
            ss:=ss+d[j];
            t:=t+[j];
          end;
         if (mind[i]=0) or (mind[i]>ss) then
          begin
            mind[i]:=ss;
            tt[i]:=t;
            luud[i]:=luu;
            dk:=true;
         end;
      end;
   end;
   xuat;
 end;

 BEGIN clrscr;
  readfile;
  innit;
  prosses;
  readln
 END.
7 1 7
2 7 7 2 3 6 5
0 1 0 0 1 0 0
1 0 1 1 0 0 0
0 1 0 1 0 0 1
0 1 1 0 1 1 0
1 0 0 1 0 1 0
0 0 0 1 1 0 1
0 0 1 0 0 1 0

10 4 3
6 5 4 8 7 1 2 3 8 9
0 1 0 0 1 1 0 1 0 1
1 0 0 1 1 0 1 0 1 0
0 0 0 0 0 1 0 1 1 1
0 1 0 0 1 0 1 0 1 0
1 1 0 1 0 0 0 0 1 1
1 0 1 0 0 0 1 0 0 1
0 1 0 1 0 1 0 0 1 1
1 0 1 0 0 0 0 0 0 1
0 1 1 1 1 0 1 0 0 0
1 0 1 0 1 1 1 1 0 0
