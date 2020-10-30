        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}
Program TQA2K30PBC;
Uses Crt, Graph;
Const
     Dl                 =       'Tao.in2p';
     Kq                 =       'Tao.ou2t';
     Maxn               =       4005;
Type
    point               =       record
                                      x, y  : integer;
                                      end;
    line_doan           =       record
                                      A, B: point;
                                      end;
    Arr1                =       Array [1..Maxn] of point;
    Arr2                =       Array [1..Maxn] of integer;
Var
   P, Tg                :       Arr1;     {Tg luu P de ve }
   Tro                  :       Arr2;
   n                    :       Integer;
   trentrai, duoiphai   :       point;
   Smax                 :       longint;
   f                    :       Text;
   Time                 :       Longint absolute 0000: $0046c;
   LuuTime              :       Longint;

Procedure Input;
Var
   i, j                 :       integer;
Begin
Assign(f, dl);
Reset(f);
Readln(f, n);
fillchar(p, sizeof(p), 0);
for i := 1 to n do
    readln(f, p[i].x, p[i].y);
Tg := p;
Close(f);
Assign(f, kq);
Rewrite(f);
End;

procedure QuickSort(Lo, Hi: Integer);

procedure Sort(l, r: Integer);
var
  i, j, x, y: integer;
  tg: point;
begin
  i := l; j := r; x := p[(l+r) DIV 2].x; y := p[(l+r) DIV 2].y;
  repeat
    while (p[i].x < x){ or ((p[i].x = x) and (p[i].y < y)) }do i := i + 1;
    while (x < p[j].x){ or ((p[j].x = x) and (p[j].y > y)) }do j := j - 1;
    if i <= j then
    begin
      tg := p[i]; p[i] := p[j]; p[j] := tg;
      i := i + 1; j := j - 1;
    end;
  until i > j;
  if l < j then Sort(l, j);
  if i < r then Sort(i, r);
end;

begin {QuickSort};
  Sort(Lo,Hi);
end;


Procedure KhoiTao;
Var
   i, j, k              :       Integer;
Begin
{tao them cac diem moi}
for i := 1 to n do
    begin
    p[i+n].x := 0; p[i+n].y := p[i].y;
    p[i+2*n].x := 1000; p[i+2*n].y := p[i].y;
    p[i+3*n].x := p[i].x; p[i+3*n].y := 0;
    p[i+4*n].x := p[i].x; p[i+4*n].y := 1000;
    end;
n := 5 * n;
p[n + 1].x := 0; p[n + 1].y := 0; p[n + 2].x := 0; p[n + 2].y := 1000;
p[n + 3].x := 1000; p[n + 3].y := 0; p[n + 4].x := 1000; p[n + 4].y := 1000;
n := n + 4;
{Sap xep }
quicksort(1, n); {theo hoanh do}
i := 1;
repeat
      j := i;
      while p[i].x = p[j].x do inc(j);
      j := j - 1;
      for k := i to j do tro[k] := j + 1;
      i := j + 1;
      until i > n;
Smax := 0;
P[n+1].x := 2000;
P[n+1].y := 2000;
End;


Procedure Xuli;
Var
   i, j, tren, duoi     :       Integer;
   a, b                 :       integer;
   found                :       byte;
   tg                   :       longint;
Begin
i := 1;
repeat
      j := tro[i] - 1; {xet nhung diem cung hoanh do}
      tren := 1000;
      duoi := 0;
      repeat
            found := 0;
            repeat
                  inc(j);
                  if (p[j].y >= p[i].y) and (p[j].y <= tren) then
                     begin found := 1; break; end;
                  if (p[j].y <= p[i].y) and (p[j].y >= duoi) then
                     begin found := 2; break; end;
                  until j >= n;
            if found <> 0 then
               begin
{               if (i = n) then writeln(j);}
               Tg := (p[j].x - p[i].x);
               Tg := Tg * (tren - duoi);
               if Smax < tg then
                  begin
                  Smax := tg;
                  trentrai.x := p[i].x;   trentrai.y := duoi;
                  duoiphai.x := p[j].x;   duoiphai.y := tren;
                  end;
               if found = 1 then tren := p[j].y
               else              duoi := p[j].y;
               end;
            until j >= n;
      inc(i);{i := tro[i];}
      until i > n;
End;


procedure ktgraph;
var
   gd, gm               :       integer;
begin
{Khoi tao graph}
gd := detect;
initgraph(gd, gm,'');
if graphresult <> 0 then
   begin
   writeln(' Co loi do hoa');
   Halt(1);
   end;
end;

procedure Vedagiac;
type
    Arr3                =       Array [1..4] of pointtype;
var
   i, gd, gm            :       integer;
   xmin, xmax, ymin,ymax:       real;
   dentax, dentay       :       integer;
   M1                   :       point;
   s, st                :       string;
   tren , duoi          :       point;
   dophongdai, tmp      :       real;
begin
Dophongdai := 0.4;
{ve}
SetTextJustify(centertext, centertext);
setfillstyle(1, cyan);
dentax := 320 - 200;
dentay := 240 - 200;

Bar(dentax, dentay, 400 + dentax, 400 + dentay);

tren.x := trunc(trentrai.x * dophongdai) + dentax;
tren.y := trunc(trentrai.y * dophongdai) + dentay;
duoi.x := trunc(duoiphai.x * dophongdai) + dentax;
duoi.y := trunc(duoiphai.y * dophongdai) + dentay;
setfillstyle(1, lightblue);
Bar(tren.x, tren.y, duoi.x, duoi.y);

{ve dinh}
n := (n - 4) div 5;
for i := 1 to n do
    begin
    tg[i].x := trunc(tg[i].x * dophongdai) + dentax;
    tg[i].y := trunc(tg[i].y * dophongdai) + dentay;
    end;
{Setcolor(red);
For i := 1 to n do
    begin
    Line(Tg[i].x, dentay, Tg[i].x, 400 + dentay);
    Line(dentax, Tg[i].y, 400 + dentax, Tg[i].y);
    end;}
setfillstyle(1, red);
Setcolor(white);
for i := 1 to n do
    begin
    Str(i, s);
    fillellipse(Tg[i].x, Tg[i].y, 7, 7); {ve hinh elip co to dac}
    Outtextxy(Tg[i].x, Tg[i].y, s);
    end;

Str(Smax, S);
S := 'Dien tich lon nhat tim duoc :  ' + S;
Outtextxy(150, 10, s);
str(trentrai.x, s); str(trentrai.y, st);
if length(s) < 3 then for i := 1 to 3 - length(s) do s := '0' + s;
if length(st) < 3 then for i := 1 to 3 - length(st) do st := '0' + st;
s := 'Toa do dinh tren trai       : ' + s + ' ' + st;

Outtextxy(150, 20, s);
str(duoiphai.x, s); str(duoiphai.y, st);
if length(s) < 3 then for i := 1 to 3 - length(s) do s := '0' + s;
if length(st) < 3 then for i := 1 to 3 - length(st) do st := '0' + st;
s := 'Toa do dinh duoi phai       : ' + s + ' ' + st;
Outtextxy(150, 30, s);
{}
readln;
end;


Procedure Output;
Var
   i, j                 :       Integer;
Begin
writeln(f, Smax);
Writeln(f, trentrai.x,' ',trentrai.y);
Writeln(f, duoiphai.x,' ',duoiphai.y);
Close(f);
End;

Begin
clrscr;
LuuTime := Time;
Input;
KhoiTao;
Xuli;
Output;
ktGraph;
Vedagiac;
closegraph;
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.
