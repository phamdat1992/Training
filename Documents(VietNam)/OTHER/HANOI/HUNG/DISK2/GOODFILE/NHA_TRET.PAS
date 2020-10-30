 uses crt;
 const b:array[1..4] of shortint=(0,-1,0,1);
       c:array[1..4] of shortint=(-1,0,1,0);

 type  mang=array[1..100,1..100] of byte;
 var   a:mang;
       mind:array[1..100,1..100] of word;
       front:array[1..100,1..100] of 0..4;
       ok:array[1..100,1..100] of boolean;
       m,n,u1,v1,u2,v2,luu:byte;
       f:text;

 procedure  readfile;
 var i,j:byte;
 begin
   writeln(' INPUT:');
   assign(f,'nha_tret.inp');
   reset(f);
   readln(f,m,n);
   writeln(m:6,n:6);
   for i:=1 to m do
   begin
    for j:=1 to n do begin read(f,a[i,j]);write(a[i,j]:6);end;
    readln(f);
    writeln;
   end;
    readln(f,u1,v1,u2,v2);
    write('can tim duong di tu:');
    writeln(' [',u1,'.',v1,']  --->  [',u2,'.',v2,']');
  close(f);
  writeln;
 end;
 (*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*)
 function ok1(i,j:shortint):boolean;
 begin
   ok1:=true;
   if (i<0) or (i>m) or(j<0) or (j>n) then ok1:=false;
 end;

 function ok2(i1,j1,i2,j2:byte):word;
 begin
   ok2:=1000;
   if a[i1,j1]=a[i2,j2] then ok2:=1;
 end;
  (*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*)
  procedure  innit_array;
  var i:1..4;
  begin
   fillchar(mind,sizeof(mind),0);
   fillchar(ok,sizeof(ok),true);
   ok[u1,v1]:=false;
   fillchar(front,sizeof(front),0);
   for i:=1 to 4 do
    if ok1(u1+b[i],v1+c[i]) then
     begin
       mind[u1+b[i],v1+c[i]]:=ok2(u1,v1,u1+b[i],v1+c[i]);
       front[u1+b[i],v1+c[i]]:=i;
     end;
   end;
  (*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*)
 procedure writeso(i:byte);
 begin
  if i<=2 then i:=i+2
  else i:=i-2;
  luu:=i;
 end;

 procedure xuat;
 begin
 writeln('OUTPUT:');
 if mind[u2,v2]<1000 then
 begin
  writeln(mind[u2,v2]+1);
  luu:=0;
  write('[',u2,'.',v2,']');
  while front[u2,v2]<>0 do
   begin
     writeso(abs(front[u2,v2]));
     write('<---[',u2+b[luu],'.',v2+c[luu],']');
     u2:=u2+b[luu];
     v2:=v2+c[luu];
   end;
  end
  else
   begin
     luu:=0;
     writeln('khong di duoc:');
     writeln('ta pha vach ngan giua cac cap phong:');
     while front[u2,v2]<>0 do
   begin
     writeso(abs(front[u2,v2]));
     if front[u2,v2]<0 then writeln('[',u2+b[luu],'.',v2+c[luu],'] va [',u2,'.',v2,']  ');
     u2:=u2+b[luu];
     v2:=v2+c[luu];
   end;
  end;
 end;

  (*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*)
 procedure  dijsktra;
 var i,j,luu1,luu2:byte;
     min:integer;
 begin
  repeat
   min:=maxint;luu1:=0;luu2:=0;
    for i:=1 to m do
      for j:=1 to n do
       if (mind[i,j]>0)and(mind[i,j]<min) and ok[i,j] then
        begin
           min:=mind[i,j];
           luu1:=i;
           luu2:=j;
        end;
   ok[luu1,luu2]:=false;
   for i:=1 to 4 do
    if ok1(luu1+b[i],luu2+c[i]) and ok[luu1+b[i],luu2+c[i]] then
      if (mind[luu1+b[i],luu2+c[i]]=0) or
       (mind[luu1+b[i],luu2+c[i]]>mind[luu1,luu2]+ok2(luu1,luu2,luu1+b[i],luu2+c[i])) then
     begin
      mind[luu1+b[i],luu2+c[i]]:=mind[luu1,luu2]+ok2(luu1,luu2,luu1+b[i],luu2+c[i]);
      if ok2(luu1,luu2,luu1+b[i],luu2+c[i])=1 then front[luu1+b[i],luu2+c[i]]:=i
      else front[luu1+b[i],luu2+c[i]]:=-i
     end;
   until luu1<=0;
   xuat;
 end;
   (*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*)
 BEGIN clrscr;
 readfile;
 innit_array;
 dijsktra;
 readln
 END.
  5 5
  1 1 2 2 4
  0 1 2 2 4
  0 2 2 3 4
  0 1 3 3 4
  0 1 3 4 4
  1 1 5 4


