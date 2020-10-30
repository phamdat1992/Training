        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}
{Phan nhom diep vien}
{$R+,N+}
Program TQA2K30PBC;
Uses Crt;
Const
     Dl                 =       'Spier.inp';
     Kq                 =       'Spier.out';
     Maxn               =       7001;
Type
    Arr1                =       Array [0..Maxn] of integer;
    Arr2                =       Array [0..maxn] of boolean;
Var
   nh                   :       Arr1;   {mang nhan}
   C                    :       arr1;   {mang chenh lech cua do thi 2 phia}
   tr                   :       arr1;   {mang tr[i] danh dau tong i co the co}
   luu                  :       arr2;
   n, dem, sum, w       :       Integer;
   f, g                 :       Text;
   Time                 :       Longint absolute 0000: $0046c;
   LuuTime              :       Longint;
   pmark                :       pointer;



Procedure KhoiTao(var dem: integer);
Var
   i, j, t, k           :       Integer;
   cx                   :       Arr2;
Begin
fillchar(cx, sizeof(cx), 1); t := 0;
for i := 1 to dem do
    begin
    k := 0;
    for j := 1 to n do
        if cx[j] then
           begin
           if nh[j] = i then  begin inc(t); nh[j] := t;  k := j; break end;
           if nh[j] = -i then begin inc(t); nh[j] := -t; k := j; break end;
           end;
    if k <> 0 then
       begin
       cx[k] := false;
       for j := k + 1 to n do
           if cx[j] then
              begin
              if nh[j] = i then  begin nh[j] := t;  cx[j] := false; end;
              if nh[j] = -i then begin nh[j] := -t; cx[j] := false; end;
              end;
       end;
    end;
dem := t;
for i := 1 to n do
    if nh[i] = 0 then
       begin inc(dem); nh[i] := dem; end;

{Xay dung mang C[i] = abs(Pi - Qi) }
fillchar(c, sizeof(c), 0);
for i := 1 to n do
    if nh[i] > 0 then inc(c[nh[i]])
    else              dec(c[abs(nh[i])]);
for i := 1 to dem do luu[i] := c[i] >= 0;
{luu[i] = true neu o thanh phan lien thong i thi phan do thi duong lon hon}

sum := 0;
for i := 1 to dem do begin c[i] := abs(c[i]); sum := sum + c[i]; end;
sum := sum div 2;
End;


Procedure Chiakeo;
Var
   i, j                 :       Integer;
Begin
fillchar(tr, sizeof(tr), 0);
tr[0] := - 1;
for i := 1 to dem do
    begin
    for j := sum - c[i] downto 0 do {chu y vong lap phai nguoc}
        if (tr[j] <> 0) and (tr[j+c[i]] = 0) then
           tr[j+c[i]] := i;
    end;
End;

Procedure Xuatday;
Var
   i, j                 :       integer;
   cx, cx1              :       arr2;
Begin
fillchar(cx, sizeof(cx), 1);
for i := sum downto 0 do
    if tr[i] <> 0 then break;
for j := 0 to n do
    if tr[j] = -1 then tr[j] := 0;
repeat
      cx[tr[i]] := false;
      i := i - c[tr[i]];
      until (i <= 0);
fillchar(cx1, sizeof(cx1), true);
tr := c;
for i := 1 to n do
    if cx[abs(nh[i])] then
           begin if luu[i] = (nh[i] > 0) then write(g, i, ' '); end
    else
           begin if luu[i] = (nh[i] < 0) then write(g, i, ' '); end;
writeln(g);
for i := 1 to n do
    if not cx[abs(nh[i])] then
           begin if luu[i] = (nh[i] > 0) then write(g, i, ' '); end
    else
           begin if luu[i] = (nh[i] < 0) then write(g, i, ' '); end;

close(g);
End;


Procedure Xuat(chiaduoc: boolean);
Var
   i, t                 :       integer;
   M                    :       extended;
Begin
If not chiaduoc then
   begin   writeln(g, 0);   close(g);   end
else
   begin
   t := dem - w;
   for i := 1 to n do if nh[i] = 0 then inc(t);
   M := 1;
   for i := 1 to t - 1 do m := m * 2;
   if t = n then
      begin
      writeln(g, m - 1:0:0);
      for i := 1 to n div 2 do      write(g, i, ' ');
      writeln(g);
      for i := n div 2 + 1 to n do  write(g, i, ' ');
      close(f);
      end
   else
      begin
      writeln(g, m:0:0);
      khoitao(dem);
      chiakeo;
      xuatday;
      end;
   end;
End;



Procedure Input;
Var
   i, a, b              :       integer;
   dau, luua, luub      :       integer;
Begin
Assign(f, dl);  Reset(f);
Assign(g, kq);  Rewrite(g);
Readln(f, n);
{Xu li du lieu - Tim thanh phan lien thong}
fillchar(nh, sizeof(nh), 0); dem := 0; w := 0;
while not seekeof(f) do
      begin
      readln(f, a, b);
      if nh[a] = 0 then
         begin
         if nh[b] = 0 then
            begin inc(dem); nh[a] := dem; nh[b] := - dem; end {ket nap tplt}
         else
            nh[a] := - nh[b]                             {nh[b] <> 0}
         end
      else
         begin
         if nh[b] = 0 then nh[b] := -nh[a]
         else
             if nh[a] = nh[b] then  begin close(f); xuat(false); halt; end
             else if nh[a] <> - nh[b] then
                  begin inc(w);
                  luub := abs(nh[b]); luua := abs(nh[a]);
                  dau := - (nh[a] div luua) * (nh[b] div luub);
                  {dau = 1 tuc nhan b khong can doi dau};
                  for i := 1 to n do
                      if abs(nh[i]) = luub then
                         nh[i] := dau * (nh[i] div luub) * luua;
                  end;
         end;
      end;
Close(f);
End;


Begin
clrscr;
LuuTime := Time;
mark(pmark);
Input;
Xuat(true);
release(pmark);
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.
9
1 2
1 3
4 1
5 6
7 8
9 7
5 8