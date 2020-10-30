        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}
Program TQA2K30PBC;
Uses Crt;
Const
     Dl                 =       'Agent.inp';
     Kq                 =       'Agent.out';
     Gh                 =       15000;
     ghchophep          =       10000;
     Maxn               =       50;
Type
    Arr1                =       Array [0..Maxn,0..Maxn] of integer;
    arr2                =       array [1..Gh] of integer;
    arr3                =       array [1..maxn] of integer;
Var
   c                    :       ^Arr1;
   q1, q2               :       arr2;
   sbd1, sbd2           :       ^arr2;   {so buoc di 1 - so buoc di 2}
   sll1, sll2           :       arr3;    {so lan lap 1 - so lan lap 2}
   n, vt1, vt2          :       Integer; {vi tri dau cua nguoi 1 - nguoi 2}
   dau1, cuoi1          :       integer;
   dau2, cuoi2          :       integer;
   found                :       boolean;
   demsbd               :       integer;
   f                    :       Text;
   Time                 :       Longint absolute 0000: $0046c;
   LuuTime              :       Longint;
   Pmark                :       pointer;

Procedure Input;
Var
   i, j, m, x, y        :       integer;
Begin
Assign(f, dl);
Reset(f);
Readln(f, n, m);
readln(f, vt1, vt2);
new(c);
fillchar(c^, sizeof(c^), 0);
for i := 1 to m do
    begin
    readln(f, x, y);
    inc(c^[x,0]);
    c^[x,c^[x,0]] := y;
    end;
Close(f);
Assign(f, kq);
Rewrite(f);
End;


Procedure KhoiTao;
Var
   i, j                 :       Integer;
Begin
dau1 := 1; cuoi1 := 1;  dau2 := 1; cuoi2 := 1;
fillchar(q1, sizeof(q1), 0);
fillchar(q2, sizeof(q2), 0);
q1[1] := vt1; q2[1] := vt2;
fillchar(sll1, sizeof(sll1), 0);
sll2 := sll1;
found := false;
New(sbd1); New(sbd2);
fillchar(sbd1^, sizeof(sbd1^), 0);
sbd2^ := sbd1^;
demsbd := 0;
End;

procedure loangr1(var dau1, cuoi1: integer; var stop1: boolean);
var
   i, j, u              :       integer;
   tmpd, tmpc           :       integer;
begin
tmpd := dau1; tmpc := cuoi1; dau1 := cuoi1 + 1;
stop1 := false;
for i := tmpd to tmpc do
    begin
    u := q1[i];
    for j := 1 to c^[u,0] do
        if cuoi1 < gh then
           begin
           inc(cuoi1);
           q1[cuoi1] := c^[u,j];
           inc(sll1[c^[u,j]]);
           if sll1[c^[u,j]] > ghchophep then stop1 := true;
           end
        else begin stop1 := true; exit; end;
    end;
if cuoi1 = tmpc then stop1 := true;
end;


procedure loangr2(var dau2, cuoi2: integer; var stop2: boolean);
var
   i, j, u              :       integer;
   tmpd, tmpc           :       integer;
begin
tmpd := dau2; tmpc := cuoi2; dau2 := cuoi2 + 1;
stop2 := false;
for i := tmpd to tmpc do
    begin
    u := q2[i];
    for j := 1 to c^[u,0] do
        if cuoi2 < gh then
           begin
           inc(cuoi2);
           q2[cuoi2] := c^[u,j];
           inc(sll2[c^[u,j]]);
           if sll2[c^[u,j]] > ghchophep then stop2 := true;
           end
        else begin stop2 := true; exit; end;
    end;
if cuoi2 = tmpc then stop2 := true;
end;

procedure kiemtra(dau1, cuoi1, dau2, cuoi2: integer; var found: boolean);
var
   i, j                 :       integer;
begin
for i := dau1 to cuoi1 do
    for j := dau2 to cuoi2 do
        if q1[i] = q2[j] then
           begin
           found := true;
           exit;
           end;
end;


Procedure Xuli;
{Loang theo lop}
Var
   i, j                 :       Integer;
   stop, stop1, stop2   :       boolean;
Begin

repeat
      inc(demsbd);
      loangr1(dau1, cuoi1, stop1);
      loangr2(dau2, cuoi2, stop2);
      kiemtra(dau1, cuoi1, dau2, cuoi2, found);
      if found then exit;
      stop := stop1 or stop2;
      until stop;
End;

Procedure Output;
Var
   i, j                 :       Integer;
Begin
if not found then writeln(f, 'No')
else
    begin
    writeln(f, 'Yes');
    writeln(f, demsbd);
    end;
Close(f);
End;

Begin
clrscr;
mark(Pmark);
LuuTime := Time;
Input;
KhoiTao;
Xuli;
Output;
release(Pmark);
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.
3 3
1 3
1 2
2 3
3 1

6 7
1 5
1 2
4 5
2 3
3 4
4 1
5 4
5 6

8 9
1 8
1 2
2 3
3 4
4 1
1 5
5 6
6 7
7 8
8 1