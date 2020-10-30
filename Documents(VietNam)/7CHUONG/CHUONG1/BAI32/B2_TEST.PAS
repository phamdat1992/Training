program b2_test;
const n = 500;
      h = 200;

var f : text;
    i : integer;
begin
     assign(f, 'b2.ina'); rewrite(f);
     writeln(f, n:4, h : 5);
     for i := 1 to n - 1 do write(f, (random(10) + 1) * 5 : 4);
     writeln(f);
     for i := 1 to n do write(f, random (100) + 10 + i :10);
     writeln(f);
     for i := 1 to n do write(f, random(10) + 2:4);
     close(f);
end.