        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}
Program TQA2K30PBC;
Uses Crt;
Const
     Dl         =       'robot.inp';
     Kq         =       'robot.out';
     Maxn       =       9;
     n          =       9;
     t          =       'TTTTTTTTT';
Type
    string9     =       string[9];
    Arr1        =       Array [1..maxn,0..maxn] of Byte;
    Arr2        =       Array [1..maxn] of Byte;
Var
   a            :       Arr1;
   f            :       Text;
   luu, min     :       arr2;
   dem, mind    :       integer;
   s            :       string9;
   Time         :       Longint absolute 0000: $0046c;
   LuuTime      :       Longint;

Procedure Input;
Var
   i, j         :       integer;
   k, code      :       integer;
Begin
Assign(f, dl);
Reset(f);
fillchar(a, sizeof(a), 0);
for i := 1 to n do
    begin
    readln(f, s);
    a[i,0] := length(s);
    for j := 1 to a[i,0] do
        begin
        val(s[j], k, code);
        a[i,j] := k;
        end;
    end;
readln(f,s);
Close(f);
Assign(f, kq);
Rewrite(f);
End;


Procedure KhoiTao;
Var
   i, j         :       Integer;
Begin
dem := 0;
mind := maxint;
fillchar(luu, sizeof(luu), 0);
min := luu;
End;

procedure quetvoi(var tg: string9; i: integer);
{quet phong voi trang thai "tg" boi robot i}
var
   j            :       integer;
begin
for j := 1 to a[i,0] do
    case tg[a[i,j]] of
         'T' :  tg[a[i,j]] := 'X';
         'X' :  tg[a[i,j]] := 'V';
         'V' :  tg[a[i,j]] := 'T';
         end;
end;

procedure process;
var
   i, j         :       integer;
   tg           :       string9;
begin
tg := s;
if dem >= mind then exit;
for i := 1 to n do
    if luu[i] <> 0 then
       for j := 1 to luu[i] do quetvoi(tg, i);
if tg = t then
      begin
      mind := dem;
      min := luu;
      end;
end;


Procedure Try(i : integer);
Var
   j            :       Integer;
Begin
if i > n then begin process; exit; end;
for j := 0 to 2 do
    begin
    luu[i] := j;
    dem := dem + j;
    if dem <= mind then try(i + 1);
    dem := dem - j;
    end;
End;

Procedure Output;
Var
   i, j         :       Integer;
Begin
if mind = maxint then write(f, 0)
else
    for i := 1 to n do
        for j := 1 to min[i] do
            write(f, i);
Close(f);
End;

Begin
clrscr;
LuuTime := Time;
Input;
KhoiTao;
Try(1);
Output;
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.
159
123
357
147
5
369
456
789
258
XVXVXVTXT