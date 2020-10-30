        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}
Program TQA2K30PBC;
Uses Crt;
Const
     Dl                 =       'Dayso.inp';
     Kq                 =       'Dayso.out';
     Maxn               =       1001;
     Maxk               =       100;
Type
    Arr1                =       Array [0..Maxn] of integer;
    Arr2                =       Array [0..Maxk] of integer;
    Arr3                =       Array [0..Maxn] of boolean;
Var
   a                    :       Arr1;
   tr, mind             :       arr2;
   cx                   :       arr3;
   n, k, m              :       Integer;
   f                    :       Text;
   Time                 :       Longint absolute 0000: $0046c;
   LuuTime              :       Longint;
   pmark                :       pointer;

Procedure Input;
Var
   i, sum               :       integer;
Begin
Assign(f, dl);
Reset(f);
Readln(f, n, k); sum := 0;
for i := 1 to n do
    begin read(f, a[i]); sum := sum + a[i]; end;
m := sum mod k;
Close(f);
Assign(f, kq);
Rewrite(f);
End;


Procedure KhoiTao;
Var
   i, j                 :       Integer;
Begin
fillchar(tr, sizeof(tr), 0);
fillchar(mind, sizeof(mind), 0);
fillchar(cx, sizeof(cx), 1);
End;


Procedure Xuli;
Var
   i, j, t, t1          :       Integer;
Begin
for i := 1 to n do
    begin
    t := a[i] mod k;
    if t <> 0 then
       begin
       if mind[t] = 0 then begin mind[t] := 1; tr[t] := i; end;
       for j := 1 to k - 1 do
           if (tr[j] <> 0) and (tr[j] <> i) then
              begin
              t1 := (j + t) mod k;
              if t1 <> 0 then
              if (mind[t1] > mind[j] + 1) or (mind[t1] = 0) then
                 begin
                 mind[t1] := mind[j] + 1;
                 tr[t1] := i;
                 end;
              end;
       end;
    end;
End;

procedure loaiso(var dem: integer);
var
   i, t                 :       integer;
begin
i := m; dem := 0;
repeat
      t := tr[i];
      cx[t] := false; inc(dem);
      t := a[t] mod k;
      i := (i - t) mod k;
      if i < 0 then i := i + k;
      until tr[i] = 0;
dem := n - dem;
end;


Procedure Output;
Var
   i, dem               :       Integer;
Begin
if m = 0 then
   begin
   writeln(f, m);
   for i := 1 to n do
       write(f, 1, ' ');
   end
else
   begin
   khoitao;
   xuli;
   loaiso(dem);
   writeln(f, dem);
   for i := 1 to n do
       if cx[i] then write(f, 1, ' ')
       else          write(f, 0, ' ');
   end;
Close(f);
End;

Begin
clrscr;
LuuTime := Time;
mark(pmark);
Input;
Output;
release(pmark);
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.
6 5
1 2 7 3 4 5
13 7
1 1 1 1 1 1 1 1 1 1 1 1 1