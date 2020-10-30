program bamau;
Const
     fi='tricolor.inp';
     Fo='tricolor.out';
     maxn=1000;
Type
    kpt = record
        x1,y1,x2,y2,mau:integer;
        sl:integer;
    end;
Var
   a:array[1..maxn] of kpt;

   i,j,m,n:integer;
   m1,b1,c1,d1,e1,b,c,d,e:integer;

Procedure init;
begin
     Fillchar(a,sizeof(a),0);
     n:=0;
     m1:=2;
     b1:=4;
     c1:=0;
     d1:=8;
     e1:=4;
end;

Function catnhau(a,b:kpt):boolean;
begin
     catnhau:=true;
     If (a.x2<=b.x2) and (b.x1<=a.x2) and (a.y2>=b.y1) and (a.y2<=b.y2) then exit;

     If (a.x1<=b.x2) and (a.x1>=b.x1) and (a.y2>=b.y1) and (a.y2<=b.y2) then exit;

     if (a.x1<=b.x2) and (a.x1>=b.x1) and (a.y1>=b.y1) and (a.y1<=b.y2) then exit;

     If (a.x2<=b.x2) and (b.x1<=a.x2) and (a.y1>=b.y1) and (a.y1<=b.y2) then exit;
     catnhau:=false;
end;

Procedure giaonhau(a,b:kpt;var giao:kpt);
begin
     If not catnhau(a,b) then
     begin
          giao.x1:=0;giao.y1:=0;
          giao.x2:=0;giao.y2:=0;
          giao.sl:=0;
          exit;
     end;

     If (a.x2<=b.x2) and (b.x1<=a.x2) and (a.y2>=b.y1) and (a.y2<=b.y2) then
     begin
          giao.x1:=b.x1; giao.y1:= b.y1; giao.x2:=a.x2 ;giao.y2:=a.y2;
          giao.sl:=a.sl+b.sl+1;
          exit;
     end;

     If (a.x1<=b.x2) and (a.x1>=b.x1) and (a.y2>=b.y1) and (a.y2<=b.y2) then
     begin
          giao.x1:=b.x1; giao.y1:= a.y1; giao.x2:= a.x2;giao.y2:=b.y2;
          giao.sl:=a.sl+b.sl+1;
          exit;
     end;

     if (a.x1<=b.x2) and (a.x1>=b.x1) and (a.y1>=b.y1) and (a.y1<=b.y2) then
     begin
          giao.x1:=a.x1; giao.y1:= a.y1; giao.x2:=b.x2 ;giao.y2:=b.y2 ;
          giao.sl:=a.sl+b.sl+1;
          exit;
     end;

     If (a.x2<=b.x2) and (b.x1<=a.x2) and (a.y1>=b.y1) and (a.y1<=b.y2) then
     begin
          giao.x1:=a.x1; giao.y1:=b.y1; giao.x2:=b.x2 ;giao.y2:=a.y1;
          giao.sl:=a.sl+b.sl+1;
          exit;
     end;
end;

Procedure xuly;
Var
   giao:kpt;
   i,j,k:integer;
begin
     writeln;
     writeln;
     for i:=1 to n-1 do
     begin
          giao:=a[i];
          for j:=i+1 to n do
          begin
               giaonhau(giao,a[j],giao);

               Writeln('Phan giao: ');
               writeln(giao.x1,' ',giao.y1,' ',giao.x2,' ',giao.y2,' ',giao.sl);
               readln;
          end;
     end;
end;

Procedure main;
var
   f:text;
begin
     assign(f,fi);
     reset(f);

     Init;

     while not eof(f) do
     begin
          readln(f,m,b,c,d,e);
          if (m<>-1) and (b<>-1) and (c<>-1) and (d<>-1) and (e<>-1) then
          begin
               inc(n);
               a[n].x1:=m;a[n].y1:=b;a[n].x2:=c;a[n].y2:=d;a[n].mau:=e;
               a[n].sl:=0;
          end
          else
          begin
               Xuly;
               Init;
          end;
     end;

     close(f);
end;

Procedure done;
begin
end;

BEGIN
     Init;
     Main;
     Done;
END.
0 0 4 4 1
1 1 5 2 2
1 1 2 5 3
-1 -1 -1 -1 -1
-1 -1 -1 -1 -1

0 4 4 1 1
1 1 5 2 2
1 1 2 5 3
-1 -1 -1 -1 -1
0 0 2 2 1
1 1 3 3 2
2 2 4 4 3
-1 -1 -1 -1 -1
-1 -1 -1 -1 -1
