        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}
Program Bai_Toan_Mua_Ban_Hang;
Uses Crt;
Const
     Dl                 =       'Banhang.inp';
     Kq                 =       'banhang.out';
     Maxn               =       101;
     maxm               =       10001;
Type
    Arr1                =       Array [1..Maxn] of integer;
    arr2                =       array [0..maxm] of integer;
Var
   a, b                 :       Arr1;
   tra, trb, luu        :       arr2;
   m, n, w              :       Integer; {m dong tien a - n dong tien b}
   suma, sumb           :       integer;
   found                :       boolean;
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
Readln(f, m, n, w);
fillchar(a, sizeof(a), 0);
b := a; suma := 0; sumb := 0;
for i := 1 to m do begin read(f, a[i]); suma := suma + a[i]; end;
for i := 1 to n do begin read(f, b[i]); sumb := sumb + b[i]; end;
Close(f);
Assign(f, kq);
Rewrite(f);
End;


Procedure TTChiakeo(a: arr1; var tr: arr2; sum, n: integer);
Var
   i, j, tam            :       Integer;
Begin
tam := sum div 2;
fillchar(tr, sizeof(tr), 0);
tr[0] := -1;
for i := 1 to n do
    begin
    for j := tam - a[i] downto 0 do
        if (tr[j] <> 0) and (tr[j + a[i]] = 0) then
           tr[j+a[i]] := i;
    end;
End;


Procedure Xuli;
Var
   i, j                 :       Integer;
Begin
TTchiakeo(a, tra, suma, m);
TTchiakeo(b, trb, sumb, n);
End;

procedure xuat(var tr: arr2; sum, u, n: integer);
var
   i                    :       integer;
begin
if u > sum div 2 then i := sum - u
else                  i := u;
fillchar(luu, sizeof(luu), 0);
if i > 0 then
     begin
     repeat
           luu[tr[i]] := 1;
           i := i - a[tr[i]];
           until tr[i] <= 0;
     if u <= sum div 2 then
        begin
        for i := 1 to n do
            if luu[i] = 1 then write(f, i, ' ');
        end
     else
        begin
        for i := 1 to n do
            if luu[i] = 0 then write(f, i, ' ');
        end;
     writeln(f);
     end
else   writeln(f, 0);
end;


Procedure Output;
Var
   i, u, v              :       Integer;
Begin
found := false;
for i := w to suma do
    if (tra[i] <> 0) or (tra[suma-i] <> 0) then
       if (trb[i-w] <> 0) or (trb[sumb-(i-w)] <> 0) then
          begin  u := i;  v := i - w;  found := true; break;  end;
if not found then writeln(f, 0)
else
    begin
    writeln(f, 1);
    xuat(tra, suma, u, m);     xuat(trb, sumb, v, n);
    end;
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
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.
3 4 4
1 2 2
1 2 5 6
