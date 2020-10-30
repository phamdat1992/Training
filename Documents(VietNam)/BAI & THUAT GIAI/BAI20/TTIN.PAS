Program Bai160_TruyenTinTrenMang_TQA2K30PBC;
Uses Crt;
Const
     Dl                 =       'TTin.in0p';
     Kq                 =       'TTin.ou0t';
     tmp                =       'TTin.tmp';
     Maxn               =       101;
Type
    Mt                  =       Array [0..Maxn,0..Maxn] of longint;
    Arr1                =       Array [0..Maxn] of longint;
    Arr2                =       Array [0..Maxn] of integer;
Var
   a                    :       Mt;
   d                    :       arr1;
   tr                   :       arr2;
   n, s, t, k           :       Integer;
   found                :       boolean;
   tongcp               :       longint;
   f, g                 :       Text;

Procedure Input;
Var
   i, j, m              :       integer;
   u, v, cp             :       integer;
Begin
Assign(f, dl);
Reset(f);
Readln(f, n, m, s, t, k);
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


Procedure duongtruyen_min(s, t: integer);
var
   u, v, k              :       integer;
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
   u, v                 :       integer;
begin
{truy xuat nguoc}
u := t;
repeat
      v := tr[u];
      if a[v,u] > 0 then
         begin    a[v,u] := 0;  a[u,v] := -a[u,v];       end
      else
         if a[v,u] < 0 then
            begin    a[v,u] := - a[v,u]; a[u,v]  := a[v,u];  end;
      u := v;
      until u = s;
end;


Procedure Xuli;
Var
   i, j                 :       Integer;
Begin
found := true;
For i := 1 to k do
    begin
    {tim duong di ngan thu k}
    duongtruyen_min(s, t);
    if tr[t] = 0 then begin found := false; exit; end;
    Repair_Graph;
    end;
End;

procedure xuatduongtruyen(var luu: arr2; var dem: integer);
var
   u, v                 :       integer;
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
for u := dem downto 1 do write(g, luu[u], ' '); writeln(g);
end;

Procedure Output;
Var
   i, t                 :       Integer;
   luu                  :       arr2;
   dem                  :       integer;
Begin
assign(g, tmp);  rewrite(g);
if not found then writeln(f, 'NO SOLUTION')
else
   begin
   tongcp := 0;
   for i := 1 to k do
       Xuatduongtruyen(luu, dem);

   writeln(f, tongcp);
   close(g);   assign(g, tmp); reset(g);
   for i := 1 to k do
       begin
       while not seekeoln(g) do
             begin
             read(g, t); write(f, t, ' ');
             end;
       readln(g);
       writeln(f);
       end;
   end;
Erase(g);
Close(f);
End;

Begin
clrscr;
Input;
Xuli;
Output;
End.
5 7 1 5 3
1 2 3
1 4 8
2 3 5
2 4 4
3 5 5
4 3 8
4 5 3
5 5 1 5 2
1 2 1
2 3 1
3 5 1
1 4 1
4 5 1