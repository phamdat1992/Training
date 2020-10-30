uses crt;
type
     toado=record
         x,y:integer;
      end;
    tam_giac=record
      td1,td2,td3:toado;
      end;
 var a,b:tam_giac;
     dg1,dg2,dg:array[1..100] of toado;
     n:byte;
     chiso,chiso1:array[1..100] of byte;

  procedure readfile;
  var f:text;
      i:byte;
  begin
    fillchar(chiso,sizeof(chiso),0);
    assign(f,'dagiacdd.inp');
    reset(f);
    readln(f,n);
    writeln('INPUT:');
    writeln(n);
    for i:=1 to n do begin read(f,dg1[i].x,dg1[i].y);write(dg1[i].x:5,dg1[i].y:5);end;
    writeln;
    readln(f);
    for i:=1 to n do begin  read(f,dg2[i].x,dg2[i].y);chiso[i]:=i;write(dg2[i].x:5,dg2[i].y:5);end;
    close(f);
    writeln;
    writeln('OUTPUT:');
   end;

  function  do_dai(i,j:toado):real;
  begin
   do_dai:=sqr(i.x-j.x)+sqr(i.y-j.y);
  end;

  function  dong_dang(a,b:tam_giac):boolean;
  var xx,yy:array[1..3] of real;
      i,j:byte;
  begin
     xx[1]:=do_dai(a.td1,a.td2);
     xx[2]:=do_dai(a.td1,a.td3);
     xx[3]:=do_dai(a.td3,a.td2);
     yy[1]:=do_dai(b.td1,b.td2);
     yy[2]:=do_dai(b.td1,b.td3);
     yy[3]:=do_dai(b.td3,b.td2);
     if ((xx[1]*yy[2])=(xx[2]*yy[1])) and ((xx[1]*yy[3])=(xx[3]*yy[1])) then dong_dang:=true
       else dong_dang:=false;

  end;

  procedure  chuyen_dd;
  var i:byte;
  begin
   dg2[n+1]:=dg2[1];
   dg:=dg2;
   for i:=1 to n do
   begin
      dg[i]:=dg2[n+2-i]
   end;
   for i:=2 to n do chiso1[i]:=n+2-i;chiso1[1]:=1;
  end;

  procedure quay_da_giac;
  var i:byte;
  begin
    for i:=n downto 1 do begin dg2[i+1]:=dg2[i];chiso[i+1]:=i;end;
    dg2[1]:=dg2[n+1];
    chiso[1]:=n;
  end;


  procedure xu_li;
  var  dem,i,d:byte;oko,dk:boolean;
  begin
   dem:=0;oko:=false;d:=1;
   a.td1:=dg1[1];a.td2:=dg1[2];a.td3:=dg1[n];
   chuyen_dd;
   while (d<=2) and (oko=false) do
    begin
    repeat
      b.td1:=dg2[1];b.td2:=dg2[2];b.td3:=dg2[n];
      if dong_dang(a,b) then
       begin
         dk:=true;
         i:=3;
         while (i<=n-1) and dk do
          begin
           if do_dai(dg1[1],dg1[i])*do_dai(dg2[1],dg2[i+1])<>do_dai(dg2[1],dg2[i])*do_dai(dg1[1],dg1[i+1]) then dk:=false;
           if dk then inc(i);
          end;
          if dk then oko:=true;
        end;
       if not oko then quay_da_giac;
       inc(dem);
    until oko or (dem>n);
    if not oko then begin inc(d);dg2:=dg;chiso:=chiso1;end;
   end;
    if oko then
     begin
       writeln('hai da giac dong dang:');
          writeln('thu tu dinh dong dang la:');
          for i:=1 to n do write(i:5);writeln;
            for i:=1 to n do write(chiso[i]:5);
      end
    else  writeln('hai da giac khong dong dang:');

  end;

  begin  clrscr;
    readfile;
    xu_li;
    readln
  end.
