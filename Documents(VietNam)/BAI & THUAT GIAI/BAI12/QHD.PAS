        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}
{Ap dung quy hoach dong voi so nho de kiem tra}
Program BoTriPhongHop_TQA2K30PBC;
Uses Crt;
Const
     Dl         =       'Activity.inp';
     Kq         =       'Activity.out';
     Maxn       =       10000;
Type
    Arr1        =       Array [0..Maxn] of integer;
Var
   d, c         :       Arr1;
   dd           :       Arr1;
   ind, tr      :       ^arr1;
   n            :       Integer;
   f            :       Text;
   Time         :       Longint absolute 0000: $0046c;
   LuuTime      :       Longint;
   PMark        :       pointer;

Procedure Input;
Var
   i, j         :       integer;
Begin
Assign(f, dl);
Reset(f);
Readln(f, n);
For i := 1 to n do
    Readln(f, d[i], c[i]);
Close(f);
Assign(f, kq);
Rewrite(f);
End;


procedure QuickSort(Lo, Hi: Integer);
{Sap xep theo mang c}

procedure Sort(l, r: Integer);
var
  i, j, x, y, x1: integer;
begin
  i := l; j := r; x := c[(l+r) Div 2];  x1 := d[(l+r) Div 2];
  repeat
    while (c[i] < x) or ((c[i] = x) and (d[i] < x1)) do i := i + 1;
    while (x < c[j]) or ((c[j] = x) and (x1 < d[j])) do j := j - 1;
    if i <= j then
    begin
      y := c[i]; c[i] := c[j]; c[j] := y;
      y := d[i]; d[i] := d[j]; d[j] := y;
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



Procedure KhoiTao;
Var
   i, j         :       Integer;
Begin
Fillchar(dd, sizeof(dd), 0);
New(Ind); New(Tr);
Tr^ := dd;
For i := 1 to n do
    Ind^[i] := i;
Quicksort(1, n);
End;


Procedure Xuli;
Var
   i, j         :       Integer;
Begin
dd[1] := 1;
For i := 2 to n do
    Begin
    dd[i] := 1;
    For j := i - 1 downto 1 do
        if (d[i] >= c[j]) and (dd[i] < dd[j] + 1) then
           begin
           dd[i] := dd[j] + 1;
           Tr^[i] := j;
           end;
    End;
End;



Procedure Output;
Var
   i, j, u      :       Integer;
   max          :       integer;
Begin
u := 1;
For i := 2 to n do
    if dd[u] < dd[i] then u := i;
writeln(f, dd[u]);
Fillchar(dd, sizeof(dd), 0);
i := 0;
repeat
      Inc(i);
      dd[i] := u;
      u := tr^[u];
      until u = 0;
For j := i downto 1 do
    Write(f, ind^[dd[j]], ' ');
Close(f);
End;

Begin
clrscr;
Mark(PMark);
LuuTime := Time;
Input;
KhoiTao;
Xuli;
Output;
Release(PMark);
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.
