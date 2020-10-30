uses crt;
const  fi='nhin_hv.inp';
type
     toado=record
      x,y,h:integer;
     end;
     mang=array[1..1000] of toado;
 var a:mang;
     f:text;
     n:byte;

 procedure readfile;
 var  i:byte;
 begin
  writeln('INPUT:');
  assign(f,fi);
  reset(f);
  readln(f,n);
  writeln(n);
  for i:=1 to n do
   with a[i] do
   begin
     readln(f,x,y,h);
     writeln(x,'  ',y,'  ',h);
   end;
   close(f);
   writeln('OUTPUT:');
  end;

  function cat(x,y,x1,y1,x2,y2:integer):boolean;
  begin
    cat:=true;
    if (x1<=x) and (y1<=y) and (x1*y<=x*y1) and (x2*y>=x*y2) then exit;
    if (x1<=x) and (y1<=y) and (x1*y>=x*y1) and (x2*y<=x*y2) then exit;
    cat:=false;
  end;

  procedure xu_li;
  var i,J:byte;
      dk:boolean;
  begin
  for i:=1 to n do
   begin
    j:=1;
    dk:=true;
    while (j<=n) and dk do
    begin
     if j<>i then
      begin
      if cat(a[i].x,a[i].y,a[j].x,a[j].y,a[j].x+a[j].h,a[j].y) or
         cat(a[i].x,a[i].y,a[j].x,a[j].y,a[j].x,a[j].h+a[j].y) or
         cat(a[i].x,a[i].y,a[j].x+a[j].h,a[j].y,a[j].x+a[j].h,a[j].y+a[j].h) or
         cat(a[i].x,a[i].y,a[j].x,a[j].y+a[j].h,a[j].x+a[j].h,a[j].y+a[j].h) then
      begin
      if cat(a[i].x+a[i].h,a[i].y,a[j].x,a[j].y,a[j].x+a[j].h,a[j].y) or
         cat(a[i].x+a[i].h,a[i].y,a[j].x,a[j].y,a[j].x,a[j].h+a[j].y) or
         cat(a[i].x+a[i].h,a[i].y,a[j].x+a[j].h,a[j].y,a[j].x+a[j].h,a[j].y+a[j].h) or
         cat(a[i].x+a[i].h,a[i].y,a[j].x,a[j].y+a[j].h,a[j].x+a[j].h,a[j].y+a[j].h) then
       begin
      if cat(a[i].x+a[i].h,a[i].y+a[i].h,a[j].x,a[j].y,a[j].x+a[j].h,a[j].y) or
         cat(a[i].x+a[i].h,a[i].y+a[i].h,a[j].x,a[j].y,a[j].x,a[j].h+a[j].y) or
         cat(a[i].x+a[i].h,a[i].y+a[i].h,a[j].x+a[j].h,a[j].y,a[j].x+a[j].h,a[j].y+a[j].h) or
         cat(a[i].x+a[i].h,a[i].y+a[i].h,a[j].x,a[j].y+a[j].h,a[j].x+a[j].h,a[j].y+a[j].h) then
       begin
      if cat(a[i].x,a[i].y+a[i].h,a[j].x,a[j].y,a[j].x+a[j].h,a[j].y) or
         cat(a[i].x,a[i].y+a[i].h,a[j].x,a[j].y,a[j].x,a[j].h+a[j].y) or
         cat(a[i].x,a[i].y+a[i].h,a[j].x+a[j].h,a[j].y,a[j].x+a[j].h,a[j].y+a[j].h) or
         cat(a[i].x,a[i].y+a[i].h,a[j].x,a[j].y+a[j].h,a[j].x+a[j].h,a[j].y+a[j].h) then
       dk:=false;
      end;
      end;
      end;
      end;
      inc(j);
     end;
     if dk then writeln(a[i].x,'  ',a[i].y,'  ',a[i].h);
    end;
  end;

  BEGIN clrscr;
   readfile;
   xu_li;
   readln
  END.

