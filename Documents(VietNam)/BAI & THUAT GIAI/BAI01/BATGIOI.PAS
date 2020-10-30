        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {*                       30 - 4 - V                        *}
        {***********************************************************}
{Phuong phap duyet}
Program TQA2K30PBC;
Uses Crt;
Const
     Dl         =       'Bg.in0p';
     Kq         =       'Bg.out';
     Maxn       =       101;
Type
    toado       =       record
                        x, y  : integer;
                        end;
    Arr1        =       Array [0..Maxn] of toado;
    Arr2        =       Array [1..Maxn, 1..Maxn] of byte;
    Arr3        =       Array [1..Maxn] of integer;
    Arr4        =       Array [1..Maxn] of boolean;
Var
   d1, d2       :       Arr1;   {toa do cac diem hap dan - cac diem tam tang}
   a            :       Arr2;
   dd, dt       :       Arr3;  {mang luu cac diem hap dan - mang tam}
   max, dem     :       integer; {tong luu nhieu nhat - tong tam cac diem hd}
   m, n         :       Integer;
   chxcot       :       Arr4;   {chuaxetcot - luu cot da duyet}
   f            :       Text;
   Time         :       Longint absolute 0000: $0046c;
   LuuTime      :       Longint;

Procedure Input;
Var
   i, j         :       integer;
Begin
Assign(f, dl);
Reset(f);
Readln(f, n, m);
for i := 1 to n do
    begin
    read(f, d1[i].x);
    read(f, d1[i].y);
    end;
{readln(f);}
for i := 1 to m do
    read(f, d2[i].x, d2[i].y);
Close(f);
Assign(f, kq);
Rewrite(f);
End;


Procedure KhoiTao;
Var
   i, j         :       Integer;
Begin
fillchar(a, sizeof(a), 0);
dem := 0;
max := 0;
fillchar(dd, sizeof(dd), 0);
dt := dd;
n := n - 1;
fillchar(chxcot, sizeof(chxcot), 1);
End;

Function kc(x1, y1, x2, y2: integer): real;
Var
   i, j         :       longint;
   t            :       real;
Begin
i := x1 - x2;
i := sqr(i);
j := y1 - y2;
j := sqr(j);
t := sqrt(i + j);
kc := t;
End;

Procedure TaoGraph;
Var
   i, j         :       integer;
   t, t1, t2    :       real;
Begin
{n - diem di cua tam tang - so hang cua do thi la: n - 1}
For i := 1 to n do
    begin
    t := 2 * kc(d1[i].x, d1[i].y, d1[i+1].x, d1[i+1].y);
    for j := 1 to m do
        begin
        t1 := kc(d1[i].x, d1[i].y, d2[j].x, d2[j].y);
        t2 := kc(d1[i+1].x, d1[i+1].y, d2[j].x, d2[j].y);
        if t >= t1 + t2 then    a[i,j] := 1;
        end;
    end;
End;

Procedure update;
begin
if max < dem then
   begin
   max := dem;
   dd := dt;
   end;
end;



Procedure Try(i: integer);
{ duyet theo hang cua do thi}
var
   j            :       integer;
begin
for j := 1 to m do
    if (a[i,j] = 1) and chxcot[j] then
       begin
       inc(dem);
       dt[i] := j;
       chxcot[j] := false;
       if i = n then   update
       else            try(i + 1);
       chxcot[j] := true;
       dt[i] := 0;
       dec(dem);
       end;
{khong xet cot nay }
if i = n then update
else
    try(i + 1);
end;


Procedure Output;
Var
   i, j         :       Integer;
Begin
Writeln(f, max + n + 1);
For i := 1 to n do
    begin
    Write(f, d1[i].x, ' ', d1[i].y, ' ');
    if dd[i] <> 0 then
       Write(f, d2[dd[i]].x, ' ', d2[dd[i]].y, ' ');
    end;
Writeln(f, d1[n+1].x, ' ', d1[n+1].y);
Close(f);
End;

Begin
clrscr;
LuuTime := Time;
Input;
KhoiTao;
TaoGraph;
Try(1);
Output;
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.

4 5
1 4 5 7 5 2 -2 4
-4 -2 3 9 1 2 -1 3 8 -3