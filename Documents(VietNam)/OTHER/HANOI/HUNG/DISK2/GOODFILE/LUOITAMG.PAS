(* luoi tam giac *)

uses crt;
const cha:array[0..3] of char=('T','B','N','D');
var  n,p,s,t,t1a,luu3,luu4,ax,ay,dd:longint;
     f,f1:text;
     ch2,cx:longint;

procedure readfile;
begin
 writeln('INPUT:');
 assign(f,'luoi1.inp');
 reset(f);
 readln(f,n);
 writeln(n);
 readln(f,p);
 writeln(p);
 readln(f,s,t);t1a:=t;
 writeln(s,'  ',t);
 close(f);
 writeln('OUTPUT:')
end;

procedure xuli1;
var i,j,j1,p1,d,luu,k:longint;
begin
 p1:=p;
 if p>2*n*n then
 begin
   d:=p-2*n*n;
   k:=n;
   while d-(2*k-1)*2>0 do begin d:=d-(2*k-1)*2;dec(k);end;
   p:=d+2*(k-1)*(k-1);
  end;
 if p=0 then begin ax:=n;ay:=1;dd:=3;end
 else
 begin
 i:=trunc(sqrt(p div 2));
 if 2*i*i>=p then dec(i);d:=2*i*i+1;
 if d<=p then inc(i);luu:=d;
 dd:=(p-d) mod 4;
 if dd>=2 then begin dec(i);luu:=d+2;end;
 ax:=i;ay:=1;
 ax:=ax-(p-luu) div 4;
 ay:=ay+(p-luu) div 4;
 if p1>2*n*n then
  begin
   if dd>1 then dd:=dd-2
   else dd:=2+dd;
   d:=ax;
   ax:=n-ay+1;
   ay:=n-d+1;
  end;
 end;
 p:=p1;
end;

function so:longint;
var dem,d,d1,ax1,ay1,cx1:longint;
begin
if (ax+ay<=n) then
 begin
   dem:=ax+ay;
   if cx<=1 then dec(dem);
   d:=2*(dem-1)*(dem-1);
   d:=d+4*(dem-ax);
   if cx<=1 then d:=d+cx+1
   else if cx<=2 then dec(d);
 end
else
begin
if (ax+ay=n+1) then
 begin
   d:=2*(n-1)*(n-1);
   dem:=n;
   d:=d+4*(dem-ax);
   if cx<=1 then inc(d,1+cx)
   else  inc(d,cx+17);
 end
else
begin
 ax1:=n-ay+1;
 ay1:=n-ax+1;
   if cx<=1 then cx1:=cx+2
   else cx1:=cx-2;
   dem:=ax1+ay1;
   if cx1<=1 then dec(dem);
   d1:=2*(dem-1)*(dem-1);
   d1:=d1+4*(dem-ax1);
   if cx1<=1 then d1:=d1+cx1+1
   else if cx1<=2 then dec(d1);
  dem:=1;d:=4*n*n;
 while d1>0 do
  begin
   d:=d-2*(2*dem-1);
   if d1>2*(2*dem-1) then d1:=d1-2*(2*dem-1)
   else begin inc(d,d1);d1:=0;end;
   if d1>0 then inc(dem);
  end;
end;
end;
 so:=d;
end;

procedure  xuli2;
var d1,tg,d:longint;
begin
 d:=0;
 p:=t;
 xuli1;
 luu3:=ax;luu4:=ay;ch2:=dd;
 p:=s;
 xuli1;
 cx:=dd;
 if ax<luu3 then
 begin
      write(t,' ');t1a:=s;tg:=ax;ax:=luu3;
      luu3:=tg;tg:=ay;ay:=luu4;luu4:=tg;
      tg:=ch2;ch2:=cx;cx:=tg;
 end
 else write(s,'  ');
 repeat
  inc(d);
  if cha[cx]='D' then
   begin
    if ay>=luu4 then begin cx:=1;write(so,' ');end;
    if ay<luu4 then begin cx:=0;ay:=ay+1;write(so,' ') ;end;
   end
  else
  begin
  if  cha[cx]='T' then
   begin
    if luu4<ay then begin ay:=ay-1;cx:=3;write(so,' ');end
    else begin cx:=1;write(so,' ');end;
   end
  else
  begin
  if cha[cx]='N' then
   begin
    if luu4>ay then begin cx:=3;write(so,' ');end
    else begin cx:=0;write(so,' ');end;
   end
  else
  begin
  if cha[cx]='B' then
   begin
    if luu3<ax then begin ax:=ax-1;cx:=2;write(so,' ');end
    else
     begin
      if luu4>ay then begin cx:=3;write(so,' ');end
      else begin
      cx:=0;write(so,' ');end;
     end;
  end;
 end;
end;
end;
 until (ax=luu3) and (ay=luu4);

if cx<>ch2 then
begin
 inc(d);
 if cx+ch2=3 then
  begin
   if (cx=0) or (cx=3) then  cx:=1
   else cx:=0;
   write(so,' ');
   inc(d);
  end;
 write(t1a);
 end;
 writeln;
 writeln(d);
end;


begin  clrscr;
 readfile;
 xuli1;
 write(ax,' ',ay,' ',cha[dd]);readln;
 xuli2;
 readln
end.
50
61
914 2
5
72
6 19
1000
532113
46321 115

1000
32145
1846983     1

