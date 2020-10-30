{$R-}
program TQA2K30;
uses crt;
const
     dl                 =       'km.inp';
     kq                 =       'km.out';
     maxn               =       101;
     maxk               =       5001;
type
    rec                 =       record
                                x      :        integer;
                                y      :        word;
                                z      :        longint;
                                end;
    arr1_1              =       array[0..maxn, 0..maxn] of longint;
    arr1_2              =       array[0..maxn, 0..maxn] of integer;
    arr2                =       array[0..maxk] of rec;
    arr3                =       array[0..maxk] of integer;
    arr4                =       array[0..maxk] of longint;
var
   a                    :       arr2;
   tr, ind              :       arr3;
   d                    :       ^arr4;
   c                    :       ^arr1_1;
   tg                   :       ^arr1_2;
   f                    :       text;
   n, k                 :       integer;
   m                    :       longint;
   Time                 :       Longint absolute 0000: $0046c;
   LuuTime              :       Longint;
   pmark                :       pointer;


procedure input;
var
   i, j                 :       integer;
begin
assign(f, dl);
reset(f);
readln(f, n, m, k);
fillchar(a, sizeof(a), 0);
for i := 1 to k do
    readln(f, a[i].x, a[i].y, a[i].z); {cua hang x tai thoi diem y tang qua z}
new(tg);
fillchar(tg^, sizeof(tg^), 0);
for i := 1 to n + 1 do
    begin
    for j := 1 to n + 1 do
        read(f, tg^[i,j]);
    readln(f);
    end;

new(c);
fillchar(c^, sizeof(c^), 0);
for i := 1 to n + 1 do
    begin
    for j := 1 to n + 1 do
        read(f, c^[i,j]);
    readln(f);
    end;
for i := 1 to n do
    begin
    c^[i,0] := c^[i,n+1];    c^[0,i] := c^[n+1,i];
    tg^[i,0] := tg^[i,n+1];  tg^[0,i] := tg^[n+1,i];
    end;
close(f);
assign(f, kq);
rewrite(f);
end;

procedure QuickSort(Lo, Hi: longint);
{sap xep tang theo thoi diem phat qua cua a[i].y}
procedure Sort(l, r: Integer);
var
  i, j, x, tg : longint;
  y           : rec;
begin
  i := l; j := r; x := a[(l+r) DIV 2].y;
  repeat
    while a[i].y < x do i := i + 1;
    while x < a[j].y do j := j - 1;
    if i <= j then
    begin
      y := a[i]; a[i] := a[j]; a[j] := y;
      tg := ind[i]; ind[i] := ind[j]; ind[j] := tg;
      i := i + 1; j := j - 1;
    end;
  until i > j;
  if l < j then Sort(l, j);
  if i < r then Sort(i, r);
end;

begin {QuickSort};
  Sort(Lo,Hi);
end;


procedure khoitao;
var
   i, j                 :       integer;
begin
for i := 1 to k do
    ind[i] := i;
quicksort(1, k);
a[k+1].x := n + 1;   a[k+1].y := m; a[k+1].z := 0;
new(d);
fillchar(d^, sizeof(d^), 0);
fillchar(tr, sizeof(tr), 0);
end;

procedure xuli;
var
   i, j                 :       integer;
begin
for i := 1 to k+1 do
       begin
       if a[0].y + tg^[0,a[i].x] <= a[i].y then
                                 d^[i] := a[i].z - c^[0,a[i].x];
       for j := i-1 downto 1 do
        if (a[j].y + tg^[a[j].x,a[i].x]  <= a[i].y) and (d^[j] <> 0) then
           if (d^[i] < d^[j] + a[i].z - c^[a[j].x,a[i].x])
              {or (d^[i] = 0)} then
              begin
              d^[i] := d^[j] + a[i].z - c^[a[j].x,a[i].x];
              tr[i] := j;
              end;
       end
end;


{Procedure Kiemtra(Var MauThuan, ddidung: boolean; dem: longint);
Var
   i, j         :       longint;
   tong         :       longint;
Begin
mauthuan := true;
ddidung := false;
fillchar(a[0], sizeof(a[0]), 0);
d^[dem+1] := 0;

tong := 0;
for i := dem downto 1 do
    begin
    write(i, ' ', d^[i+1], ' ', d^[i], '   ');
    if a[d^[i]].y < a[d^[i+1]].y + tg^[a[d^[i+1]].x,a[d^[i]].x] then
       exit
    else
        tong := tong + a[d^[i]].z - c^[a[d^[i+1]].x,a[d^[i]].x];
    writeln(tong, '         ', luu, '  ', dem, '  ', a[d^[i]].x);
    end;
ddidung := true;
End;}


procedure output;
var
   i, j, dem, u         :       integer;
{   t, ts                :       boolean;}
begin
writeln(f, d^[k+1]);
fillchar(d^, sizeof(d^), 0);
u := k + 1;
dem := 0;
repeat
      inc(dem);
      d^[dem] := u;
      u := tr[u];
      until u = 0;
for i := dem  downto 2 do
    writeln(f, ind[d^[i]]);
close(f);
{kiemtra(t, ts,dem);}
end;

begin {main}
clrscr;
mark(pmark);
LuuTime := Time;
input;
khoitao;
xuli;
output;
dispose(pmark);
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
readln;
end.
2 13 5
1 2 10
2 3 20
1 4 25
1 5 10
2 10 10
0 2 2
2 0 3
1 1 0
0 1 1
1 0 1
1 1 0