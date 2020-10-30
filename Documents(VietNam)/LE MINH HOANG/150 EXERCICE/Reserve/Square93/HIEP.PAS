{$R+}
Const
     fi = 'Square93.inp';
     fo = 'Square93.out';

     hv : array [1..27, 1..4] of integer =
          ((1, 1, 1, 9),
           (2, 1, 2, 9),
           (3, 1, 3, 9),
           (4, 1, 4, 9),
           (5, 1, 5, 9),
           (6, 1, 6, 9),
           (7, 1, 7, 9),
           (8, 1, 8, 9),
           (9, 1, 9, 9),
           (1, 1, 9, 1),
           (1, 2, 9, 2),
           (1, 3, 9, 3),
           (1, 4, 9, 4),
           (1, 5, 9, 5),
           (1, 6, 9, 6),
           (1, 7, 9, 7),
           (1, 8, 9, 8),
           (1, 9, 9, 9),
           (1, 1, 3, 3),
           (1, 4, 3, 6),
           (1, 7, 3, 9),
           (4, 1, 6, 3),
           (4, 4, 6, 6),
           (4, 7, 6, 9),
           (7, 1, 9, 3),
           (7, 4, 9, 6),
           (7, 7, 9, 9));

     maxt = 9.95;

Var
   sl, a : array [1..9, 1..9] of byte;
   qhe : array [1..9, 1..9, 1..27] of byte;
   kt : array [1..27, 1..9] of boolean;
   f : text;

   bd : longint;
   time : longint absolute $0 : $046C;

Procedure Enter;
Var
   i, j, ii : integer;
   c : char;

Begin
  assign(f, fi); reset(f);

  fillchar(a, sizeof(a), 0);
  fillchar(kt, sizeof(kt), false);
  for i := 1 to 9 do
      begin
        for j := 1 to 9 do
            begin
              read(f, c);
              if c = '.' then a[i, j] := 0
              else begin
                     a[i, j] := ord(c) - ord('0');

                     for ii := 1 to sl[i, j] do
                         kt[qhe[i, j, ii], a[i, j]] := true;
                   end;
            end;

        readln(f);
      end;

  Close(f);
End;

Function inside(i, j, ii : integer) : boolean;
Begin
  inside := true;

  if (i >= hv[ii, 1]) and (i <= hv[ii, 3]) then
     if (j >= hv[ii, 2]) and (j <= hv[ii, 4]) then exit;

  inside := false;
End;

Procedure Init;
Var
   i, j, ii : integer;

Begin
  for i := 1 to 9 do
      for j := 1 to 9 do
          begin
            sl[i, j] := 0;

            for ii := 1 to 27 do
                if inside(i, j, ii) then
                   begin
                     inc(sl[i, j]);
                     qhe[i, j, sl[i, j]] := ii;
                   end;
          end;

  fillchar(kt, sizeof(kt), false);
End;

Function tot(i, j, ii : byte) : boolean;
Var
   ij : byte;

Begin
  tot := false;

  for ij := 1 to sl[i, j] do
      if kt[qhe[i, j, ij], ii] then exit;

  tot := true;
End;

Procedure dat(i, j, ii : byte);
Var
   ij : byte;

Begin
  a[i, j] := ii;

  for ij := 1 to sl[i, j] do
      kt[qhe[i, j, ij], ii] := true;
End;

Procedure tra(i, j, ii : byte);
Var
   ij : byte;

Begin
  a[i, j] := 0;

  for ij := 1 to sl[i, j] do
      kt[qhe[i, j, ij], ii] := false;
End;

Procedure Print;
Var
   i, j: integer;

Begin
  assign(f, fo); rewrite(f);

  for i := 1 to 9 do
      begin
        for j := 1 to 9 do write(f, a[i, j]);
        writeln(f);
      end;

  writeln((time - bd) / 18.21 : 0 : 2);
  Close(F); halt;
End;

Procedure Error;
Begin
  assign(f, fo); rewrite(f);

  writeln(f, 'IMPOSSIBLE');

  writeln((time - bd) / 18.21 : 0 : 2);
  Close(f); halt;
End;


Procedure try(i, j : byte);
Var
   ii : byte;

Begin
  if (time - bd) / 18.21 > maxt then error;

  if a[i, j] = 0 then
     for ii := 1 to 9 do
         if tot (i, j, ii) then
            begin
              dat(i, j, ii);

              if j < 9 then try(i, j + 1)
              else if i < 9 then try(i + 1, 1)
                   else print;

              tra(i, j, ii);
            end
         else
  else if j < 9 then try(i, j + 1)
          else if i < 9 then try(i + 1, 1)
               else print;
End;

Begin
  bd := time;

  Init;
  Enter;
  Try(1, 1);
  Error;
End.