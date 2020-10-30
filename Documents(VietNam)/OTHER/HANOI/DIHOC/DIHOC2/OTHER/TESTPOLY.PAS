Program test_poly;
uses crt,graph;
const
    Fi='poly.inp';
	fo='poly.out';
type
    toado=record
         x,y:integer;
    end;
var
	a:array[1..10000] of toado;
    f:text;
    n,d,tx,ty,px,py:longint;
	i:integer;

procedure  readf;
var  i:integer;
begin
         assign(f,fi);
         {$I-}
         reset(f);
          if Ioresult<>0 then
          begin
               writeln('Khong co tep ra vao');
               halt;
          end;
         {$I+}

              readln(f,n);
              for i:=1 to n do readln(f,a[i].x,a[i].y);
              readln(f,tx,ty,px,py);
				n:=n+1;
              a[n]:=a[1];
         close(f);
end;

Procedure initgr;
var
 grDriver: Integer;
 grMode: Integer;
 ErrCode: Integer;
 f:text;
 so:integer;
 s:string;
begin
	assign(f,fo);
    reset(f);
    Readln(f,so);
    close(f);
 grDriver := Detect;
 InitGraph(grDriver, grMode,'i:\tp\bgi');
 ErrCode := GraphResult;

 if ErrCode = grOk then
 begin  { Do graphics }
     for i:=1 to n do
     begin
	 	a[i].x:=a[i].x*50-60;
        a[i].y:=a[i].y*50-60;
     end;

     setcolor(red);
     DrawPoly(n, a);

     setfillstyle(1,green);
     Bar(tx*50-60,ty*50-60,px*50-60,py*50-60);

     settextstyle(1,0,4);
     setcolor(blue);
     s:=chr(48+so);
	 outtextxy(10,10,'So hinh cua chuong trinh ban: ');
     setcolor(yellow);
     outtextxy(550,10,s);
	 readln;
     CloseGraph;
 end
 else
   Writeln('Graphics error:', GraphErrorMsg(ErrCode));
end;

BEGIN
    readf;
	initgr;
END.