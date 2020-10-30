        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}
Program TQA2K30PBC;
Uses Crt;
Const
     Dl         =       'Zam.in4321p';
     Kq         =       'Zam.out';
     Maxn       =       100;
     Maxt       =       1000;
     hang       =       256;
Type
    Mt          =       Array [1..Maxn,1..Maxn] of Boolean;
    Arr1        =       Array [1..Maxn] of integer;
    Arr2        =       Array [0..Maxt] of ^Arr1;
Var
   a            :       mt; {mang quan he}
   cost         :       arr1;     {mang gia cac phong can tra}
   tr           :       arr2;
   n, s         :       Integer;
   souce, target:       integer;
   f            :       Text;
   GetMark      :       Pointer;
   Time         :       Longint absolute 0000: $0046c;
   LuuTime      :       Longint;

Procedure Input;
Var
   i, m         :       integer;
   u, v         :       integer;
Begin
Assign(f, dl);
Reset(f);
fillchar(a, sizeof(a), 0);
Readln(f, n, m, souce, target, s);
for i := 1 to n do
    read(f, cost[i]);
readln(f);
for i := 1 to m do
    begin
    readln(f, u, v);
    a[u,v] := true;
    a[v,u] := true;
    end;
Close(f);
Assign(f, kq);
Rewrite(f);
End;


Procedure KhoiTao;
Var
   i, j         :       Integer;
Begin
Mark(GetMark);
for i:= 0 to s do
    begin
    new(tr[i]);
    fillchar(tr[i]^, sizeof(tr[i]^), 0);
    end;
tr[0]^[target] := hang;
s := s - cost[target];
End;

procedure timdinhtruocj(i, j: integer);
{tim dinh truoc j trong duong di tu t toi j ma het chi phi la i}
var
   u, v         :       integer;
   tmp          :       integer;
begin
tmp := i - cost[j];
if tmp < 0 then exit;
for u := 1 to n do
    if (u <> j) and a[j,u] and (tr[tmp]^[u] <> 0) then
       begin
       tr[i]^[j] := u;
       break;
       end;
end;

Procedure qhd;
Var
   i, j         :       Integer;
Begin
for i := 1 to s do
    for j := 1 to n do
        timdinhtruocj(i,j);
End;

Procedure Output;
Var
   i, j, tg     :       Integer;
Begin
if tr[s]^[souce] = 0 then       write(f, -1)
else
   begin
   write(f, souce, ' ');
   j := souce;
   i := s;
   repeat
         tg := j;
         j := tr[i]^[j];
         i := i - cost[tg];
         write(f, j, ' ');
         until i = 0;
   end;
Close(f);
Release(GetMark);
End;

Begin
clrscr;
LuuTime := Time;
Input;
KhoiTao;
Qhd;
Output;
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.
5 6 3 4 9
1 2 3 4 5
2 4
5 4
1 5
1 2
2 3
3 1