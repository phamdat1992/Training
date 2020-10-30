{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 65384,0,655360}
        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {*                       30 - 4 - V                        *}
        {***********************************************************}
{Doi co}
Program TQA2K30PBC;
Uses Crt;
Const
     Dl         =       'chess.inp';
     Kq         =       'chess.out';
     Maxn       =       1000;
Type
    Arr1        =       Array [1..Maxn] of integer;
Var
   a, b, x      :       Arr1;
   da, db       :       Arr1;
   n            :       Integer;
   f            :       Text;
   Time         :       Longint absolute 0000: $0046c;
   LuuTime      :       Longint;

Procedure Input;
Var
   i, j         :       integer;
Begin
Assign(f, dl);
Reset(f);
Readln(f, n);
For i := 1 to n do
    Begin
    Readln(f, a[i], b[i]);
    End;
Close(f);
Assign(f, kq);
Rewrite(f);
End;


Procedure QuickSort(var a, da: arr1; Lo, Hi: Integer);
          procedure Sort(l, r: Integer);
          Var
                i, j, x, y      : integer;
          Begin
          i := l; j := r; x := a[(l+r) DIV 2];
          repeat
                while a[i] < x do i := i + 1;
                while x < a[j] do j := j - 1;
                if i <= j then
                   begin
                   y := a[i]; a[i] := a[j]; a[j] := y;
                   y := da[i]; da[i] := da[j]; da[j] := y;
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
fillchar(x, sizeof(x), 0);
for i := 1 to n do
    da[i] := i;
db := da;

{Sap xep tang}
Quicksort(a, da, 1, n);
Quicksort(b, db, 1, n)
End;


Procedure Xuli;
Var
   i, j, dau    :       Integer;
   tam, sl      :       integer;
   cuoi         :       integer;
   found        :       boolean;
Begin
dau := 1;
cuoi := n;
For i := 1 to n do
    Begin
    if b[i] > a[dau] then
       begin
       x[dau] := i;
       inc(dau);
       end
    else
        begin
        {neu b[i] <= a[dau] thi xet cap hoa nhau (a[j], b[x[j]])truoc do
        va hoan doi cho nhau thanh cac cap (a[j], b[i]) va cap dau
        (a[sl], b[x[j]]) voi sl la so lon nhat cua day a nhung chua cap -
        con a[dau] de do - chua cap voi so nao ca}
        found := false;
        for j := 1 to dau - 1 do
            if (a[j] = b[x[j]]) and (b[i] > a[j]) then
               begin
               {doi cap}
               tam := x[j];
               x[j] := i;
               x[cuoi] := tam;
               dec(cuoi);
               found := true;
               break;
               end;
        if not found then
           if b[i] < a[dau] then begin x[cuoi] := i; dec(cuoi); end
           else                  begin x[dau] := i; inc(dau); end;
        end;
    End;
End;

Procedure Output;
Var
   i, j, t      :       Integer;
   tmp          :       arr1;

Begin
t := 0;
For i := 1 to n do
    Begin
    if b[x[i]] > a[i] then inc(t, 2)
    else if b[x[i]] = a[i] then
         begin
         inc(t, 1);
         writeln(b[x[i]], ' ', a[i], ' ', i, ' ', x[i]);
         end
    End;
Writeln(f, t);
tmp := x;

for i := 1 to n do
    begin
    x[da[i]] :=tmp[i];
    end;
for i := 1 to n do
    x[da[i]] := db[x[da[i]]];

{kiemtra := true;
for i := 1 to n do
    for j := 1 to n do
        if (i <> j) and (x[i] = x[j]) then kiemtra := false;}

For i := 1 to n do
    Write(f, x[i], ' ');

Writeln(f);
Writeln(f);
For i := 1 to n do
    Writeln(f, a[i], ' ',b[tmp[i]]);
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
4
7 8
5 6
4 3
9 4

7 {12}
2 6
9 7
3 4
5 5
4 3
7 9
6 2

7 {8}
2 12
2 7
14 15
14 12
27 12
27 7
27 15

12 {20}
2 3
2 4
6 5
3 6
5 12
11 69
87 1
5 5
3 2
2 5
11 7
23 8