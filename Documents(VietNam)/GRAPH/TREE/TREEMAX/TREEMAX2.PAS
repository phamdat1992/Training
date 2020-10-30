{* Tim cay khung lon thu 2
 * Du lieu :
   - N <= 200
   - Aij <= 250
 * Ket qua :
   - ddai cay khung
   - N - 1 dong tiep, cac canh cay khung}

{$R+}
Const
     fi = 'Treemax2.in9';
     fo = 'Treemax2.ou9';
     nmax = 200;

Var
   f : text;
   n, cs1, cs2 : integer;
   a : array [1..nmax, 1..nmax] of byte;
   canh : array [1..nmax, 1..2] of byte;
   d , pred: array [1..nmax] of integer;
   kt : array [1..nmax] of boolean;

Procedure Enter;
Var
   i, j : integer;

Begin
  assign(f, fi); reset(f);
  readln(f, n);

  for i := 1 to n do
      for j := 1 to n do read(f, a[i, j]);

  Close(f);
End;

Procedure Treemax;
var
   i, sl, cs, max : integer;

Begin
  fillchar(kt, sizeof(kt), false);
  fillchar(d, sizeof(d), 0);
  fillchar(pred, sizeof(pred), 0);
  for i := 1 to n do
      begin
           d[i] := a[1, i];
           pred[i] := 1;
      end;
  kt[1] := true; pred[1] := 255;
  sl := 0;

  while sl < n - 1 do
        begin
          inc(sl);
          max :=  0; cs := 0;

          for i := 1 to n do
              if (d[i] > max) and (not kt[i]) then
                 begin
                   max := d[i];
                   cs := i;
                 end;

          kt[cs] := true;
          for i := 1 to n do
              if not kt[i] and (d[i] < a[cs, i]) then
                 begin
                   d[i] := a[cs, i];
                   pred[i] := cs;
                 end;
        end;
End;

Procedure Treemax2;
Var
   i, min, max, j, cs : integer;

Begin
  min := 30000;

  for i := 2 to n do
      begin
        max := 0;

        for j := 1 to n do
            if (a[i, j] > max) and (a[i, j] < a[i, pred[i]]) and (pred[j] <> i) then
               begin
                 max := a[i, j];
                 cs := j;
               end;

        if max <> 0 then
        if a[i, pred[i]] - max < min then
           begin
             min := a[i, pred[i]] - max;
             cs1 := i; cs2 := cs;
           end;
      end;

  pred[cs1] := cs2;
End;

Procedure Print;
Var
   cost, i : longint;

Begin
  assign(f, fo); rewrite(f);

  cost := 0;
  for i := 2 to n do
      cost := cost + a[i, pred[i]];
  writeln(f, cost);

  for i := 2 to n do
      writeln(f, i,' ',pred[i]);

  Close(f);
End;

Begin
  Enter;
  Treemax;
  Treemax2;
  Print;
End.