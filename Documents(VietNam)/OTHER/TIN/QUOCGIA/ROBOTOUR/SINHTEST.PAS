Var
   f : text;
   n, m, i, x, y : integer;

Begin
  assign(f, 'tour.in0'); rewrite(f);
  n := 15; m := 20;
  writeln(f, n,' ',m);
  randomize;

  for i := 1 to m do
      begin
        x := random(n - 4);
        y := random(n - 4);
        write(f, x * x + y * y,' ');
      end;
  Close(f);
End.