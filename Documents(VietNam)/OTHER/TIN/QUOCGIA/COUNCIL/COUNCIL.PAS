{* Tren mot hon dao co N nguoi, P cong ty, K cau lac bo the thao. Moi nguoi deu
   lam cho 1 cong ty va tham gia it nhat 1 clb the thao. Hay lap mot hoi dong
   gom K nguoi, moi nguoi dai dien cho mot clb sao cho moi cong ty I co it nhat
   1 nguoi trong hoi dong va ko qua Ui nguoi trong hoi dong.
 * Du lieu :
   - N <= 100, P, K <= 50.
   - N dong tiep, moi dong gom
     + cong ty nguoi i
     + Ki - so luong clb nguoi do tham gia
     + Ki so tiep la chi so cac clb nguoi do tham gia
 * Ket qua : -1 neu ko co nghiem, Neu khong ghi K so tren mot dong, so thu I
   la chi so cua nguoi ddien cho clb I
 * Thuat toan : Luong cuc dai voi bon dinh S, dinh thu T va 3 lop dinh :
   - Lop 1 : K clb
   - Lop 2 : N nguoi
   - Lop 3 : P cong ty
   S noi voi moi K clb; moi clb noi voi nguoi I neu nguoi do tgia, nguoi
     i noi voi cty nguoi do lam, moi cty noi dinh thu T
 * Chia 2 giai doan xu li :
   - Giai doan 1 : gan moi trong so = 0 -> tim luong max. Neu co 1 cong ty nao
     do ma ko co luong qua thi bai toan vo nghiem
   - Giai doan 2 : gian moi trong so cac cty den dinh tu T bang Ui -> luong max
     neu co clb nao ma ko co luong qua thi bai toan vo nghiem
   bang ko thi in kq.
 * Chu y : Viec dua nguoi vao lop 2 dan den viec ko can thiet nhan doi dinh }

{$R+}
Const
     fi = 'Council.in0';
     fo = 'Council.ou0';
     nmax = 101;
     kmax = 51;
     pmax = 51;
     vc = 255;

Type
    mang1 = array [1..nmax, 1..kmax] of byte;
    mang2 = array [1..kmax, 1..nmax] of byte;

Var
   clb, fclb : mang2;
   cty, fcty, slct, slcn, u : array [1..nmax] of byte;
   t, fs, ft : array [1..nmax] of byte;
   cn      : mang1;
   ct      : mang2;
   queue, pred : array [0..nmax + pmax + kmax] of integer;
   f       : text;
   n, p, k, top, last : integer;

Procedure nap(i, j : integer);
Begin
  clb[j, i] := 1;

  inc(slcn[i]);
  cn[i, slcn[i]] := j;
End;
{*********}
Procedure Enter;
Var
   i, sl, ii, j : integer;

Begin
  assign(f, fi); reset(f);
  readln(f, n, p, k);

  fillchar(clb, sizeof(clb), 0);
  fillchar(cty, sizeof(cty), 0);
  fillchar(cn, sizeof(cn), 0);
  fillchar(ct, sizeof(ct), 0);
  fillchar(slct, sizeof(slct), 0);

  for i := 1 to n do
      begin
        read(f, cty[i]);
        inc(slct[cty[i]]);
        ct[cty[i], slct[cty[i]]] := i;

        read(f, sl);
        for ii := 1 to sl do
            begin
              read(f, j);
              nap(i, j);
            end;
      end;

  for i := 1 to p do read(f, u[i]);

  Close(f);
End;

{*****************************************}

Procedure Init;
Var
   i : integer;

Begin
  fillchar(fclb, sizeof(fclb), 0);
  fillchar(fcty, sizeof(fcty), 0);
  fillchar(fs, sizeof(fs), 0);
  fillchar(ft, sizeof(ft), 0);

  for i := 1 to p do t[i] := 1;
End;

{***************************************}

Procedure cbloang;
Var
   i : integer;

Begin
  for i := 0 to n + p + k + 1 do
        pred[i] := -1;

  fillchar(queue, sizeof(queue), 0);
  pred[0] := vc;
  queue[1] := 0; top := 1; last := 1;
End;
{********}
Function getmin(i, j : integer) : integer;
Begin
  if i < j then getmin := i
     else getmin := j;
End;
{********}
Procedure napxuoi(i, j : integer);
Begin
  inc(top); queue[top] := j;
  pred[j] := i;
End;
{********}
Procedure loang0;
Var
   i : integer;

Begin
  for i := 1 to k do
      if (pred[k] = -1) and (fs[i] < 1) then napxuoi(0, i);
End;
{********}
Procedure loangclb(i : integer);
Var
   j : integer;

Begin
  for j := 1 to n do
      if (pred[j + k] = -1) and (fclb[i, j] < clb[i, j]) then
         napxuoi(i, j + k);
End;
{********}
Procedure napnguoc(i, j : integer);
Begin
  inc(top);
  queue[top] := j;
  pred[j] := -i;
End;
{********}
Procedure loangcn(i : integer);
Var
   j : integer;

Begin
  if (pred[cty[i] + n + k] = -1) and (fcty[i] < 1) then
     napxuoi(i + k, cty[i] + k + n);

  for j := 1 to slcn[i] do
      if (pred[cn[i, j]] = -1) and (fclb[cn[i, j], i] > 0) then
         napnguoc(i + k, cn[i, j]);
End;
{********}
Procedure loangcty(i : integer);
Var
   j : integer;

Begin
  if ft[i] < t[i] then napxuoi(i + n + k, n + p + k + 1);

  for j := 1 to slct[i] do
      if (pred[ct[i, j] + k] = -1) and (fcty[ct[i, j]] > 0) then
         napnguoc(i + n + k, ct[i, j] + k);
End;
{********}
Function find_path : boolean;
Var
   pp : integer;

Begin
  Find_path := true;
  cbloang;

  while last <= top do
        begin
          pp := queue[last]; inc(last);

          if pp = 0 then loang0
             else if (pp > 0) and (pp <= K) then loangclb(pp)
                  else if (pp > k) and (pp <= k + n) then loangcn(pp - k)
                       else if (pp > k + n) and (pp <= k + n + p) then loangcty(pp - n - k);

          if pred[n + k + p + 1] <> -1 then exit;
        end;

  Find_path := false;
End;
{********}
Procedure incxuoi(pp, delta : integer);
Begin
  if pp = n + k + p + 1 then inc(ft[pred[pp] - n - k], delta)
     else if pp > n + k then inc(fcty[pred[pp] - k], delta)
          else if (pp > k) then inc(fclb[pred[pp], pp - k], delta)
               else if (pp > 0) then inc(fs[pp], delta)
End;
{********}
Procedure incnguoc(pp, delta : integer);
Begin
  if pp > k then dec(fcty[pp - k], delta)
     else dec(fclb[pp, abs(pred[pp]) - k], delta);
End;
{********}
Procedure Inc_flow;
Var
   delta, pp : integer;

Begin
  delta := 1;
  pp := n + p + k + 1;

  while pred[pp] <> vc do
        begin
          if pred[pp] >= 0 then incxuoi(pp, delta)
             else incnguoc(pp, delta);

          pp := abs(pred[pp]);
        end;
End;
{********}
Procedure Max_flow;
Begin
  while find_path do inc_flow;
End;

{****************************}

Procedure error;
Begin
  assign(f, fo); rewrite(f);
  writeln(f, -1);
  Close(f); halt;
End;

{*****************************}
Procedure Solve1;
Var
   i : integer;

Begin
  Max_flow;

  for i := 1 to p do
      if ft[i] = 0 then error;
End;
{********}
Procedure Solve2;
Var
   i : integer;

Begin
  for i := 1 to p do t[i] := u[i];
  max_flow;

  for i := 1 to k do
      if fs[i] = 0 then error;
End;

{***************************************}

Procedure Print;
Var
   i, j : integer;

Begin
  assign(f, fo); rewrite(f);

  for i := 1 to k do
      for j := 1 to n do
          if fclb[i, j] = 1 then write(f, j,' ');

  Close(f);
End;

Begin
  Enter;
  Init;
  Solve1;
  Solve2;
  Print;
End.
