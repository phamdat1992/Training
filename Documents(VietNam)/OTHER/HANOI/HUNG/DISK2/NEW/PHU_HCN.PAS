 uses crt;
 type point=record
        x,y:integer;
        end;
     hcn=record
      dt,dd:point;
      end;
     mang=array[1..50] of hcn;

 var  a:mang;
      n:byte;
      maxh,maxt,mint,minh:longint;
      f:text;

 procedure  readfile;
 var  i:byte;
 begin
   maxt:=0;maxh:=0;mint:=maxint;minh:=maxint;
   assign(f,'inp.txt');
   reset(f);
   readln(f,n);
   writeln('input:');
   writeln(n);
   for i:=1 to n do
    with a[i] do
    begin
    readln(f,dd.x,dd.y,dt.x,dt.y);
    writeln(dd.x:6,dd.y:6,dt.x:6,dt.y:6);
    if dt.x>maxh then maxh:=dt.x;
    if dt.y>maxt then maxt:=dt.y;
    if dd.x<minh then minh:=dd.x;
    if dd.y<mint then mint:=dd.y;
    end;
    close(f);
    writeln('output:');
    writeln(minh:6,mint:6,maxh:6,maxt:6);
 end;

 function  ok(i,j:integer):boolean;
 var d:byte;
 begin
    ok:=true;
    for d:=1 to n do
     with a[d] do
      if (dd.x<=i) and(dd.y<=j) and (dt.x>=i+1) and(dt.y>=j+1) then exit;
     ok:=false;
  end;

  procedure  xuli;
  var  i,j,dem:longint;
  begin
   dem:=0;
   for i:=minh to maxh do
    for j:=mint to maxt do
     if ok(i,j) then inc(dem);
    writeln((maxh-minh)*(maxt-mint)-dem);
    end;

  BEGIN  clrscr;
  readfile;
  xuli;
  readln
  END.
  5
  0 0 10 10
  3 0 8 7
  -7 3 12 4
  2 5 4 6
  -1 0 0 8

  6
  0 0 7 10
  2 0 8 7
  -5 3 2 9
  4 5 8 6
  100 100 200 200
  -9 -9 -8 -7
