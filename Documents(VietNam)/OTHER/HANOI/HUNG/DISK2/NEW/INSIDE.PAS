uses crt;
type point=record
     x,y:integer;
     end;
     lines=record
      x1,x2:point;
      end;
var a:array[1..50] of point;
    f:text;
    maxx:integer;
    xa,ya,n:integer;
    l:lines;
(**)
procedure  readfile;
var  i:byte;
begin
   maxx:=0;
   assign(f,'inp.bl2');
   reset(f);
   readln(f,xa,ya);
   writeln(xa:3,ya:3);
   readln(f,n);
   writeln(n);
   for i:=1 to n do
   begin
   readln(f,a[i].x,a[i].y);writeln(a[i].x:3,a[i].y:3);
   if maxx<=a[i].x then maxx:=a[i].x;
   end;
   close(f);
   inc(maxx,abs(xa-maxx)+1); writeln(maxx);
end;
 (**)
 function min(i,j:byte):byte;
 begin min:=i;
 if j<i then min:=j;
 end;

 function  ccw(po,p1,p2:point):integer;
 var   d1x,d2x,d1y,d2y:integer;
 begin
    d1x:=p1.x-po.x; d1y:=p1.y-po.y;
    d2x:=p2.x-p1.x; d2y:=p2.y-po.y;
    if d1x*d2y > d2x*d1y then ccw:=1;
    if d1x*d2y < d1y*d2x then ccw:=-1;
    if  d1x*d2y = d1y*d2x then
     begin
     if (abs(po.x)=abs(p1.x)) or ( abs(po.x)=abs(p2.x)) then ccw:=-1
     else
     if (abs(p1.x)<=min(abs(po.x),abs(p2.x)))
     or ((abs(p1.x)>min(abs(po.x),abs(p2.x)))
     and ((abs(p1.x)<abs(po.x)+abs(p2.x)-min(abs(po.x),abs(p2.x))))) then ccw:=1
     else ccw:=-1;
     end;
 end;

  function  intersext(l1,l2:lines):boolean;
  begin
      intersext:=((ccw(l1.x1,l1.x2,l2.x1)*ccw(l1.x1,l1.x2,l2.x2))<0)
      and ((ccw(l2.x1,l2.x2,l1.x1)*ccw(l2.x1,l2.x2,l1.x2))<0);

  end;

  function on_line(b:point):boolean;
  begin
     on_line:=true;
     if (l.x1.x-b.x)*(l.x2.y-b.y)=(l.x1.y-b.y)*(l.x2.x-b.x) then exit;
     on_line:=false;
   end;

  procedure  insides;
  var  i,dem:byte;tg:lines;
  begin
    l.x1.x:=xa;l.x1.y:=ya;
    l.x2.x:=maxx;l.x2.y:=ya;
    a[n+1]:=a[1];n:=n+1;
    dem:=0;
    for i:=1 to n do
     {if  (on_line(a[i])=false) and   (on_line(a[i+1])=false) then}
     begin
           tg.x1:=a[i];tg.x2:=a[i+1];
           if intersext(l,tg) then inc(dem);
     end;
     {else  inc(dem); }
     writeln(dem);
     if dem mod 2 =1 then writeln('diem nam trong da giac')
     else
     writeln('diem nam ngoai da gia');
  end;

  begin  clrscr;
  readfile;
  insides;
  readln
  end.
  4 2
  6
  0 0
  0 1
  1 2
  4 2
  5 0
  5 -8
  5 5
  4
  1 1
  6 1
  6 6
  1 1


