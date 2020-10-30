        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}
Program TQA2K30PBC;
Uses Crt;
Const
     Dl         =       'Bus6.';
     Kq         =       'Busway.out';
     Maxm       =       100;      {So tuyen duong toi da}
     Maxn       =       150;      {So ki tu }
     khactuyen  =       100;      {khac tuyen trong so cac ga la 100}
Type
    string50    =       string[51];
    Mt1         =       Array [0..Maxn,0..Maxn] of integer;
    Mt3         =       Array [0..Maxn,0..Maxn] of byte;
    Mt2         =       array [1..Maxm] of string50;
    Arr1        =       Array [1..Maxn] of integer;
    Arr2        =       Array [1..Maxn] of boolean;
Var
   a            :       Mt1;
   thuoctuyen   :       ^Mt3;
   s            :       Mt2;
   d, tr        :       arr1;
   d1           :       arr1;
   chuaxet      :       arr2;
   dau          :       integer;
   n, m         :       Integer;
   sourge       :       integer;
   target       :       integer;
   f, g         :       Text;
   Time         :       Longint absolute 0000: $0046c;
   LuuTime      :       Longint;

Procedure Input;
Var
   i, j         :       integer;
Begin
Assign(f, dl);
Reset(f);
Readln(f, m); {m la so tuyen duong}
fillchar(S, sizeof(S), 0);
for i := 1 to m do
    readln(f, s[i]);
Assign(g, kq);
Rewrite(g);
End;


procedure Find_n;
var
   i, j, k      :       integer;
begin
n := 0;
dau := maxn;
for i := 1 to m do
    begin
    for j := 1 to length(s[i]) do
        begin
        k := ord(s[i][j]);
        if n < k then n := k;
        if dau > k then dau := k;
        end;
    end;
end;

procedure BuildGraph;
{xay dung ma tran duong di giua duong di giua cac ga voi nhau
ma tran di nguoc giua cac ga de thuan tien viec tim duong di tu target den
sourge}
var
   i, j, k      :       integer;
   t, t1, t2    :       integer;
begin
fillchar(a, sizeof(a), 0);
new(thuoctuyen);
fillchar(thuoctuyen^, sizeof(thuoctuyen^), 0);
for i := 1 to m do
    begin
    t := length(s[i]);
    for j := 1 to t - 1 do
        for k := j + 1 to t do
            begin
            t1 := ord(s[i][j]);
            t2 := ord(s[i][k]);
            if (a[t1, t2] > k - j) or (a[t1,t2] = 0) then
               begin
               a[t1,t2] := k - j;
               a[t2,t1] := a[t1,t2];
               thuoctuyen^[t1,t2] := i;
               thuoctuyen^[t2,t1] := i;
               end;
            end;
    end;
end;


Procedure KhoiTao;
Var
   i, j         :       Integer;
Begin
Find_n;
BuildGraph; {xay dung ma tran quan he mot chieu giua duong di giua cac ga voi nhau}
End;


Procedure Dijstra(s, t: integer);
Var
   u, v, min    :       integer;
   trongso      :       integer;
begin
fillchar(d, sizeof(d), 0); {luu duong di min giua qua cac tuyen}
d1 := d;                   {luu duong di min qua cac dinh}
fillchar(tr, sizeof(tr), 0);
fillchar(chuaxet, sizeof(chuaxet), 1);
for u := dau to n do
    if a[s,u] > 0 then
       begin
       d[u] := 1;
       tr[u] := s;
       d1[u] := a[s,u];
       end;
chuaxet[s] := false;
Repeat
      u := 0;
      min := maxint;
      for v := dau to n do
          if (chuaxet[v]) and (d[v] <> 0) and (min > d[v]) then
             begin u := v; min := d[v]; end;
      if u = 0 then exit;
      chuaxet[u] := false;
      for v := dau to n do
          if chuaxet[v] and (a[u,v] > 0) then
              if (d[v] = 0) or (d[v] > d[u] + 1) then
                begin
                d[v] := d[u] + 1;
                d1[v] := d1[u] + a[u,v];
                tr[v] := u;
                end
              else
                  if d[v] = d[u] + 1 then
                     if d1[v] > d1[u] + a[u,v] then
                        begin
                        d1[v] := d1[u] + a[u,v];
                        tr[v] := u;
                        end;
      until not chuaxet[t];
end;

Procedure write_way(sourge, target: integer);
var
   u, v, u1, v1 :       integer;
   tg, i        :       integer;
begin
if d[sourge] = 0 then begin writeln(g, -1); exit; end;
u := sourge;
repeat
      v := tr[u];
      tg := thuoctuyen^[u,v];
      u1 := pos(chr(u), s[tg]);
      v1 := pos(chr(v), s[tg]);
      if u1 > v1 then
         for i := u1 downto v1 do write(g, s[tg][i])
      else
         for i := u1 to v1 do write(g, s[tg][i]);
      if v <> target then write(g, ' ');
      u := v;
      until u = target;
writeln(g);
end;



Procedure Xuli;
Var
   i, j         :       Integer;
   sohanhtrinh  :       integer;
   d1, c1       :       char;
Begin
readln(f, sohanhtrinh);
for i := 1 to sohanhtrinh do
    begin
    readln(f, d1, c1);
    sourge := ord(d1);
    target := ord(c1);
    Dijstra(target, sourge); {di nguoc de xuat dung}
    Write_way(sourge, target);
    end;
End;



Procedure Output;
Var
   i, j         :       Integer;
Begin
Close(f);
Close(g);
End;

Begin
clrscr;
LuuTime := Time;
Input;
KhoiTao;
Xuli;
Output;
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.
3
ABC
DBE
GAEH
2
HC
GB