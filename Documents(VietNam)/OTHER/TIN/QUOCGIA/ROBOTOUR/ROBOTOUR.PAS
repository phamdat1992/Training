{* Tim diem xuat phat va mot chu trinh qua M diem ke ca diem xuat phat sao cho
   - Binh phuong khoang cach giua hai diem Ui va Ui+1 la Di.
   - Duong di la mot duong gap khuc, ko co dinh nao duoc di qua 2 lan tru dinh
     xuat phat. Khong co 3 diem lien tiep thang hang.
   - Cac toa do nguyen khong ra khoi pham vi (0, N). (co nghia la trong bang vuong
     N * N co goc toa do (0, 0) tai diem trai duoi)
 * Du lieu
   - N M (N <= 15; M <= 20)
   - M so D1 .. Dm
 * Ket qua : M dong lan luot la hanh trinh, dau tien so toa do diem xuat phat}

{$R+}
Uses crt;
Const
     fi = 'tour.in0';
     fo = 'tour.ou0';
     nmax = 30;
     mmax = 21;
     slmax = 21;
     exp = 0.000001;

Type
    cs = record
       a, b, c : real;
    end;

    cstoado = record
            x, y : integer;
    end;

Var
   f : text;
   x, y : array [1..mmax, 1..slmax] of integer;
   ddi : array [0..mmax] of cstoado;
   dt   : array [1..mmax] of cs;
   kt   : array [-nmax..nmax, -nmax..nmax] of boolean;
   d, sl : array [1..mmax] of integer;
   n, m, xmin, xmax, ymin, ymax : integer;
   bd : longint;
   time : longint absolute $0 : $046C;

Procedure enter;
Var
   i : integer;

Begin
  assign(f, fi); reset(f);
  readln(f, n, m);

  fillchar(d, sizeof(d), 0);
  for i := 1 to m do read(f, d[i]);

  Close(f);
End;

{***********************************************}

Function bang(so1, so2 : real) : boolean;
Begin
  if abs(so1 - so2) <= exp then bang := true
     else bang := false;
End;
{********}
Function kc(x1, y1, x2, y2 : real) : real;
Begin
  kc := sqrt(sqr(x1 - x2) + sqr(y1 - y2));
End;
{********}
Function tot(x0, y0, di : integer) : boolean;
Var
   t, tt : real;

Begin
  t := kc(x0, y0, 0, 0);
  tt := sqrt(di);

  if bang(t, tt) then tot := true
     else tot := false;
End;
{********}
Procedure Init;
Var
   i : integer;
   x0, y0, t : integer;

Begin
  fillchar(sl, sizeof(sl), 0);
  for i := 1 to m do
      begin
        t := trunc(sqrt(d[i])) + 1;
        for x0 := -t to t do
            for y0 := -t to t do
                if tot(x0, y0, d[i]) then
                   begin
                     inc(sl[i]);
                     x[i, sl[i]] := x0;
                     y[i, sl[i]] := y0;
                   end;
      end;
End;

{*********************************}

Function thuoc(xx, yy, k : integer) : boolean;
Begin
  with dt[k] do
       if bang(a * xx + b * yy, c) then thuoc := true
          else thuoc := false;
End;
{********}
Procedure lapdt(x1, y1, x2, y2 : integer; var aa, bb, cc : real);
Begin
  aa := y2 - y1;
  bb := x1 - x2;
  cc := x1 * y2 - x2 * y1;
end;
{********}
Function trendoan(x1, y1, x2, y2, x3, y3 : integer) : boolean;
Var
   t, t1, t2 : real;

Begin
  t := kc(x2, y2, x3, y3);
  t1 := kc(x1, y1, x2, y2);
  t2 := kc(x1, y1, x3, y3);

  if bang(t, t1 + t2) then trendoan := true
     else trendoan := false;
End;
{********}
Function good(i, j : byte) : boolean;
Var
   xx, yy, k : integer;

Begin
  good := false;
  xx := ddi[i - 1].x + x[i, j];
  yy := ddi[i - 1].y + y[i, j];

  if not (kt[xx, yy]) then exit;
  if i - 1 > 0 then
     if thuoc(xx, yy, i - 1) then exit;

  for k := 0 to i - 2 do
      if trendoan(ddi[k].x, ddi[k].y, xx, yy, ddi[i - 1].x, ddi[i - 1].y) then exit;
  for k := 1 to i - 2 do
      if trendoan(xx, yy, ddi[k - 1].x, ddi[k - 1].y, ddi[k].x, ddi[k].y) then exit;

  good := true;
End;
{********}
Procedure dat(i, j : integer);
Var
   aa, bb, cc : real;

Begin
  ddi[i].x := ddi[i - 1].x + x[i, j];
  ddi[i].y := ddi[i - 1].y + y[i, j];

  kt[ddi[i].x, ddi[i].y] := false;
  lapdt(ddi[i - 1].x, ddi[i - 1].y, ddi[i].x, ddi[i].y, aa, bb, cc);
  dt[i].a := aa;
  dt[i].b := bb;
  dt[i].c := cc;

  if ddi[i].x < xmin then xmin := ddi[i].x;
  if ddi[i].y < ymin then ymin := ddi[i].y;
  if ddi[i].x > xmax then xmax := ddi[i].x;
  if ddi[i].y > ymax then ymax := ddi[i].y;
end;
{********}
Procedure tra(i, j : integer);
Var
   aa, bb, cc : real;

Begin
  kt[ddi[i].x, ddi[i].y] := true;
  ddi[i].x := 0;
  ddi[i].y := 0;

  dt[i].a := 0;
  dt[i].b := 0;
  dt[i].c := 0;
end;
{********}
Procedure error;
Begin
  assign(f, fo); rewrite(f);
  writeln(f, -1);
  Close(f); halt;
End;
{********}
Procedure Print;
Var
   i, deltay, deltax : integer;

Begin
  assign(f, fo); rewrite(f);

  deltay := 0 - ymin;
  deltax := 0 - xmin;

  for i := 0 to m - 1 do
      writeln(f, ddi[i].x + deltax,' ',ddi[i].y + deltay);

  writeln((time - bd) / 18.21 : 10 : 2);
{  readln;}
  Close(f); halt;
end;
{********}
Function cokq : boolean;
Var
   k : integer;
   t : real;

Begin
  cokq := false;

  t := sqrt(d[m]);
  if (xmax - xmin > n) or (ymax - ymin > n) then exit;
  if not bang(kc(ddi[m - 1].x, ddi[m - 1].y, ddi[0].x, ddi[0].y), t) then exit;
  if thuoc(ddi[m - 1].x, ddi[m - 1].y, 1) then exit;
  if thuoc(ddi[0].x, ddi[0].y, m - 1) then exit;

  for k := 1 to m - 2 do
      if trendoan(ddi[k].x, ddi[k].y, ddi[0].x, ddi[0].y, ddi[m - 1].x, ddi[m - 1].y) then exit;

  cokq := true;
End;
{********}
Procedure check;
Begin
  if cokq then print;
   if ((time - bd) / 18.21) > 10 then error;
End;
{********}
Procedure try(i : byte) ;
Var
   j : byte;
   nhoxmin, nhoymin, nhoxmax, nhoymax : shortint;

Begin
  if (xmax - xmin > n) or (ymax - ymin > n) then exit;
  for j := 1 to sl[i] do
      if good(i, j) then
         begin
           nhoxmin := xmin; nhoymin := ymin;
           nhoxmax := xmax; nhoymax := ymax;
           dat(i, j);

           if i = m - 1 then check
              else if i < m - 1 then try(i + 1);

           tra(i, j);
           xmin := nhoxmin; ymin := nhoymin;
           xmax := nhoxmax; ymax := nhoymax;
         end;
End;
{********}
Procedure Solve;
Var
   i : integer;

Begin
  fillchar(kt, sizeof(kt), true);
  kt[0, 0] := false;
  ddi[0].x := 0; {cu lay diem dau la (0, 0) roi tinh tien sau}
  ddi[0].y := 0;
  xmin := 0; xmax := 0;
  ymin := 0; ymax := 0;
  try(1);
End;

Begin
  clrscr;
  bd := time;
  enter;
  Init;
  Solve;
  error;
End.
