{* Thue giay sao cho tong chenh lech min}

{$R+}
Const
     fi = 'Arrang.inp';
     fo = 'Arrang.out';
     nmax = 10000;
     vc = 30000 div 2;

Type
    mang1 = array [1..nmax] of integer;
    mang2 = array [1..2 * nmax] of integer;

Var
   queue, pred :^mang2;
   size, pass, fx, fy :^mang1;
   px, py : mang1;
   f : text;
   n, m, top, last, z : integer;
   bd : longint;
   time : longint absolute $0 : $046C;

Procedure Enter;
Var
   i : integer;

Begin
  assign(f, fi); reset(f);
  readln(f, m, n);

  new(size); new(pass);
  fillchar(size^, sizeof(mang1), 0);
  fillchar(pass^, sizeof(mang2), 0);
  for i := 1 to m do read(f, size^[i]);
  readln(f);
  for i := 1 to n do read(f, pass^[i]);

  Close(f);
End;

Function lech(i, j : integer) : integer;
Begin
  lech := abs(size^[j] - pass^[i]);
End;

Procedure Init;
Var
   i, j, min : integer;

Begin
  new(fx); new(fy);
  fillchar(fy^, sizeof(mang1), 0);
  for i := 1 to n do
      begin
        min := maxint;
        for j := 1 to m do
            if lech(i, j) < min then min := lech(i, j);
        fx^[i] := min;
      end;

  fillchar(px, sizeof(px), 0);
  fillchar(py, sizeof(py), 0);
  new(queue); new(pred);
End;

Procedure Pre(i : integer);
Begin
  fillchar(queue^, sizeof(mang2), 0);
  fillchar(pred^, sizeof(mang2), 0);

  queue^[1] := i;
  top := 1; last := 1;

  pred^[i] := vc;
End;

Procedure nap(i, j : integer);
Begin
  inc(top);
  queue^[top] := j;
  pred^[j] := i;
End;

Function find_path(i : integer) : boolean;
Var
   p, j : integer;

Begin
  Find_path := true;
  pre(i);

  while last <= top do
        begin
          p := queue^[last]; inc(last);

          if p <= n then
             for j := 1 to m do
                 if (pred^[j + n] = 0) then
                    if (fx^[p] + fy^[j] = lech(p, j)) then
                       nap(p, j + n)
                 else
                 else
          else if py[p - n] = 0 then
                  begin
                    z := p;
                    exit;
                  end
                  else nap(p, py[p - n]);
        end;

  Find_path := false;
End;

Procedure Fix_brand;
Var
   i, j, min : integer;

Begin
  min := maxint;
  for i := 1 to n do
      if pred^[i] <> 0 then
         for j := 1 to m do
             if pred^[j + n] = 0 then
                if lech(i, j) - fx^[i] - fy^[j] < min then
                   min := lech(i, j) - fx^[i] - fy^[j];

  for i := 1 to n do
      if pred^[i] <> 0 then fx^[i] := fx^[i] + min;
  for i := 1 to m do
      if pred^[i + n] <> 0 then fy^[i] := fy^[i] - min;
End;

Procedure Inc_couple;
Begin
  while pred^[z] <> vc do
        begin
          if z > n then
             begin
               px[pred^[z]] := z - n;
               py[z - n] := pred^[z];
             end;
          z := pred^[z];
        end;
End;

Procedure Solve;
Var
   i : integer;

Begin
  for i := 1 to n do
      if px[i] = 0 then
         begin
           while not find_path(i) do fix_brand;
           inc_couple;
         end;
End;

Procedure Print;
Var
   sum, i : integer;

Begin
  assign(f, fo); rewrite(f);

  sum := 0;
  for i := 1 to n do
      sum := sum + lech(i, px[i]);
  writeln(f, sum);

  Close(f);
End;

Begin
  bd := time;
  Enter;
  Init;
  Solve;
  Print;
  write((time - bd) / 18.21 : 10 : 2);
End.