program tt;

uses    crt;

const   max             = 100;

var     f               : text;
        l, m, n, h      : longint;
        i, x            : longint;
begin
     l := 10000;
     h := 1000;
     n := 100;
     m := 100;
     assign(f, 'd.100'); rewrite(f);
     writeln(f, l : 8, n:5, h : 5, m:5);
     for i := 1 to n do write(f, random (l):10);
     writeln(f);
{     randomize;}
     for i := 1 to m do
     begin
          x := random (l);
          write(f, x:12, x + random(50) + 280:8, random (h-5):8);
     end;

     close(f);
end.