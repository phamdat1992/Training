Program hinh_hoc;
uses crt;
type
    point=record
     x,y:integer;
     end;
    line=record
     p1,p2:point;
    end;
Var
   diem:point;
   dt:line;
   tg:array[0..11] of point;
   n,i,j,k,l:integer;


Function ccw(p0,p1,p2:point):integer;
Var dx1,dx2,dy1,dy2:integer;
Begin
     dx1:=p1.x;dy1:=p1.y-p0.y;
     dx2:=p2.x;dy2:=p2.y-p0.y;

     if dx1*dy2>dy1*dx2 then ccw:=1;
     if dx1*dy2<dy1*dx2 then ccw:=-1;
     if dx1*dy2=dy1*dx2 then
     begin
          if (dx1*dx2<0) or (dy1*dy2<0) then ccw:=-1
          else
          if (dx1*dx1+dy1*dy1)>=(dx2*dx2+dy2*dy2) then ccw:=0 else ccw:=1;
     end;
End;

Function catnhau(l1,l2:line):boolean;
begin
     catnhau:=((ccw(l1.p1,l1.p2,l2.p1)*ccw(l1.p1,l1.p2,l2.p2))<=0) and
     ((ccw(l2.p1,l2.p2,l1.p1)*ccw(l2.p1,l2.p2,l1.p2))<=0);
end;

Function namtrong(t:point):boolean;
var
   count,i,j:integer;
   lt,lp:line;
Begin
     count:=0;j:=0;tg[0]:=tg[n];tg[n+1]:=tg[1];
     lt.p1:=t;lt.p2:=t;lt.p2.x:=maxint;
     for i:=1 to n do
     begin
          lp.p1:=tg[i];lp.p2:=tg[i];
          if not catnhau(lp,lt) then
          begin
               lp.p2:=tg[j];
               j:=i;
          end;
          if catnhau(lp,lt) then count:=count+1;
     end;
     namtrong:=((count mod 2)=1);
End;
Begin
     clrscr;
     write('nhap n: ');
     readln(N);
     for i:=1 to n do
     begin
          write('Nhap tg[',i,'x,y:=');
          readln(tg[i].x,tg[i].y);
     end;

     writeln('Nhap diem i,j: ');
     readln(diem.x,diem.y);
     writeln(namtrong(diem));
End.