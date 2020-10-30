{$R-}
Program Bai159_Dayloi_TQA2K30PBC;
Uses Crt;
Const
     Dl                 =       'Dayloi.inp';
     Kq                 =       'Dayloi.out';
     Maxn               =       5001;
Type
    Arr1                =       Array [0..Maxn] of integer;
Var
   a, maxd1, maxd2      :       Arr1;
   tr1, tr2             :       arr1;
   n                    :       Integer;
   f                    :       Text;

Procedure Input;
Var
   i, j                 :       integer;
Begin
Assign(f, dl);
Reset(f);
Readln(f, n);
fillchar(a, sizeof(a), 0);
for i := 1 to n do
    read(f, a[i]);
Close(f);
Assign(f, kq);
Rewrite(f);
End;


Procedure KhoiTao;
Var
   i                    :       integer;
Begin
for i := 1 to n do maxd1[i] := 1;
maxd2 := maxd1;
fillchar(tr1, sizeof(tr1), 0);
tr2 := tr1;
End;


Procedure QHD(var u: integer);
Var
   i, j, t              :       Integer;
Begin
{maxd1[i] la so phan tu max cua day con dai nhat giam dan tu 1 toi i}
for i := 2 to n - 1 do
    for j := i - 1 downto 1 do
        if (a[i] < a[j]) and (maxd1[i] < maxd1[j] + 1) then
           begin
           maxd1[i] := maxd1[j] + 1; tr1[i] := j;
           end;
{maxd2[i] la so phan tu max cua day con dai nhat tang dan tu i toi n}
for i := n - 1 downto 2 do
    for j := i + 1 to n do
        if (a[i] < a[j]) and (maxd2[i] < maxd2[j] + 1) then
           begin
           maxd2[i] := maxd2[j] + 1; tr2[i] := j;
           end;
u := 0;  t := 0;
for i := 2 to n - 1 do
    if (maxd1[i] > 1) and (maxd2[i] > 1) and (t < maxd1[i] + maxd2[i]) then
       begin
       u := i;
       t := maxd1[i] + maxd2[i];
       end;
End;



Procedure Output;
Var
   i, j, u, dem         :       Integer;
Begin
QHD(u);
if u = 0 then writeln(f, 0)
else
    begin
    writeln(f, maxd1[u] + maxd2[u] - 1);
    fillchar(maxd1, sizeof(maxd1), 0);
    i := u;   dem := 0;
    repeat
          inc(dem);    maxd1[dem] := i;     i := tr1[i];
          until i = 0;
    for i := dem downto 1 do write(f, a[maxd1[i]], ' ');
    i := tr2[u];
    if i <> 0 then
       repeat
             write(f, a[i], ' ');        i := tr2[i];
             until i = 0;
    end;
Close(f);
End;

Begin
clrscr;
Input;
KhoiTao;
Output;
End.
