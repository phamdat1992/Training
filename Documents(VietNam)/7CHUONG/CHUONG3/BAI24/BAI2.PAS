{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program bai2;
uses    crt;
const   max     = 20;
        fi      = 'b2.in2'; {b2.ou9}
        fo      = 'b2.out';
        t       : array [1..4, 1..2] of integer =
        ( (-1, -1), (-1, 1), (1, 1), (1, -1)        );
        bd      : array [1..4, 1..2] of integer=
        ( (2, 4), (1, 3), (4, 0), (3, 0)        );
type    ta      = array [1..max, 1..max] of integer;
        tb      = array [1..max, 0..2] of integer;
var     a       : ta;
        b       : tb;
        ssb, m, n    : integer;

procedure input;
   var f : text;
       i, j : integer;
   Begin
        assign(f, fi); reset(f);
        readln(f, m, n);
        for i := 1 to m do
        Begin
             for j := 1 to n do read(f, a[i, j]);
             readln(f);
        End;
        close(f);
   End;

function empty_col (i : integer) : boolean;
   var j : integer;
   Begin
        empty_col := false;
        for j := 1 to m do
            if a[j, i] = 1 then exit;
        empty_col := true;
   End;

function count : integer;
   var i, temp : integer;
Begin
     temp := 0;
     for i := 1 to n do
         if not empty_col (i) then temp := temp + 1;
     count := temp;
End;

procedure hien1;
  var i, j : integer;
  Begin
       for i := 1 to m do
       Begin
            for j := 1 to n do
            Begin
                 if (a[i, j] = 1) then
                 Begin
                      textcolor(12); write(1:4);
                      textcolor(7);
                 End;
                 if (a[i, j] = 0) then write(0:4);
                 if (a[i, j] <> 1) and (a[i, j] <> 0) then
                 Begin
                      textcolor(15);
                      write(-a[i, j] div 1000:4);
                      textcolor(7);
                 End;
            End;
             writeln;
       End;

  End;
procedure ghinhan(sb : integer);
   var temp, i, j : integer;
   Begin
        temp := count;
        if temp + sb >= ssb then exit;
        ssb := sb + temp;
        clrscr;
        writeln(ssb, temp:10);
        hien1;
   End;

function ban (x,  h : integer) : boolean;
   var temp, i, j, it, jt, dem : integer;
   Begin
        temp := x * 1000 + h;
        i := m;
        j := x;
        ban := false;
        dem := 0;
        while (h > 0) do
        Begin
             if a[i, j] = 1 then
             Begin
                  a[i, j] := temp;
                  inc(dem);
                  ban := dem > 1;
             End;
             it := i + t[h][1];
             jt := j + t[h][2];
             if (it > m) or (it < 1) then h := bd[h][2];
             if h = 0 then exit;
             if (jt > n) or (jt < 1) then h := bd[h][1];
             if (it * jt > 0) and (it <= m) and (jt <= n) then
             Begin
                  i := it;
                  j := jt;
             End;
        End;
   End;

procedure gan(x,  h : integer);
   var i, j, it, jt, temp : integer;
   Begin
        temp := x * 1000 + h;
        i := m;
        j := x;
        while (h > 0) do
        Begin
             if a[i, j] = temp then a[i, j] := 1;
             it := i + t[h][1];
             jt := j + t[h][2];
             if (it > m) or (it < 1) then h := bd[h][2];
             if h = 0 then exit;
             if (jt > n) or (jt < 1) then h := bd[h][1];
             if (it * jt > 0) and (it <= m) and (jt <= n) then
             Begin
                  i := it;
                  j := jt;
             End;
        End;
   End;

procedure try ( i, j, sb  : integer);
   Begin
        if ( i > n) then
        Begin
             ghinhan(sb );
             exit;
        End;
        if (sb >= ssb) then exit;
        if ( j = 3) then
        Begin
             try (i + 1, 1, sb);
             exit;
        End;
        if (b[i, j] = 1) then
        Begin
             if ban (i, j) then try (i, j + 1, sb + 1);
             gan(i, j);
        End;
        try (i, j + 1, sb);
   End;

function di (x, h1 : integer; var y, h2 : integer) : boolean;
   var i, j : integer;
       it, jt : integer;
   Begin
        i := m;
        j := x;

        di := false;

        while (h1 > 0) do
        Begin
             if (a[i, j] = 1) then di := true;

             y := j;
             h2 := h1;

             it := i + t[h1][1];
             jt := j + t[h1][2];

             if (it > m) or (it < 1) then h1 := bd[h1][2];

             if h1 = 0 then exit;

             if (jt > n) or (jt < 1) then h1 := bd[h1][1];
             if (it * jt > 0) and (it <= m) and (jt <= n) then
             Begin
                  i := it;
                  j := jt;
             End;
        End;
   End;

procedure build;
   var i, j, x, h : integer;
       ok         : boolean;
   Begin

        for i := 1 to n do
        Begin

             for j := 1 to 2 do
             if b[i, j] = 1 then
             Begin
                  ok := di(i, j, x, h);

                  dec(h, 2);

                  if (i <> x) or (j <> h) then b[x, h] := 0;

                  if not ok then b[i, j] := 0;

             End;

             if empty_col(i) then b[i, 0] := 0;

        End;

   End;

procedure init;
   var i, j : integer;
   Begin
        ssb := n+1;
        for i := 1 to max do
            for j := 0 to 2 do b[i, j] := 1;

        build;

   End;

procedure hien;
   var i, j : integer;
   Begin
        for i := 1 to m do
        Begin
             for j := 1 to n do write(a[i, j] :8);
             writeln;
        End;
   End;

Begin
     textcolor(7);
     clrscr;
     input;
     init;
{     ban(3,1);
     ban(3,2);
     hien;
 }   try (1, 1, 0);
End.