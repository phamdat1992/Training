 uses crt;
 type mang=array[0..6,0..6,0..6,0..6,0..5] of longint;
      vatl=record
        sl,name:longint;
      end;
(**)
 var a:mang;
     sl,num,gt,name,tgia,lg,tg:array[0..5] of longint;
     f:text;
     m,n:byte;
     min:longint;
     oko:array[1..100] of boolean;
     vat:array[0..100,0..5] of vatl;
 (**)
 function ok(i:byte):boolean;
 var j:byte;
 begin
   ok:=true;
   for j:=1 to n do
   if name[j]=i then exit;
   ok:=false;
 end;
 (**)
 function ok1(i,k:byte):boolean;
 var j:byte;
 begin
   ok1:=false;
   for j:=1 to num[i] do
   if vat[i,j].name=k then exit;
   ok1:=true;
 end;
 (**)
 procedure  readfile;
 var i,j:byte;dk:boolean;
 begin
   fillchar(a,sizeof(a),0);
   fillchar(oko,sizeof(oko),false);
   fillchar(sl,sizeof(sl),0);
   gt:=sl;name:=sl;num:=sl;tgia:=sl;lg:=sl;
   writeln('INPUT:');
   assign(f,'ban_hang.inp');
   reset(f);
   readln(f,n);
   writeln(n);
   for i:=1 to n do
   begin
     readln(f,name[i],sl[i],gt[i]);
     writeln(name[i]:5,sl[i]:5,gt[i]:5);
    end;
   readln(f,m);
   writeln;
   writeln(m);
   for i:=1 to m do
    begin
    dk:=true;
      read(f,num[i]);
      write(num[i]:5);
      for j:=1 to num[i] do
       begin
         read(f,vat[i,j].name,vat[i,j].sl);
         write(vat[i,j].name:5,vat[i,j].sl:5);
         if (ok(vat[i,j].name)=false) or (vat[i,j].sl>5) then dk:=false;
       end;
      oko[i]:=dk;
      readln(f,tgia[i]);
      writeln(tgia[i]:5);
     end;
   close(f);
  end;

 procedure xu_li_da_ta;
 var i,j:byte;
 begin
    for i:=1 to m do
     if oko[i] then
     for j:=1 to n do
     if ok1(i,name[j]) then
      begin
       inc(num[i]);
       vat[i,num[i]].name:=name[j];
       vat[i,num[i]].sl:=0;
      end;
  end;

 procedure  sort1;
 var i,j,tg:0..5;
 begin
  for i:=1 to n-1 do
   for j:=i+1 to n do
    if name[i]>name[j] then
     begin
        tg:=name[i];
        name[i]:=name[j];
        name[j]:=tg;
        tg:=sl[i];
        sl[i]:=sl[j];
        sl[j]:=tg;
        tg:=gt[i];
        gt[i]:=gt[j];
        gt[j]:=tg;
    end;
 end;

 procedure sort2;
 var  i,j,k:byte;
      tg1:vatl;
 begin
   for i:=1 to m do
    for j:=1 to num[i]-1 do
      for  k:=j+1 to num[i] do
       if vat[i,j].name>vat[i,k].name then
        begin
          tg1:=vat[i,j];
          vat[i,j]:=vat[i,k];
          vat[i,k]:=tg1;
        end;
 end;

 procedure  check1;
 var i,j:byte;
 begin
   min:=0;
   for i:=1 to 5 do min:=min+lg[i]*gt[i];
  for i:=1 to 5 do
    begin
     for j:=1 to 5 do tg[j]:=0;
     for j:=1 to lg[i] do
      begin
        tg[i]:=j;
        if min>a[lg[1]-tg[1],lg[2]-tg[2],lg[3]-tg[3],lg[4]-tg[4],lg[5]-tg[5]]+gt[i]*j then
               min:=a[lg[1]-tg[1],lg[2]-tg[2],lg[3]-tg[3],lg[4]-tg[4],lg[5]-tg[5]]+gt[i]*j;
      end;
   end;
   a[lg[1],lg[2],lg[3],lg[4],lg[5]]:=min;
 end;

 procedure check2;
 var i,j:byte;dk:boolean;
 begin
   min:=a[lg[1],lg[2],lg[3],lg[4],lg[5]];
    for i:=1 to m do
     if oko[i] then
     begin
      dk:=true;j:=1;
      while dk and (j<=5) do
       begin
        if (lg[j]<vat[i,j].sl) then dk:=false;
        inc(j);
       end;
       if dk then
        min:=a[lg[1]-vat[i,1].sl,lg[2]-vat[i,2].sl,lg[3]-vat[i,3].sl,lg[4]-vat[i,4].sl,lg[5]-vat[i,5].sl]+tgia[i];
     end;
      a[lg[1],lg[2],lg[3],lg[4],lg[5]]:=min;
   end;

 procedure main;
 begin
 readfile;
 xu_li_da_ta;
 sort1;
 sort2;
 for lg[1]:=0 to sl[1] do
  for lg[2]:=0 to sl[2] do
   for lg[3]:=0 to sl[3] do
    for lg[4]:=0 to sl[4] do
     for lg[5]:=0 to sl[5] do
       begin
           check1;
           check2;
       end;
  writeln('OUTPUT:');
  write('tong chi phi la:');
  write(a[sl[1],sl[2],sl[3],sl[4],sl[5]]:8);
  end;

 BEGIN clrscr;
 main;
 readln
 END.

 3
 2 5 10
 1 4 6
 5 3 4

 4
 2 2 3 1 8 20
 3 8 2 9 3 10 2 9
 2 7 5 9 8 6
 3 2 1 1 1 5 1 10

 4
 2 5 10
 1 4 6
 5 3 4
 8 5 3

 3
 2 2 3 1 8 20
 3 8 2 9 3 10 2 9
 2 7 5 9 8 6

 3
 2 5 5
 6 4 5
 1 3 10

 4
 2 2 3 6 2 20
 3 2 3 6 1 1 3 40
 2 6 4 1 3 40
 2 2 4 1 5 56

 5
 1 5 4
 6 4 4
 2 3 7
 3 5 2
 5 1 1
 6
 3 1 2 6 1 2 2 5
 2 5 1 6 1 4
 3 2 1 1 2 3 5 10
 2 1 1 2 3 6 4 10
 3 1 2 3 3 4 4 5
 3 6 1 2 3 2 2 8




