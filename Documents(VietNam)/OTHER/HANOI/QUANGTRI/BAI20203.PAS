uses crt;
const fi='bo400.inp';
      fo='bo.out';
      max_Bo=10000;
      vocuc=maxlongint;
type maxXY=-10000..10000;
     diem=record
        x,y:maxXY;
          end;
     boXY=array[1..max_bo] of diem;
var N,minpos:0..max_bo;
     T:boXY;minXY:diem;
     step:longint;

Procedure readdata(filename:string);
var i:integer;
    f:text;
begin
  assign(f,filename);reset(f);read(f,N);
      writeln('so con bo la: ',n);
      for i:=1 to N do
  readln(f,T[i].X,T[i].Y);close(f);
end;

Procedure swap(var a,b:diem);
var tmp:diem;
begin
  tmp:=a; a:=b; b:=tmp;
end;

Procedure QsortY(var T:boXY;lo,hi:integer);
var i,j,mid:integer;
begin
   i:=lo;j:=hi;mid:=T[(lo+hi) div 2].Y;
   repeat
   while T[i].Y>mid do inc(i);
   while T[j].Y<mid do dec(j);
   if i<=j then
     begin swap(T[i],T[j]);inc(i);dec(j);end;
   until i>j;
  if lo<J then qsortY(T,lo,j);
  if hi>i then qsortY(T,i,hi);
End;

Procedure QsortX(var T:boXY;lo,hi:integer);
var i,j,mid:integer;
begin
   i:=lo;j:=hi;mid:=T[(lo+hi) div 2].X;
   repeat
   while T[i].X<mid do inc(i);
   while T[j].X>mid do dec(j);
   if i<=j then
     begin swap(T[i],T[j]);inc(i);dec(j);end;
  until i>j;
  if lo<J then qsortX(T,lo,j);
  if hi>i then qsortX(T,i,hi);
END;

procedure FindminXY(var minXY:diem);
var i:0..max_bo;
begin
    qsortY(T,1,N);
    writeln;
    minXY.Y:=T[(N+1) div 2].Y;
    qsortX(T,1,N);
    writeln;
    for i:=0 to n-1 do dec(T[i+1].X,i);
    QsortX(T,1,N);
    minXY.X:=T[(N+1) div 2].X;
end;

Procedure solve;
var i:1..max_bo;
begin
   findminXY(minXY);
   for i:=1 to N do
    inc(step,abs(T[i].X-minXY.X)+abs(T[i].Y-minXY.Y));
end;

Procedure output;
var f:text;
begin
  assign(f,fo);Rewrite(f);
  Write(f,step); close(f);
end;

BEGIN
   step:=0;
   clrscr;
   readdata(fi);
   Solve;
   output;
   readln;
END.