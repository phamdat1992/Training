        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}
Program TQA2K30PBC;
Uses Crt;
Const
     Dl         =       'May.inp';
     Kq         =       'May.out';
     Maxn       =       100;
Type
    Mt          =       Array [1..Maxn,1..Maxn] of integer;
    Arr1        =       Array [1..Maxn] of integer;
    Arr2        =       Array [1..Maxn] of integer;
Var
   a            :       Mt;
   d, tr        :       arr1;
   n, s, t      :       Integer;
   found        :       boolean;
   tongcp       :       integer;
   f            :       Text;
   Time         :       Longint absolute 0000: $0046c;
   LuuTime      :       Longint;

Procedure Input;
Var
   i, j, m      :       integer;
   u, v, cp     :       integer;
Begin
Assign(f, dl);
Reset(f);
Readln(f, n, m, s, t);
fillchar(a, sizeof(a), 0);
for i := 1 to m do
    begin
    readln(f, u, v, cp);
    a[u,v] := cp;
    a[v,u] := cp;
    end;
Close(f);
Assign(f, kq);
Rewrite(f);
End;


Procedure duongdingannhat(s, t: integer);
var
   u, v, k      :       integer;
begin
fillchar(tr, sizeof(tr), 0);
for u := 1 to n do
    if a[s,u] <> 0 then
       begin d[u] := a[s,u]; tr[u] := s;  end
    else d[u] := - maxint;
d[s] := s;
for k := 1 to n - 2 do
    for u := 1 to n do
        if d[u] <> -maxint then
           for v := 1 to n do
               if a[u,v] <> 0 then
                  if (d[v] > d[u] + a[u,v]) or (d[v] = -maxint) then
                     begin
                     d[v] := d[u] + a[u,v];
                     tr[v] := u;
                     end;
end;

Procedure Repair_Graph;
{xay dung lai do thi}
var
   u, v         :       integer;
begin
{truy xuat nguoc}
u := t;
repeat
      v := tr[u];
      if a[v,u] > 0 then
         begin    a[v,u] := 0;  a[u,v] := -a[u,v];       end
      else
         if a[v,u] < 0 then
            begin    a[v,u] := - a[u,v]; a[u,v]  := a[v,u];  end;
      u := v;
      until u = s;
end;


Procedure Xuli;
Var
   i, j         :       Integer;
Begin
found := true;
{tim duong di ngan thu nhat}
Duongdingannhat(s, t);
if tr[t] = 0 then begin found := false; exit; end;
Repair_Graph;
{tim duong di ngan thu hai}
Duongdingannhat(s, t);
found := found and (tr[t] <> 0);
if found then Repair_graph;
End;

procedure xuatduongtruyen(var luu: arr1; var dem: integer);
var
   u, v         :       integer;
begin
fillchar(luu, sizeof(luu), 0);
u := t;
dem := 1;
luu[1] := t;
repeat
      for v := 1 to n do
          if a[u,v] < 0 then break;
      a[u,v] := - a[u,v];
      a[v,u] := a[u,v];
      inc(tongcp, a[u,v]);
      inc(dem);
      luu[dem] := v;
      u := v;
      until u = s;
end;

Procedure Output;
Var
   i            :       Integer;
   luu1, luu2   :       arr1;
   dem1, dem2   :       integer;
Begin
if not found then writeln(f, -1)
else
   begin
   tongcp := 0;
   {xuat duong truyen thu nhat}
   Xuatduongtruyen(luu1, dem1);
   {xuat duong truyen thu hai}
   Xuatduongtruyen(luu2, dem2);

   {write to file}
   writeln(f, tongcp);
   for i := dem1 downto 1 do write(f, luu1[i], ' '); writeln(f);
   for i := dem2 downto 1 do write(f, luu2[i], ' ');
   end;
Close(f);
End;

Begin
clrscr;
LuuTime := Time;
Input;
Xuli;
Output;
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
Readln;
End.
5 7 1 5
1 2 3
1 4 8
2 3 5
2 4 4
3 5 5
4 3 8
4 5 3