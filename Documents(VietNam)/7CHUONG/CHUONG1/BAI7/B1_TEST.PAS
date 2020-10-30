program b1_test;
const n = 1000;
      p = 100;
      l = 100;

var f : text;
    i : integer;
begin
     assign(f, 'b1.in6'); rewrite(f);
     writeln(f,n,' ', p,' ',l);
     for i := 1 to n do
         writeln(f, random (p ) + 1:4, ' ', random(100)+1:4);
     close(f);
end.