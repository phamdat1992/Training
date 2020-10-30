{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}
Program TQA2K30PBC;
Uses Crt, graph;
Const
     Dl                 =       'Matphang.inp';
     Kq                 =       'Matphang.out';
     Maxn               =       31;
     h                  :       array [1..4, 1..2] of integer =
                                ((-1, 0), (0, -1), (1, 0), (0, 1));
Type
    point               =       record
                                x, y: integer;
                                end;
    hcnhat              =       record
                                tt, dp: point;
                                end;
    Arr1                =       Array [0..2*Maxn,0..2*Maxn] of integer;
    Arr2                =       array [1..2*maxn] of integer;
    arr3                =       array [1..maxn] of hcnhat;
Var
   hcn                  :       Arr3;
   lt                   :       arr1;
   x, y                 :       arr2;
   n, d, c, dem         :       Integer;
   f                    :       Text;
   Time                 :       Longint absolute 0000: $0046c;
   LuuTime              :       Longint;

procedure doicho(var x, y: integer);
var
   tg                   :       integer;
begin
tg := x; x := y; y := tg;
end;

Procedure Input;
Var
   i, j                 :       integer;
Begin
Assign(f, dl);
Reset(f);
Readln(f, n);
fillchar(hcn, sizeof(hcn), 0);
for i := 1 to n do
    begin
    readln(f, hcn[i].tt.x, hcn[i].tt.y, hcn[i].dp.x, hcn[i].dp.y);
    if hcn[i].tt.x > hcn[i].dp.x then doicho(hcn[i].tt.x, hcn[i].dp.x);
    if hcn[i].tt.y > hcn[i].dp.y then doicho(hcn[i].tt.y, hcn[i].dp.y);
    end;
Close(f);
Assign(f, kq);
Rewrite(f);
End;


procedure QuickSort(var dd: arr2; Lo, Hi: Integer);

procedure Sort(l, r: Integer);
var
  i, j, x, y: integer;
begin
  i := l; j := r; x := dd[(l+r) DIV 2];
  repeat
    while dd[i] < x do i := i + 1;
    while x < dd[j] do j := j - 1;
    if i <= j then
    begin
      y := dd[i]; dd[i] := dd[j]; dd[j] := y;
      i := i + 1; j := j - 1;
    end;
  until i > j;
  if l < j then Sort(l, j);
  if i < r then Sort(i, r);
end;

begin {QuickSort};
  Sort(Lo,Hi);
end;

function thuoc(i, j, k: integer): boolean;
{phan tu i,j thuoc hinh chu nhat k}
begin
thuoc := (hcn[k].tt.x<= x[i]) and (x[i + 1] <= hcn[k].dp.x)
         and (hcn[k].tt.y<= y[j]) and (y[j + 1] <= hcn[k].dp.y);
end;

procedure Loainhungphantubangnhau(var x: arr2; var d: integer);
var
   i, j, k              :       integer;
begin
i := 1;
repeat
      j := i;
      while (x[j] = x[i]) and (j <= d) do
            inc(j);
      dec(j);
      for k := 1 to d - j do
          x[i + k] := x[j + k];
      d := d - (j - i);
      inc(i);
      until i > d;
end;


Procedure KhoiTao;
Var
   i, j, k, m           :       Integer;
Begin
for i := 1 to n do
    begin
    x[2*i-1] := hcn[i].tt.x;    x[2*i] := hcn[i].dp.x;
    y[2*i-1] := hcn[i].tt.y;    y[2*i] := hcn[i].dp.y;
    end;
d := 2 * n;
quicksort(x, 1, d);
Loainhungphantubangnhau(x, d);
c := 2 * n;
quicksort(y, 1, c);
Loainhungphantubangnhau(y, c);
fillchar(lt, sizeof(lt), 0);
for i := 0 to d do
    begin lt[i,0] := -1; lt[i,c] := -1; end;
for i := 0 to c do
    begin lt[0,i] := -1; lt[d,i] := -1;end;

dec(d);
dec(c);
for i := 1 to d do
    for j := 1 to c do
        begin
        lt[i,j] := -1;
        for k := 1 to n do
            if thuoc(i, j, k) then begin lt[i,j] := 0; break; end;
        end;
dem := 0;
End;

function kiemtra(i, j, u, v: integer): boolean;
var
   sl                   :       integer;
begin
kiemtra := false;
for sl := 1 to n do
    if thuoc(i, j, sl) <> thuoc(u, v, sl) then exit;
kiemtra := true;
end;

procedure loangr(i, j: integer);
var
   u, v, k              :       integer;
begin
for k := 1 to 4 do
    begin
    u := i + h[k,1];
    v := j + h[k,2];
    if (lt[u,v] = 0) and kiemtra(i, j, u, v) then
       begin
       lt[u,v] := dem;
       loangr(u, v);
       end;
    end;
end;


Procedure Xuli;
Var
   i, j                 :       Integer;
Begin
for i := 1 to d do
    for j := 1 to c do
        if lt[i,j] = 0 then begin inc(dem); lt[i,j] := dem; loangr(i,j);end;
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


procedure Vehcnhat;
type
    Arr3                =       Array [1..4] of pointtype;
var
   i, j                 :       integer;
   dentax, dentay       :       integer;
   dpd                  :       integer;
   s                    :       string;
begin
{ve}
dpd := 5;
SetTextJustify(centertext, centertext);
setfillstyle(1, cyan);
dentax := 100;
dentay := 100;
setfillstyle(1, lightblue);
for i := 1 to n do
    begin
    hcn[i].tt.x := hcn[i].tt.x * dpd + dentax;
    hcn[i].tt.y := hcn[i].tt.y * dpd + dentax;
    hcn[i].dp.x := hcn[i].dp.x * dpd + dentax;
    hcn[i].dp.y := hcn[i].dp.y * dpd + dentax;
    end;

for i := 1 to d + 1 do x[i] := x[i] * dpd +dentax;
for i := 1 to c + 1 do y[i] := y[i] * dpd +dentay;
setcolor(0);
for i := 1 to n do
    begin
    Line(hcn[i].tt.x, hcn[i].tt.y, hcn[i].tt.x, hcn[i].dp.y);
    Line(hcn[i].dp.x, hcn[i].tt.y, hcn[i].dp.x, hcn[i].dp.y);
    Line(hcn[i].tt.x, hcn[i].tt.y, hcn[i].dp.x, hcn[i].tt.y);
    Line(hcn[i].tt.x, hcn[i].dp.y, hcn[i].dp.x, hcn[i].dp.y);
    end;

setfillstyle(1, n + 1);
for i := 1 to d do
    for j := 1 to c do
        if lt[i,j] > 0 then
           begin
           Str(lt[i,j], s);
           setfillstyle(1, lt[i,j]);
           Bar(x[i], y[j], x[i+1], y[j+1]);
{           line(x[i], y[j], x[i], y[j+1]);line(x[i+1], y[j], x[i+1], y[j+1]);
           line(x[i], y[j], x[i+1], y[j]);line(x[i], y[j+1], x[i+1], y[j+1]);}
{           Setcolor(white);}
           setfillstyle(1, dem + 1);
           fillellipse((x[i] + x[i+1]) div 2,(y[j] + y[j+1]) div 2, 7, 7);
           Outtextxy((x[i] + x[i+1]) div 2,(y[j] + y[j+1]) div 2, s);
           end;
setcolor(0);
for i := 1 to n do
    begin
{    setcolor(0);}
    Line(hcn[i].tt.x, hcn[i].tt.y, hcn[i].tt.x, hcn[i].dp.y);
    Line(hcn[i].dp.x, hcn[i].tt.y, hcn[i].dp.x, hcn[i].dp.y);
    Line(hcn[i].tt.x, hcn[i].tt.y, hcn[i].dp.x, hcn[i].tt.y);
    Line(hcn[i].tt.x, hcn[i].dp.y, hcn[i].dp.x, hcn[i].dp.y);
    end;
readln;
end;


Procedure Output;
Var
   i, j                 :       Integer;
Begin
writeln(f, dem);
Close(f);
End;

Begin
clrscr;
LuuTime := Time;
Input;
KhoiTao;
Xuli;
Output;
ktgraph;
vehcnhat;
closegraph;
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.
2
10 10 30 30
20 20 40 40 {3}
2
20 10 30 40
10 20 40 30 {5}
3
20 10 30 40
10 20 40 30
10 20 60 30 {6}

5
20 10 30 40
10 20 40 30
10 10 40 40 {9}
10 20 60 30
30  0 60 20 {11}

4
0  0 10 20
0 20 10 40
10 0 30 40
30 0 40 40 {4}