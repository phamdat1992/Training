uses crt;
type  point=record
       x,y:integer;
       end;
 var  a:array[1..50] of point;
      f:text;
      n,luu:byte;

 procedure  readfile;
 var  i:byte;mins:integer;
 begin
 luu:=1;
 assign(f,'boc_goi.inp');
 reset(f);
 readln(f,n);
 for i:=1 to n do
 readln(f,a[i].x,a[i].y);

 close(f);
 writeln ('input');
 writeln(n);
 for i:=1 to n do writeln (a[i].x:4,a[i].y:4);
 end;

 function theta(i,j:byte):real;
 var  px1,px2,py1,py2,t:real;
 begin
 px1:=a[j].x-a[i].x;
 py1:=a[j].y-a[j].y;
 px2:=abs(px1);py2:=abs(py1);
 if (px1=0) and (py1=0) then t:=0
 else
  t:=py1/(px2+py2);
  if px1<0 then t:=2-t
  else
   if py1<0 then t:=4+t;
  theta:=t*90.0;
  end;

  procedure  boc_goi;
  var  mins,maxs:real;
       dem,i:byte;
       b:array[1..50] of byte;
  begin
   fillchar(b,sizeof(b),0);
    for i:=1 to n do
    if a[i].y< a[luu].y then  luu:=i;
    dem:=1;b[dem]:=luu;
    a[n+1]:=a[luu];
    maxs:=0;
    repeat
      inc(dem);
      mins:=maxs;
      maxs:=360;
      for i:=1 to n+1 do
       if (theta(luu,i)<=maxs) and (theta(luu,i)>mins) then
       begin maxs:=theta(luu,i);b[dem]:=i;
       end;
       luu:=b[dem];
    until luu=n+1;
    for i:=1 to dem do writeln(b[i]);
  end;

  begin  clrscr;
  readfile;
  boc_goi;
  readln
  end.
  5
  0 1
  4 4
  0 4
  4 0
  2 2










