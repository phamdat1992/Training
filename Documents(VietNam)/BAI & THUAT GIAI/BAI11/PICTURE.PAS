Program TreoTranh_TQA2K30PBC;
Uses Crt;
Const
     Dl         =       'Picture.inp';
     Kq         =       'Picture.out';
     Maxn       =       50;
     maxm       =       1500;
Type
    Arr1        =       Array [0..Maxm] of byte;
    Arr2        =       Array [0..Maxm] of integer;
    Mt1         =       Array [0..Maxn] of ^Arr1;
    Mt2         =       Array [0..Maxn] of ^Arr2;
    Arr3        =       Array [0..Maxn] of integer;
Var
   c            :       arr1;
   v            :       Mt1;  {kieu byte}
   p            :       Mt2;  {kieu integer}
   luu, ind     :       arr3;
   n, m         :       Integer;
   max, o_cua   :       integer;
   f            :       Text;
   Time         :       Longint absolute 0000: $0046c;
   LuuTime      :       Longint;
   pmark        :       pointer;

Procedure Input;
Var
   i, j         :       integer;
Begin
Assign(f, dl);
Reset(f);
Readln(f, n, m);

for i := 1 to n do
    read(f, c[i]);
readln(f);
for i := 1 to n do
    begin
    new(v[i]);
    fillchar(v[i]^, sizeof(v[i]^), 0);
    for j := 1 to m do
        read(f, v[i]^[j]);
    readln(f);
    end;
Close(f);
Assign(f, kq);
Rewrite(f);
End;

Procedure Quyhoachdong(u: integer);
Var
   i, j, k      :       integer;
Begin
{for i := 0 to u - 1 do ind[i] := i;
for i := u to n - 1 do ind[i] := i + 1;}

for i := 0 to n do
    fillchar(p[i]^, sizeof(p[i]^), 0);
for i := 1 to n - 1 do
    for j := i to m do
        begin
        p[i]^[j] := p[i-1]^[j-1] + v[ind[i]]^[j];
        if (i < j) and (p[i]^[j] < p[i]^[j-1]) then
           p[i]^[j] := p[i]^[j-1];
        end;
End;


procedure capnhat(u: integer);
var
   i, dem, j    :       integer;
begin
if max >= p[n-1]^[m] + c[u] then exit;
max := p[n-1]^[m] + c[u];
fillchar(luu, sizeof(luu), 0);
luu[0] := u;
dem := n;
j := m; i := n - 1;
repeat
      if p[i]^[j] = p[i-1]^[j-1] + v[ind[i]]^[j] then
       begin  dec(dem);  luu[dem] := j;    i := i - 1;   j := j - 1;  end
      else j := j - 1;
      until dem = 1;
end;


Procedure Xuli;
Var
   i, j         :       integer;
   tg           :       arr1;
Begin
for i := 0 to n do  begin new(p[i]); ind[i] := i; end;
max := 0;
for i := n downto 1 do
    begin
    {lay tranh i treo o cua phong}
    ind[i] := i + 1;
    quyhoachdong(i);
    capnhat(i);
    end;
End;



Procedure Output;
Var
   i, j         :       Integer;
Begin
writeln(f, max);
writeln(f, luu[0]); {ma so hieu buc tranh treo o cua phong tranh}
for i := 1 to n - 1 do
    write(f, luu[i], ' ');
Close(f);
release(pmark);
End;

Begin
clrscr;
Mark(Pmark);
Input;
Xuli;
Output;
End.
3 4
1 20 1
1 10 1 3
2 1 2 2
1 3 0 10