{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}
{thuat toan to mau do thi - thuat giai thamlam - Dung Mang Dong}
program dandenmau;
uses crt;
const
     dl         =       'Danden.in1p';
     kq         =       'Danden.ou1t';
     maxk       =       16000;
type
    toado       =       record
                        x, y: integer;
                        end;
    Mt1         =       array [1..maxk] of boolean;
    arr1        =       array [1..maxk] of integer;
    arr2        =       array [1..maxk] of toado;
var
   a            :       arr2;
   bac, d, ind  :       ^arr1;
   f            :       text;
   min          :       integer;
   m, n, k      :       integer;
   Time         :       Longint absolute 0000: $0046c;
   LuuTime      :       Longint;
   Pmark        :       pointer;

procedure input;
var
   i, j         :       integer;
begin
assign(f, dl);
reset(f);
readln(f, m, n, k);
fillchar(a, sizeof(a), 0);
for i := 1 to k do
    readln(f, a[i].x, a[i].y);
close(f);
assign(f, kq);
rewrite(f);
end;

procedure output;
var
   i, j         :       integer;
begin
writeln(f, min - 1);
for i := 1 to k do
    bac^[ind^[i]] := d^[i];
for i := 1 to k do
    writeln(f, bac^[i]);
close(f);
end;

function c(i, j: integer): boolean;
begin
c := (a[i].x = a[j].x) or (a[i].y = a[j].y);
end;

procedure Timbac;
var
   i, j         :       integer;
begin
fillchar(bac^, sizeof(bac^), 0);
for i := 1 to k - 1 do
    for j := i + 1 to k do
        if c(i,j) then
           begin
           inc(bac^[i]); inc(bac^[j]);
           end;
end;

procedure QuickSort(Lo, Hi: Integer);

procedure Sort(l, r: Integer);
var
  i, j, x, y: integer;
begin
  i := l; j := r; x := bac^[(l+r) DIV 2];
  repeat
    while bac^[i] > x do i := i + 1;
    while x > bac^[j] do j := j - 1;
    if i <= j then
    begin
      y := bac^[i]; bac^[i] := bac^[j]; bac^[j] := y;
      y := ind^[i]; ind^[i] := ind^[j]; ind^[j] := y;
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
   i, j         :       integer;
begin
New(bac); New(d); New(ind);
Timbac;
for i := 1 to k do
    ind^[i] := i;
Quicksort(1, k);
end;

procedure xuli;
var
   i, j         :       integer;
   u, v         :       integer;
   max          :       integer;
   ok           :       boolean;
begin
min := 0;
fillchar(d^, sizeof(d^), 0);
ok := true;
repeat
      inc(min);
      for i := 1 to k do
          if d^[i] = 0 then break;
      if (i = k) and (d^[k] <> 0) then break;
      d^[i] := min;
      for v := i + 1 to k do
          if (d^[v] = 0) and not c(ind^[i],ind^[v]) then d^[v] := min;
      for v := i + 1 to k do
          if d^[v] = min then
             for u := v + 1 to k do
                 if c(ind^[v],ind^[u]) and (d^[u] = min) then d^[u] := 0;
      until not ok;
end;


begin
Mark(Pmark);
Clrscr;
LuuTime := Time;
input;
khoitao;
xuli;
output;
Release(pmark);
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
{Readln;}
end.
4 5 13
1 1
1 2
1 5
3 1
4 1
3 2
2 3
3 3
4 3
2 4
4 4
2 5
4 5