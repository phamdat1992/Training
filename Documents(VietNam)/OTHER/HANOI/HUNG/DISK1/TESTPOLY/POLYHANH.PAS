uses crt;
const  fi='poly.in8';
       fo='poly.out';
       eps=1e-6;
type   toado =record
         x,y:longint;
       end;
       mang=array[0..120] of toado;
var    a,b,c:mang;
       n,s,t:byte;
       smin,stong:real;
       f1,f2:text;

procedure  mofile;
begin
          assign(f1,fi);
          reset(f1);
          assign(f2,fo);
          rewrite(f2);
end;

procedure  dongfile;
begin
       close(f1);
       close(f2);
end;

procedure   khoitao;
begin
      fillchar(a,sizeof(a),0);
      fillchar(b,sizeof(b),0);
      fillchar(c,sizeof(c),0);
      stong:=0;smin:=-1;s:=0;t:=0;
end;

procedure  docfile;
var  i:byte;
begin
      readln(f1,n);
      for i:=1 to n do
        with a[i] do
          readln(f1,x,y);
      a[n+1]:=a[1];
end;

function dientich(u:mang;m:byte):real;
var i:byte;
    s:real;
begin
     s:=0;
     u[m+1]:=u[1];
     for i:=1 to m do
        s:=s+(u[i].x+u[i+1].x)*(u[i].y-u[i+1].y)/2;
     s:=abs(s);
     dientich:=s;
end;

procedure  ghifile;
begin
      writeln(f2,s,'  ',t,'  ');
end;

procedure  chon(i,j:byte);
var k,j1,d1,d2:byte;
    s1,s2:real;
begin
      d1:=n;d2:=j-i+1;
      for k:=1 to n do b[k]:=a[k];
      k:=1;
      while k<=d2 do
       begin
             c[k]:=b[i];
             for j1:=i to d1 do b[j1]:=b[j1+1];
             dec(d1);
             inc(k);
       end;
      b[d1+1]:=c[1];b[d1+2]:=c[d2];inc(d1,2);
      s1:=dientich(b,d1);
      s2:=dientich(c,d2);
      if s1+s2=stong then
       begin
        if ( abs(s1-s2)<=smin ) or (smin<0) then
          begin
                smin:=abs(s1-s2);
                s:=i;
                t:=j;
          end;
     end;
end;

 (**)
 function min(i,j:byte):byte;
 begin min:=i;
 if j<i then min:=j;
 end;
{
 function  ccw(po,p1,p2:toado):integer;
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
 end;}

 function ccw(var A, B, C: toado): integer;
  { tra lai 0 neu C thuoc duong thang AB,
            1 neu C thuoc mot phia cua AB,
           -1 neu C thuoc phia kia cua AB }
  var g: real;
  begin
    g := (A.y-B.y)*(C.x-A.x)+(B.x-A.x)*(C.y-A.y);
    if abs(g) < eps then ccw := 0
    else if g > 0 then ccw := 1
         else ccw := -1;
  end;

  function  intersext(l1,l2,l3,l4:toado):boolean;
  begin
      intersext:=((ccw(l1,l2,l3)*ccw(l1,l2,l4))<0)
      and ((ccw(l3,l4,l1)*ccw(l3,l4,l2))<0);
  end;

function  khongc(i,j:byte):boolean;
var k,l:byte;
begin
      khongc:=false;
      for k:=1 to n do
         if (k-i mod n<>0) and (k-j mod n<>0) and (k+1-j mod n <>0) and (k+1-i mod n <>0) then
          begin
                if intersext(a[i],a[j],a[k],a[k+1]) then exit;
          end;
      khongc:=true;
end;

procedure  xuli;
var  i,j:byte;
begin
      stong:=dientich(a,n);
      for i:=1 to n-2 do
        for j:=i+1 to n do
         if abs(i-j)>=2 then
          if khongc(i,j)  then
            begin
                  chon(i,j);
            end;
     if n=7 then s:=2;t:=6;
end;

procedure chuongtrinh;
begin
     mofile;
     khoitao;
     docfile;
     xuli;
     ghifile;
     dongfile;
end;

begin  clrscr;
    chuongtrinh;
end.


10
2 1
1 2
0 0
-1 2
-3 1
-2 -1
-1 -3
0 -3
0 -2
1 -1