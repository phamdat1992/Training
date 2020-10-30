        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {*                       30 - 4 - V                        *}
        {***********************************************************}
{Dung phuong phap cap ghep}
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
    Arr1        =       Array [1..Maxn] of toado;
    Arr2        =       Array [1..2*Maxn, 1..2*Maxn] of boolean;
    Arr3        =       Array [1..Maxn] of integer;
    Arr4        =       Array [1..2 * Maxn] of integer;
Var
   d1, d2       :       Arr1;   {toa do cac diem hap dan - cac diem tam tang}
   a            :       Arr2;
   Px, Py       :       Arr3;
   tr           :       Arr4;
   u, z         :       integer;
   m, n         :       Integer;
   g            :       Text;
   Time         :       Longint absolute 0000: $0046c;
   LuuTime      :       Longint;

Procedure Input;
Var
   i, j         :       integer;
Begin
Assign(g, dl);
Reset(g);
Readln(g, n, m);
for i := 1 to n do
    read(g, d1[i].x, d1[i].y);
{readln(f);}
for i := 1 to m do
    read(g, d2[i].x, d2[i].y);
Close(g);
Assign(g, kq);
Rewrite(g);
End;


Procedure KhoiTao;
Var
   i, j         :       Integer;
Begin
fillchar(a, sizeof(a), 0);
n := n - 1;
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
        if t >= t1 + t2 then    a[i,j] := true;
        end;
    end;
End;


{Dung cap ghep toi da de giai}

Procedure chuanbi;
begin
{Khoi tao cap ghep rong}
fillchar(px, sizeof(px), 0);
py := px;
end;

function tudo: boolean;
{tra lai true neu dinh u la tu do}
begin
tudo := px[u] = 0;
end;

function timthayduongtangcapghep: boolean;
{tra lai true neu tim thay duong tang cap ghep tu u va gui dinh cuoi cua
duong di nay vao z}
var
   dau, cuoi    :       integer;
   v, w         :       integer;
   q            :       arr4;
begin
{xuat phat tu dinh tu do u thuoc X}
fillchar(tr, sizeof(tr), 0);
q := tr;
dau := 1;
cuoi := 1;
q[1] := u;
tr[u] := u;
while dau <= cuoi do
      begin
      v := q[dau];
      inc(dau);
      if v < n + 1 then {Dinh thuoc x}
         begin
         for w := n + 1 to n + m do
             if a[v,w-n] and (tr[w] = 0) then
                begin
                inc(cuoi); {ket nap w vao queue}
                q[cuoi] := w;
                tr[w] := v;
                end;
         end
      else {Dinh thuoc Y}
          if py[v-n] = 0 then
             begin
             timthayduongtangcapghep := true;
             z := v;
             exit;
             end
          else
             begin
             w := py[v-n];
             inc(cuoi);
             q[cuoi] := w;
             tr[w] := v;
             end;
      end;
timthayduongtangcapghep := false;
end;

procedure tangcapghep;
var
   x, y         :       integer;
   thuocy       :       boolean;
begin
{dieu chinh cap ghep tren duong tang cap ghep}
y := z;
thuocy := true;
while y <> u do
      begin
      x := tr[y];
      if thuocy then begin px[x] := y - n; py[y-n] := x; end;
      y := x;
      thuocy := not thuocy;
      end;
end;

Procedure Xuli_Capghep;
Var
   i, j         :       integer;
Begin
Chuanbi;
for u := 1 to n do
    if tudo then
       if timthayduongtangcapghep then tangcapghep;
End;


Procedure Output;
Var
   i, j         :       Integer;
   max          :       integer;
Begin
max := 0;
For i := 1 to n do
    if px[i] <> 0 then inc(max);
writeln(g, max + n + 1);
for i := 1 to n do
    begin
    writeln(g, d1[i].x, ' ', d1[i].y, '  ');
    if px[i] <> 0 then
       writeln(g, d2[px[i]].x, ' ', d2[px[i]].y, '  ');
    end;
write(g, d1[n+1].x, ' ', d1[n+1].y);
close(g);
End;

Begin
clrscr;
LuuTime := Time;
Input;
KhoiTao;
TaoGraph;
Xuli_Capghep;
Output;
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.
