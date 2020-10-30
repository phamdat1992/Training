{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program dark_street;

uses    crt;
const   max             = 100;
        fi              = 'd.10';
{3353, 1095, 1099, 887, 2941}
{ 10    30    50    80  100}
type    seg             = record
                                l, r : real;
                          end;
       ta               = array [1..max] of record
                                                  s  : seg;
                                                  hi : integer;
                                            end;
       tli              = array [1..max] of real;
       tlist            = array [1..max] of seg;


var    H, L, n, m       : integer;
       a                : ta;
       li               : tli;
       lr               : tlist;
       nrs              : integer;
       time             : longint absolute $0000:$046c;
       time1            : longint;


procedure input;
   var f : text;
       i : integer;
   begin
        assign(f, fi); reset(f);
        readln(f, L, n, H, m);
        for i := 1 to n do read(f, li[i]);
        readln(f);
        for i := 1 to m do
            with a[i] do read(f, s.l, s.r, hi);
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

procedure sub (var d1, d2 : seg; var dx1, dx2 : seg);
   begin
        dx1.l := d1.l;               dx1.r := tmin (d1.r, d2.l);
        dx2.l := tmax (d1.l, d2.r);  dx2.r := d1.r;
   end;


procedure add (var list : tlist; var ns : integer; p : seg);
   begin
        if (p.l >= p.r) then exit;
        inc(ns);
        list[ns] := p;
   end;


procedure dele(var list : tlist; var ns : integer; ind : integer);
   var j : integer;
   begin
        for j := ind to ns do
            list[j] := list[j+1];
        dec(ns);
   end;

function inside (x : real; var p : seg) : boolean;
   begin
        inside := ( x- p.l) * (x - p.r) <= 0;
   end;

procedure redu(var list : tlist; var ns : integer);
   var i, j : integer;
       ok   : boolean;
       p    : seg;
   begin
        repeat
              ok := true;
              for i := 1 to ns do
              begin
                  for j := i + 1 to ns do
                  if inside (list[i].l, list[j]) or inside (list[j].l, list[i]) then
                  begin
                       p.l := tmin (list[i].l, list[j].l);
                       p.r := tmax (list[i].r, list[j].r);
                       dele(list, ns, j);
                       list[i] := p;
                       ok := false;
                       break;
                  end;
                  if not ok then break;
              end;
        until ok;
   end;


procedure chieu (i, j : integer; var list : tlist; var ns : integer);
   var p, temp1, temp2 : seg;
       list1 : tlist;
       ns1   : integer;
   begin
        p.l := (a[j].s.l - li[i]) * (h / (h - a[j].hi)) + li[i];
        p.r := (a[j].s.r - li[i]) * (h / (h - a[j].hi)) + li[i];

        ns1 := 0;
        for i := 1 to ns do
        begin
             sub (list[i], p, temp1, temp2);
             add (list1, ns1, temp1);
             add (list1, ns1, temp2);
        end;
        list := list1;
        ns := ns1;
   end;


procedure lam(i : integer);
   var ns : integer;
       list : tlist;
       p    : seg;
       j    : integer;
   begin
        write(#13,i);
        ns := 0;
        p.l := 0;
        p.r := L;
        add (list, ns, p);
        for j := 1 to m do chieu(i, j, list, ns);

        for j := 1 to ns do add (lr, nrs, list[j]);

        redu (lr, nrs);
   end;

procedure process;
   var i : integer;
       len :  real;
   begin
        nrs := 0;
        for i := 1 to n do lam(i);
        writeln;
        for i := 1 to nrs do
            writeln(lr[i].l:8:2, lr[i].r:12:2);

        len := L;
        for i := 1 to nrs do
            len := len - (lr[i].r- lr[i].l);
        writeln('Number of light segs: ',nrs);
        writeln('Dark len: ', len:0:0);

   end;


begin
     time1 := time;
     clrscr;
     input;
     process;
     writeln('Time:', time-time1,'(/18.2)');
end.