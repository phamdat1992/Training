{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M  11170,0,655360}
program cat;

uses    crt, graph;
const   max             = 100;
        fi              = 'dg.60';
{
 10 : 51471
 20 : 48151
 30 : 30708
 40 :  9788
 50 :  7194
}


type    point           = record
                                x, y : real;
                          end;
        tpolygon        = record
                                nv  : longint;
                                ver : array [1..20] of point;
                          end;


        seg             = record
                                p1, p2 : point;
                          end;
        tseg            = array[1..max] of seg;

var     n               : longint;
        s               : tseg;
        np              : longint;
        a               : array [1..2000] of ^tpolygon;
        x1, y1, x2, y2  : longint;

procedure input;
   var f  : text;
       i  : longint;
   begin
        assign(f, fi); reset(f);
        readln(f, n, x1, y1, x2, y2);
        for i := 1 to n do
            with s[i] do readln(f, p1.x, p1.y, p2.x, p2.y);
        close(f);
   end;

function same (p1, p2 : point) : boolean;
   begin
        same := (p1.x = p2.x) and (p1.y = p2.y);
   end;

procedure add (var po : tpolygon; p : point);
   begin
        with po do
        begin
             if (nv > 0) and same (p, ver[nv]) then exit;

             inc(nv);
             ver[nv] := p;
        end;
   end;

Procedure abc (p1, p2 : point; var a, b, c : real);
   begin
        a :=   (p1.y - p2.y);
        b :=  -(p1.x - p2.x);
        c :=   ( a * p1.x + b * p1.y);
   end;

function on (p1, p2 : point; p : point) : boolean;
   begin
        on := false;
        if same (p1, p) then exit;
        if ((p1.x - p.x) * (p2.x - p.x) <= 0) and
           ((p1.y - p.y) * (p2.y - p.y) <= 0) then on := true;

   end;

function cut (p1, p2 : point; p3, p4 : point; var p : point) : boolean;
   var a1, b1, c1, a2, b2, c2 : real;
       dt, dty, dtx           : real;
   begin
        abc(p1, p2, a1, b1, c1);
        abc(p3, p4, a2, b2, c2);
        dt  := (a1 * b2 - a2 * b1);
        dtx := (c1 * b2 - c2 * b1);
        dty := (a1 * c2 - a2 * c1);

        cut := false;
        if (dt = 0) then exit;

        p.x := dtx/dt;
        p.y := dty/dt;

        if on(p1, p2, p) then cut := true;
   end;

function divi (j, i :longint; var po1, po2 : tpolygon) : boolean;
    var k, l1, l2 : longint;
        p1, p2    : point;
    begin
         divi := false;

         with a[j]^ do
         begin
              ver[nv+1] := ver[1];
              l1 := 0;
              l2 := 0;

              for k := 1 to nv do
              if cut (ver[k], ver[k+1], s[i].p1, s[i].p2, p1) then
                 if l1 = 0 then l1 := k
                 else l2 := k;

              if (l1 * l2 = 0) then exit;

              divi := true;

              cut (ver[l1], ver[l1+1], s[i].p1, s[i].p2, p1);

              cut (ver[l2], ver[l2+1], s[i].p1, s[i].p2, p2);

              po1.nv := 0;
              add (po1, p1);
              for i := l1+1 to l2 do add (po1, ver[i]);
              add (po1, p2);

              po2.nv := 0;

              for i := 1 to l1 do add(po2, ver[i]);
              add (po2, p1);
              add (po2, p2);
              for i := l2+1 to nv do add (po2, ver[i]);
         end;
    end;

procedure divide (i : longint);
   var j : longint;
       p1, p2 : tpolygon;
   begin

        for j := 1 to np do
        begin
             if divi(j, i, p1, p2) then
             begin
                  a[j]^ := p1;
                  inc(np);
                  new(a[np]);
                  a[np]^ := p2;
             end;
        end;
   end;
procedure display(po : tpolygon; color : longint; style : integer );
   var p : point;
       i : longint;
   begin
        p.x := 0;
        p.y := 0;

        with po do
        begin
             ver[nv+1] := ver[1];
             for i := 1 to nv do p.x := p.x + ver[i].x;
             for i := 1 to nv do p.y := p.y + ver[i].y;
             p.x := p.x/nv;
             p.y := p.y/nv;
             setcolor(15);
             for i := 1 to nv do
                 line ( round (ver[i].x),   round(ver[i].y),
                        round (ver[i+1].x), round(ver[i+1].y));

             setfillstyle(style, color);
             floodfill (round(p.x), round(p.y), 15);
        end;
   end;

function square (i : longint) : real;
   var temp, x : real;
       j    : longint;
   begin
        temp := 0;
        with a[i]^ do
        begin
             ver[nv+1] := ver[1];

             for j := 1 to nv do
             begin

                 x := (ver[j].x - ver[j+1].x) * (ver[j].y + ver[j+1].y);

                 temp := temp + x;
             end;

        end;
        square := abs(temp) /2;
   end;

procedure display1;
   var i                : integer;
   begin
        rectangle (round (x1), round(y1), round(x2), round(y2));
        for i := 1 to n do
        with s[i] do
        begin
             line ( round (p1.x), round(p1.y),
                    round (p2.x), round(p2.y));
        end;
        readln;
   end;

procedure process;
   var i, li : longint;
       p : point;
       grDriver, grMode : integer;
       ls, x : real;
   begin
        np := 1;
        new(a[1]);
        a[1]^.nv := 0;

        p.x := x1; p.y := y1; add (a[1]^, p);

        p.x := x1; p.y := y2; add (a[1]^, p);
        p.x := x2; p.y := y2; add (a[1]^, p);
        p.x := x2; p.y := y1; add (a[1]^, p);

        grDriver := Detect;



        for i := 1 to n do divide(i);

        li := 0;
        ls := 0;

        for i := 1 to np do
        begin
             x := square(i);
             if (x > ls) then
             begin
                  ls := x;
                  li := i;
             end;
        end;
        writeln(square(li):0:0);
        readln;
        initgraph(grDriver, grMode,'c:\laptrinh\pascal\bgi');

        if GraphResult <> GrOk then
        begin
             writeln('error');
             halt;
        end;
        display1;

        for i := 1 to np do display(a[i]^, i mod 7 + 1, 1);
        display(a[li]^, 14, 0);
        readln;
   end;

begin
     clrscr;
     input;
     process;
end.