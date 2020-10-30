        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}
{$R+}
Program Chia_keo_thanh_hai_phan_nho_nhat_TQA2K30PBC;
Uses Crt;
Const
     Dl                 =       'Chiakeo.inp';
     Kq                 =       'Chiakeo.out';
     Maxn               =       101;
     maxm               =       10001;
Type
    Arr1                =       Array [1..Maxn] of Byte;
    Arr2                =       array [0..maxm] of integer;
Var
   a                    :       Arr1;
   tr, luu              :       arr2;
   n, sum               :       Integer;
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
fillchar(a, sizeof(a), 0);
sum := 0;
for i := 1 to n do
    begin
    read(f, a[i]); sum := sum + a[i];
    end;
Close(f);
Assign(f, kq);
Rewrite(f);
End;



Procedure Xuli;
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

Procedure Output;
Var
   i, j                 :       Integer;
Begin
for i := sum div 2 downto 1 do
    if tr[i] <> 0 then break;
writeln(f, sum - 2 * i); {chenh lech}
fillchar(luu, sizeof(luu), 0);
repeat
      luu[tr[i]] := 1;
      i := i - a[tr[i]];
      until tr[i] <= 0;
for i := 1 to n do
    write(f, luu[i] + 1, ' ');
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
6
2 2 2 2 2 2