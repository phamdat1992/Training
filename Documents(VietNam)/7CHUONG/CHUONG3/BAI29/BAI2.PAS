program bai2;
uses    crt;
const   max             = 10;
        fi              = 'bai2.73'; {out.73}
        fo              = 'square.out';

type    ta              = array [-max..max*2, -max..2*max] of integer;
        tdd             = array [0..max*max] of boolean;

var     a, b            : ta;
        m, n            : integer;

procedure input;
   var i, j : integer;
       f    : text;
   begin
        fillchar(a, sizeof(a), 0);
        assign(f, fi); reset(f);
        readln(f, m, n);
        for i := 1 to m do
        begin
             for j := 1 to m do read(f, a[i, j]);
             readln(f);
        end;
        close(f);
   end;



function ok (k, i, j : integer) : boolean;
   var p, q : integer;
   begin
        ok := false;

        a[i, j] := 0;
        for p := 0 to n-1 do
            for q := (-n+1) to n-1 do
                 if a[ i - p, j - q] = k then exit;

        ok := true;
   end;


procedure taonn;
   var i, j, k : integer;
       f       : text;
   begin
        m := 10;
        n := 4;
        assign(f, 'bai2.10'); rewrite(f);
        fillchar(a, sizeof(a), 0);

        for i := 1 to m do
            for j := 1 to m do
            if (random (100) > 30) then
               for k := 1 to n * n do
                     if ok (k, i, j) then
                     begin
                          a[i, j] := k;
                          if random (2) = 1 then break;
                     end;

        writeln(f, m,' ', n);
        for i := 1 to m do
        begin
             for j := 1 to m do write(f, a[i, j]:4);
             writeln(f);
        end;
        close(f);
        halt;
   end;


function ok1 (i, j : integer)  : boolean;
   var temp, k, h: integer;
   begin
        temp := b[i, j];
        b[i, j] := 0;
        ok1 := false;
        for k := 0 to n-1 do
            for h := 0 to n-1 do
                if (b[k + i, h + j] = temp) then exit;
        b[i, j] := temp;
        ok1 := true;
   end;

procedure display (var a, b : ta);
   var i, j : integer;
   begin
        for i := 1 to m do
        begin
             for j := 1 to m do write(a[i, j] : 3);
             write(' ':4);
             for j := 1 to m do
             begin
                  if (a[i, j] = 0) then textcolor(12);
                  write(b[i, j]:3);
                  textcolor(7);
             end;
             writeln;
        end;

   end;


procedure test;
   var i, j : integer;
   begin

        for i := 1 to n do
            for j := 1 to n do
            if not ok1 (i, j) then write(i:8, j: 4);
   end;

procedure build (var a : ta; i,j : integer);
   var dd : tdd;
       p, q: integer;
   begin
        fillchar(dd, sizeof(dd), true);



        for p := -(n-1) to (n-1) do
            for q := -(n-1) to (n-1) do
                dd[ a[ i + p, j + q] ] := false;


        for p := 1 to n*n do
            if dd[p] then
            begin
                 a[i, j] := p;
                 exit;
            end;
   end;

procedure input2;
   var i, j : integer;
       f    : text;
   begin
        assign(f, fo); reset(f);
        readln(f);
        for i := 1 to m do
        begin
             for j := 1 to m do read(f, b[i, j]);
             readln(f);
        end;
        close(f);
   end;


procedure build1;
   var i, j : integer;
   begin
        b := a;
        display(b, a);
        for i := 1 to m do
            for j := 1 to m do
            if (a[i, j] = 0) then build (a, i, j);
       writeln;
       display(b, a);
   end;


begin
    { taonn;}
     clrscr;
      input;
      INPUT2;
      display(a, b);
      test;
    { taonn;}
end.