program taotest;

const   max     = 100;
        fi      = 'dark.1';

var     i : integer;
        l,x,  h, n, m : longint;

        f : text;
begin

     l := 10000;
     n := 30;
     m := 100;
     h := 1000;
     randomize;
     assign(f, 't3.inp'); rewrite(f);
     writeln(f, l,' ',n, ' ', h, ' ',m);

     for i := 1 to n do write(f, random (l):8);
     writeln(f);

     for i := 1 to m do
     begin
          x := random (l - 10);
          write(f, x:8, x + random (100) + 50:8, random (h-1)+1:8);
     end;

     close(f);
end.