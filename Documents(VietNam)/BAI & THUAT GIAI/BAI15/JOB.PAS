        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}
{thuat giai tham lam}
Program TQA2K30PBC;
Uses Crt;
Const
     Dl                 =       'Job.inp';
     Kq                 =       'Job.out';
     Maxn               =       10001;
Type
    Arr1                =       Array [0..Maxn] of word;
    Arr2                =       Array [1..Maxn] of boolean;
Var
   d, g, ind            :       Arr1;
   chon                 :       ^Arr2;
   n                    :       Integer;
   {max                  :       word;}
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
fillchar(d, sizeof(d), 0); {d la gio thu  -  g la gia tri dat duoc}
g := d;
for i := 1 to n do
    readln(f, d[i], g[i]);
Close(f);
Assign(f, kq);
Rewrite(f);
End;

procedure QuickSort(Lo, Hi: Integer);
{sap xep tang theo d[i] - neu d[i] = d[j] thi sap xep giam theo g}
var
   tg                   :       word;
procedure Sort(l, r: Integer);
var
  i, j      : integer;
  x, y      : word;
begin
  i := l; j := r; x := d[(l+r) Div 2]; y := g[(l+r) Div 2];
  repeat
    while (d[i] < x) or ((d[i] = x) and (g[i] > y)) do i := i + 1;
    while (x < d[j]) or ((d[j] = x) and (g[j] < y)) do j := j - 1;
    if i <= j then
    begin
      tg := d[i]; d[i] := d[j]; d[j] := tg;
      tg := g[i]; g[i] := g[j]; g[j] := tg;
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



Procedure KhoiTao;
Var
   i, j                 :       Integer;
Begin
for i := 1 to n do ind[i] := i;
quicksort(1, n); {sap xep mang d, g theo chieu tang cua d - thoi gian}
New(chon);
fillchar(chon^, sizeof(chon^), 0);
End;



Procedure Xuli;
Var
   i, j, u, luu, gh     :       Integer;
Begin
i := 1;
luu := 0;
repeat
      j := i;
      repeat
            inc(j);
            until (d[j] <> d[i]) or (j > n);
      for u := 1 to d[i] - luu do
          chon^[i + u - 1] := true;
      luu := luu + u;
      i := j;
      until (i > n);
End;

Procedure Output;
Var
   i, j                 :       Integer;
   max, dem             :       longint;
Begin
max := 0; dem := 0;
for i := 1 to n do
    begin if chon^[i] then max := max + g[i]; inc(dem); end;
writeln(f, max);
{writeln(f, dem);}
dem := 0;
for i := 1 to n do
    if chon^[i] then
       begin
       inc(dem);
       writeln(f,ind[i], ' ',dem);
       end;
Dispose(chon);
Close(f);
End;

Begin
clrscr;
LuuTime := Time;
Input;
KhoiTao;
Xuli;
Output;
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.
6
3 7
3 20
1 10
1 15
1 5
3 3
