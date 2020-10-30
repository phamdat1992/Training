program b1;

uses    crt;

const   max             = 1000;
        fi              = 'b1.in1';
        fo              = 'b1.out';

type    ta              = array[1..max] of integer;
        tt              = array[0..max] of real;


var     n, p, l         : integer;
        w, v            : ta;
        t               : tt;
        f               : text;

procedure input;
   var f : text;
       i : integer;
   begin
        assign(f, fi); reset(f);
        readln(f, n, p, l);
        for i := 1 to n do readln(f, w[i], v[i]);
        close(f);
   end;


function tinh (i, j : integer) : real;
   var sum_w, k : integer;
       v_min : real;
   begin
        tinh := -1;
        sum_w := 0;
        for k := i to j do inc (sum_w, w[k]);
        if sum_w > p then exit;

        v_min := 1E+30;
        for k := i to j do
            if v_min > v[k] then v_min := v[k];
        tinh := l/v_min;
   end;


function min (x, y : real) : real;
   begin
        if x > y then min := y
        else min := x;
   end;

function count (i : integer) : real;
   var j : integer;
       value, phu : real;
   begin
        value := 1E+30;
        for j := i downto 1 do
        begin
             phu := tinh (j, i);
             if phu = -1 then break;
             value := min (value, phu + t[j - 1]);
        end;
        count := value;
   end;

procedure lam(i : integer);
   var k : integer;
   begin
        if i = 0 then exit;

        for k := i downto 1 do
            if (t[i] = tinh (k, i) + t[k - 1])   then
            begin
                 lam(k - 1);
                 writeln(f, i);
                 exit;
            end;
   end;

procedure process;
   var i : integer;
   begin

        for i := 1 to n do t[i] := 1e+30;
        t[0] := 0;

        for i := 1 to n do t[i] := count(i);


        assign(f, fo); rewrite(f);
        writeln(f, t[n]);
        lam(n);
        close(f);


   end;

begin
     clrscr;
     input;
     process;


end.