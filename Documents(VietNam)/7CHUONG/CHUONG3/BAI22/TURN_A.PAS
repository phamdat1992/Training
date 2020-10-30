{$A+,B-,D+,E+,F-,G+,I+,L+,N+,O-,P-,Q+,R-,S+,T-,V+,X+}
{$M 16384,0,655360}

program turn_around;
uses    crt;

const   max     = 40;
        fi      = 'turn_a.40';
        fo      = 'turn_a.out';

        tx      : array [1..6] of integer = (-1, -1,  0,  1,  1,  0);
        ty      : array [1..6] of integer = (-1, +1,  2,  1, -1, -2);


type    ta      = array [-2..max, -2..max] of byte;
        tip     = array [0..max] of byte;
        ttd     = array [0..max] of record
                                          x, y : integer;
                                    end;

var     a       : ta;
        ip      : tip;
        n, i    : integer;
        p, q    : integer;
        td      : ttd;
        kq      : tip;
        time    : longint ;
        time_save : longint absolute 0:$46c ;
procedure test; forward;

procedure input;
   var f : text;
       i : integer;
   begin
        assign(f, fi); reset(f);
        readln(f, n);
        for i := 1 to n do read(f, ip[i]);
        close(f);
   end;
procedure display;
   var i, j : integer;
   begin
        gotoxy(1,1 );
        writeln;
        for i := 1 to p do
        begin
             for j := 1 to 2 * p do write(ip[a[i, j]] : 4);
             writeln;
        end;

   end;
procedure init;
   var i, j, temp : integer;
   begin
        fillchar(a, sizeof(a), 0);
        for i := 1 to n do
            if (i * (i+1) >= 2*n) then
            begin
                 p := i;
                 break;
            end;

        temp := 0;
        for i := p downto 1 do
        begin
             for j := 1 to i do
             begin
                  inc(temp);
                  if temp > n then break;
                  a[p-i+1, (j-1) * 2 + (p-i+1)] := temp;
             end;
        end;

        for i := 1 to p do
            for j := 1 to 2*p do
            with td[ a[i, j]] do
            begin
                 x := i;
                 y := j;
            end;
        td[n+1] := td[n];
   end;

procedure quay (h : integer; value : integer);
   begin
        if h = 0 then exit;
        if value = 1 then
           if (ip[h] = 4) then ip[h] := 1
           else inc(ip[h])
        else
            if (ip [h] = 1) then ip[h] := 4
            else dec (ip[h]);
   end;


procedure xoay(h : integer);
   var i, j, xp, yp, x, y, k : integer;
   begin
        quay(h, 1);
        for k := 1 to 6 do
        begin
             xp := td[h].x + tx[k];
             yp := td[h].y + ty[k];
             quay ( a[xp, yp],-1);
        end;
   end;

procedure ghinhan;
   var i, temp : integer;
       f : text;
   begin
        for i := 1 to n do
            if ip[i] <> 1 then exit;

        assign(f, fo); rewrite(f);
        temp := 0;
        for i := 1 to n do
            if ip[i] > 0 then temp := temp + 1;
        writeln(f, temp);

        for i := 1 to n do
            if (kq[i] <> 0) then writeln(f, i:5, kq[i] : 4);
        close(f);
             writeln ( ( time_save - time ) / 18.21 : 0 : 4 ) ;
        readln ;

        {test;}
        halt;
   end;


procedure try(i : integer);
   var k, solx, j : integer;

   begin
        if (i > n) then begin
           ghinhan;
           exit;
        end;

        if (td [i].x < 2) then
        begin
             for k := 0 to 3 do
             begin
                  kq[i] := k;

                  try(i+1);

                  xoay(i);
             end;
        end
        else
            begin
                 j := a [ td[i].x + tx[1], td[i].y + ty[1]];
                 solx := ip[j] - 1;

                 kq[i] := solx;
                 for k := 1 to solx do xoay (i);

                 if (td [i+1].x <> td[i].x) then
                 begin
                      j := a [ td[i].x + tx[2], td[i].y + ty[2]];
                      if ip[j] = 1 then try (i + 1);
                 end
                 else try (i + 1);


                 if solx = 0 then exit;
                 for k := solx+1 to 4 do xoay (i);
            end;
   end;


procedure taotest;
   var i, x : integer;
       f : text;
   begin
        n := 40;
        assign(f, 'turn_a.40'); rewrite(f);
        for i := 1 to n do ip[i] := 1;
        fillchar(kq, sizeof(kq), 0);
        init;
        for i := 1 to n do
        begin
             x := random (n) + 1;
             inc(kq[x]);
             xoay (x);
        end;

        writeln(f, n);
        for i := 1 to n do write(f, ip[i] : 4);
        writeln(f);
        for i := 1 to n do write(f, 4-kq[i] : 4);

        close(f);
        halt;
   end;

procedure test;
   var f : text;
       m, i, j, k  : integer;
   begin
        input;
        init;
        assign(f, fo); reset(f);

        fillchar(kq, sizeof(kq), 0);
        readln(f, m);
        for k := 1 to m do
        begin
             readln(f, i, j);
             kq[i] := j;
        end;
        close(f);

        for i := 1 to n do
            for j := 1 to kq[i] do xoay (i);

        for i := 1 to n do write(ip[i]:6);


        writeln;
        for i := 1 to n do
            if (ip[i] <> 1) then
            begin
                 writeln('fail');
                 halt;
            end;
        writeln('OK');

        halt;
   end;

begin
     clrscr;
     time := time_save ;
     input;
     init;
     display;
{     test;}
     try (1);
end.

