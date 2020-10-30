Var
   f : text;
   n, p, k, i, sl, j, ii, cty : integer;
   kt, ktr : array [1..100] of boolean;

Function good : boolean;
Var
   ij : integer;

Begin
  good := false;

  for ij := 1 to p do
      if not ktr[ij] then exit;

  good := true;
End;

Begin
  repeat
    fillchar(ktr, sizeof(ktr), false);
    assign(f, 'council.in0'); rewrite(f);
    n :=100; p := 40; k := 50;
    writeln(f, n,' ',p,' ',k);
    randomize;

    for i := 1 to n do
        begin
          cty := 1 + random(p);
          write(f, cty,' ');
          ktr[cty] := true;
          sl := 1 + random(k - 1);
          write(f, sl,' ');
          fillchar(kt, sizeof(kt), true);

          for ii := 1 to sl do
              begin
                 repeat
                   j := 1 + random(k);
                 until kt[j];
                 write(f, j,' ');
                 kt[j] := false;
              end;
          writeln(f);
        end;

    for i := 1 to p do write(f, 1 + random(2),' ');

    Close(f);
  until good;
End.