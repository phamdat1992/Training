const
     n    = 80;
     FI   = 'house.inp';

var
    f : text;
    i,j : integer;

begin
     assign(f, FI);
     rewrite(f);
     writeln(f, n);
     for i := 1 to n do
      begin
           for j := 1 to n do
            if odd(random(2)) then write(f, 1 , ' ') else
                                   write(f,0, ' ');
           writeln(f);
      end;
end.