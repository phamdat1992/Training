program taottdg;

uses    crt;
type    doan = record
                     x, y : integer;
               end;

var     f : text;
        n,i : integer;
        p1, p2 : doan;

procedure sinh (var p : doan);
   begin
        if (random (2) = 0) then
          begin
               p.x := random (600);

               if random (2) = 0 then p.y := 0
               else p.y := 400;
          end
          else
              begin
                   if random (2) = 0 then p.x := 0
                   else p.x := 600;
                   p.y := random (400);
              end;

   end;

begin
     n := 50;
     assign(f, 'dg.50'); rewrite(f);
     randomize;
     writeln(f, n:8, ' 0 0 600 400');

     for i := 1 to n do
     begin
          repeat
                sinh (p1);
                sinh (p2);
          until (p1.x <> p2.x) and (p1.y <> p2.y);
          writeln(f, p1.x:8, p1.y:8, p2.x:8, p2.y:8);
          {writeln(f, random (600):8, random (400):8, random (600):8, random (400):8);}
     end;
     close(f);
end.