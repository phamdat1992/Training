{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program trip;
uses crt, graph;
const	max				= 100;
    	fi		        = 'trip.5';
        fo              = 'trip.out';

type    trt             = record
                                x1, y1, x2, y2 : integer;
                                c              : integer;
                          end;
        ta              = array [1..max] of trt;

        vector          = array [1..2*max] of integer;

var     a               : ta;
        n               : integer;
        x, y            : vector;
        nx, ny          : integer;




procedure input;
   var f : text;
       i : integer;
   begin
        assign(f, fi); reset(f);
        readln(f, n);
        for i := 1 to n do
            with a[i] do readln(f, x1, y1, x2, y2, c);
        close(f);
   end;

procedure add(gt : integer; var x:  vector; var n : integer);
   var i : integer;
   begin
        for i := 1 to n do
            if x[i] = gt then exit;
        inc(n);
        x[n] := gt;
   end;

procedure sort (var x : vector; n : integer);
   var i, j, temp : integer;
   begin
        for i := 1 to n do
            for j := i+1 to n do
            if x[i] > x[j] then
            begin
                 temp := x[i];
                 x[i] := x[j];
                 x[j] := temp;
            end;
   end;


procedure init;
   var i : integer;
   begin
        nx := 0;
        ny := 0;
        for i := 1 to n do
        with a[i] do
        begin
             add (x1, x, nx);
             add (x2, x, nx);

             add (y1, y, ny);
             add (y2, y, ny);
        end;
        sort (x, nx);
        sort (y, ny);
   end;

function inside_point (x, y : integer; i : integer) : boolean;
   begin
        with a[i] do
             inside_point := ((x1-x) * (x2-x) <= 0) and ((y1-y) * (y2-y) <= 0);
   end;


function inside (k, h : integer; i : integer) : boolean;
   begin
        inside := inside_point (x[k], y[h], i) and
                  inside_point (x[k+1], y[h+1], i);
   end;

function st(k, h : integer) : integer;
   var dd : array [1..3] of integer;
       i  : integer;
   begin
        fillchar(dd, sizeof(dd), 0);
        for i := 1 to n do
            if inside (k, h, i) then inc(dd[ a[i].c]);

        st := 0;
        for i := 1 to 3 do
            if dd[i] = 0 then exit;
        st := 2;
        for i := 1 to 3 do
            if dd[i] > 1 then exit;
        st := 1;
   end;

function square (i, j  : integer) : integer;
   begin
        square := (x[i+1] - x[i]) * (y[j+1] - y[j]);
   end;


procedure main;
   var i, j, ok : integer;
       dt1, dt2 : integer;
   begin
        dt1 := 0;
        dt2 := 0;
        for i := 1 to nx - 1 do
            for j := 1 to ny - 1 do
            begin
                 ok := st (i, j);
                 if (ok > 0) then inc(dt1, square (i, j));
                 if (ok = 1) then inc(dt2, square (i, j));
            end;
        writeln(dt1,dt2:10);
   end;


procedure display;
   var grDriver, grMode : integer;
       i, rate, j       : integer;
       ok               : integer;
   begin
        grDriver := detect;
        initgraph(grDriver, grMode, 'c:\laptrinh\pascal\bgi');
        setcolor(8);
        rate := 5;

        for i := 1 to nx do
            line (rate * x[i], 1, rate * x[i], getmaxy);

        for i := 1 to ny do
            line (1, getmaxy- rate * y[i], getmaxx, getmaxy-rate * y[i]);

        setcolor(1);
        for i := 1 to n do
        with a[i] do
        begin
             setcolor(c);
             rectangle (x1*rate, getmaxy-y1*rate, x2*rate, getmaxy-y2*rate);
        end;

        for i := 1 to nx-1 do
            for j := 1 to ny - 1 do
            begin
                 ok := st (i, j) ;
                 if ok = 0 then continue;
                 setfillstyle(1, ok);
                 bar (x[i] * rate, getmaxy- y[j] * rate,
                      x[i+1] * rate, getmaxy-y[j+1] * rate);
            end;

        readln;
        closegraph;
   end;

procedure taotest;
   var f : text;
       i, c : integer;
       x1, y1, x2, y2 : integer;
   begin
        n := 50;
        assign(f, fi); rewrite(f);
        writeln(f, n);
        for i := 1 to n do
        begin
             x1 := random (50);
             y1 := random (50);
             x2 := x1 + random (10) + 5;
             y2 := y1 + random (10) + 5;
             c := random (3) + 1;
             writeln(f, x1:5, y1:5, x2:5, y2:5, c:5);
        end;
        close(f);
   end;


begin
{     taotest;}
     clrscr;
     input;
     init;
     display;
     main;
end.

4
0 0 5 5 1
1 1 4 4 2
1 1 4 5 3
2 2 3 3 3


4
00 00 50 50 10
10 10 40 40 20
10 10 40 50 30
20 20 30 30 30