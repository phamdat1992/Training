 uses crt;
 type mang=array[1..100] of integer;
 var a:mang;
     f:text;
     n,p,top:byte;

 procedure  readfile;
 var i:byte;
     name:string;
 begin   write('file name input:');readln(name);
    assign(f,name);
    reset(f);
    readln(f,n);
    writeln(n);
    for i:=1 to n do begin read(f,a[i]);write(a[i],' ');end;writeln;
 end;

 function max(i,j:byte):byte;
 begin max:=i;if j>i then max:=j;end;


  function mu(k:byte):integer;
  var i:byte;mum:integer;
  begin
    mum:=1;
    for i:=1 to k do mum:=mum*2;
    mu:=mum;
   end;

 function  ok(i,j:byte):boolean;
 begin  ok:=false;
       if (a[j] mod mu(p+1)=mu(p))and(a[i] mod mu(p+1)=mu(p))
       then ok:=true;
 end;

 procedure  don_soi(d1,d2:byte);
 var tg,i:integer;
 begin   write('don  hai dong:a[',d1,']+ a[',d2,']'); readln;
     while (a[d1]<>a[d2]) and (a[d1]<>2*a[d2]) and ok(d1,d2)do
         begin
            write('a[',d1,']=',a[d1],' + a[',d2,']=',a[d2], '===>');
            a[d1]:=a[d1]-a[d2];
            a[d2]:=2*a[d2];
            write('a[',d1,']=',a[d1], '+  a[',d2,']=',a[d2]);writeln;
            if a[d1]<a[d2] then begin tg:=a[d1];a[d1]:=a[d2];a[d2]:= tg; end;
         end;
    if a[d1] =a[d2] then
      begin  write('a[',d1,']=',a[d1],'  +  a[',d2, ']=',a[d2],' ====> a[',d1+d2-max(d1,d2),']=',a[d1]+a[d2]);writeln;
             a[d1+d2-max(d1,d2)]:=2*a[d1];
             a[max(d1,d2)]:=0;
      end ;
 for i:=1 to n do write(a[i],'  ');readln;
 end;

   function oko:byte;
   var i,d:byte;
   begin  d:=0;
     for i:=1 to n do
      if a[i]<>0 then inc(d);
     oko:=d;
    end;

 procedure xuli;
 var i,j:byte;
    t:set of byte;
 begin
    p:=0;
 repeat
 t:=[];
 for i:=1 to n do
 if (a[i]<>0) and ( not (i in t))and (a[i] mod mu(p)=0) and (a[i] mod mu(p+1)<>0)
 then  t:=t+[i];
 for i:=1 to n do
  if i in t then
  begin t:=t-[i];
      j:=1;
      while (j<=n) and (not ( j in t) or (ok(i,j)=false))do inc(j);
      if j<=n then begin
      if a[i]>a[j] then don_soi(i,j)
      else don_soi(j,i);end;
  end;
    inc(p);
  until oko<= 1;
  end;

  BEGIN clrscr;
  readfile;
  xuli;
  readln
  END.
  3
  8 2 6
  20
  1 5 7 1 3 5 4 8 2 28 2 4 6 2 2 6 4 8 8 22

  8
  1 2 3 4 5 6 7 4