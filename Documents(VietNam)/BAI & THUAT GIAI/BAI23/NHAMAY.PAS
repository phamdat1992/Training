        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}

{lap lich thi cong cho nha may sao cho voi cac may dung han thi tong gia tri
la lon nhat}
Program TQA2K30PBC;
Uses Crt;
Const
     Dl                 =       'Nhamay.inp';
     Kq                 =       'Nhamay.out';
     Maxn               =       1000;
Type
    Arr1                =       Array [1..Maxn] of integer;
    Arr2                =       Array [0..Maxn] of boolean;
Var
   t, c, ind, td        :       Arr1;
   cx                   :       arr2;
   n                    :       Integer;
   f                    :       Text;
   Time                 :       Longint absolute 0000: $0046c;
   LuuTime              :       Longint;
   pmark                :       pointer;

Procedure Input;
Var
   i, j                 :       integer;
Begin
Assign(f, dl);
Reset(f);
Readln(f, n);
fillchar(t, sizeof(t), 0);
c := t;
for i := 1 to n do
    readln(f, t[i], c[i]);
Close(f);
Assign(f, kq);
Rewrite(f);
End;

procedure QuickSort(Lo, Hi: Integer);
{sap xep theo mang gia tri tu lon den nho}

procedure Sort(l, r: Integer);
var
  i, j, x, y: integer;
begin
  i := l; j := r; x := c[(l+r) DIV 2];
  repeat
    while c[i] > x do i := i + 1;
    while x > c[j] do j := j - 1;
    if i <= j then
    begin
      y := t[i]; t[i] := t[j]; t[j] := y;
      y := c[i]; c[i] := c[j]; c[j] := y;
      y := ind[i]; ind[i] := ind[j]; ind[j] := y;
      i := i + 1; j := j - 1;
    end;
  until i > j;
  if l < j then Sort(l, j);
  if i < r then Sort(i, r);
end;

begin {QuickSort};
  Sort(Lo,Hi);
end;


Procedure Xuli;
Var
   i, j, gh             :       Integer;
Begin
for i := 1 to n do ind[i] := i;
quicksort(1, n);
fillchar(td, sizeof(td), 0);
for i := 1 to n do
    begin
    gh := t[i];
    if gh > n then gh := n;
    while (td[gh] <> 0) and (gh > 0) do dec(gh);
    if gh = 0 then break;
    td[gh] := i;
    end;
End;

Procedure Output;
Var
   i, j, tong           :       Integer;
Begin
tong := 0;
fillchar(cx, sizeof(cx), 1);
cx[0] := false;
for i := 1 to n do
    if td[i] <> 0 then begin tong := tong + c[td[i]]; cx[i] := false; end;
writeln(f, tong);
j := 0;
for i := 1 to n do
    if td[i] = 0 then
       begin
       while not cx[j] and (j <= n) do inc(j);
       if j > n then break;
       td[i] := j;
       end;
for i := 1 to n do
    write(f, ind[td[i]], ' ');
Close(f);
End;

Begin
clrscr;
LuuTime := Time;
mark(pmark);
Input;
Xuli;
Output;
release(pmark);
gotoxy(1, 10);
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.
4
3 100
1 10
2 20
1 15
