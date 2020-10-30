{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program bailam;

uses	crt, graph;

const	max			= 500;
        fi          = 't3.inp';
        fo          = 'dark.out';
        eps         = 1E+30;

type    doan        = record
                            l, r : real;
                            hi   : real;
                      end;
        ta          = array [1..max] of doan;

        tden        = array [1..max] of real;

        dsdoan      = array [1..max] of doan;


var     a           : ta;
        m, n        : integer;
        L, H        : real;
        den         : tden;
        ds          : dsdoan;
        sd          : integer;
        kq          : dsdoan;
        sdkq        : integer;


procedure input;
   var i : integer;
       f : text;
   begin
        assign(f, fi); reset(f);
        readln(f, L, n, h, m);
        for i := 1 to n do read(f, den[i]);
        readln(f);
        for i := 1 to m do
        with a[i] do
            read(f, l, r, hi);
        close(f);
   end;


function tmin (x, y : real) : real;
   begin
        tmin := x;
        if (x > y) then tmin := y;
   end;

function tmax (x, y : real) : real;
   begin
        tmax := x;
        if (x < y) then tmax := y;
   end;


procedure tru (d1, d2 : doan; var dx1, dx2 : doan);
   begin
        dx1.l := d1.l;   dx1.r := tmin (d2.l, d1.r);
        dx2.l := tmax(d2.r, d1.l) ;   dx2.r := d1.r;
   end;


procedure add(p : doan; var ds : dsdoan; var sd : integer);
   begin
        if (p.r <= p.l) then exit;

        inc(sd);
        ds[sd] := p;
   end;



procedure chieu (i , j : integer);
    var p   : doan;
        sd1 : integer;
        ds1 : dsdoan;

        k   : integer;

        temp1, temp2: doan;

    begin

         p.l := (a[j].l - den[i]) * (h/(h-a[j].hi)) + den[i];
         p.r := (a[j].r - den[i]) * (h/(h-a[j].hi)) + den[i];


         sd1 := 0;
         for k := 1 to sd do
         begin
              tru (ds[k], p, temp1, temp2);  {ds[k] : doan thu k den i chieu sang}
              add (temp1, ds1, sd1);
              add (temp2, ds1, sd1);
         end;

         sd := sd1;
         ds := ds1;
    end;

procedure swap (var d1, d2 : doan);
  var temp : doan;
  begin
       temp := d1;
       d1 := d2;
       d2 := temp;
  end;

procedure loaibods (i : integer; var ds : dsdoan; var  sd : integer);
   var j : integer;
   begin
        for j := i  to sd do ds[j] := ds[j+1];
        dec (sd);
   end;


function inside (x : real; p : doan) : boolean;
   begin
        inside := (x - p.l) * (x - p.r) <= 0;
   end;

procedure lamgonds(var ds : dsdoan; var sd : integer);
   var i, j : integer;
       ok : boolean;
       p : doan;
   begin
        repeat
              ok := true;
              for i := 1 to sd do
              begin
                  for j := i + 1 to sd do
                  if inside (ds[j].l, ds[i]) or inside (ds[i].l, ds[j])
                  then
                  begin
                       p.l := tmin (ds[i].l, ds[j].l);
                       p.r := tmax (ds[i].r, ds[j].r);
                       loaibods (j, ds, sd);
                       loaibods (i, ds, sd);
                       add (p, ds, sd);
                       ok := false;
                       break;
                  end;
                  if not ok then break;
              end;
        until ok;
   end;

procedure lam (i : integer);
   var j : integer;
       p : doan;
   begin
        sd := 0;
        p.l := 0; p.r := L; add (p, ds, sd);


        for j := 1 to m do chieu(i, j);

        for i := 1 to sd do
            add (ds[i], kq, sdkq);

        lamgonds(kq, sdkq);
   end;


procedure init;
   begin
        sdkq := 0; { sdkq}
        {kq}
   end;

procedure display;
   var ti, i : integer;
       day : integer;
       grDriver, grMode : integer;
   begin

        grDriver := DETECT;
        initgraph(grDriver, grMode,'c:\laptrinh\pascal\bgi');
        ti := round (tmin (getmaxx/ l, getmaxy/h));

        day := round(h) * ti;
        setcolor(0);

        line (0, day, round(l * ti), day);

        setcolor(15);
        for i := 1 to m do
        with a[i] do
        begin
             line ( round (l * ti), day- round(hi * ti),  round(r * ti), day- round(hi * ti));
        end;

        for i := 1 to n do
        begin
             circle (round(den[i] * ti), 1, 5);
        end;
        setcolor(12);
        for i := 1 to sdkq do
        with kq[i] do
        begin
             setcolor(i);
             line ( round (l * ti), day,  round(r * ti), day);
        end;
        readln;
   end;

procedure process;
   var i : integer;
       len : real;
   begin
        for i := 1 to n do lam(i);

        for i := 1 to sdkq do
            writeln(kq[i].l : 8 : 3, kq[i].r:12:3);

        len := 0;
        for i := 1 to sdkq do len := (kq[i].r -kq[i].l) + len;


        writeln(l - len : 10:4);
        readln;
        display;

   end;




begin
     clrscr;
     input;
     init;
     process;
end.