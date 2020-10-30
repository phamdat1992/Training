{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program songlienthong;

   uses	crt;

   const	max			= 100;
   		 	fi          = 'slt.10';
            fo          = '';

   type     ta          = array [1..max, 1..max] of byte;
            tmark       = array [1..max] of byte;
   var      a           : ta;
            n           : integer;
            lkq         : integer;
            lbd         : tmark;

procedure input;
   var f : text;
       x, y : integer;

   begin
        assign(f, fi); reset(f);
        readln(f, n);
        while not seekeof(f) do
        begin
             readln(f, x, y);
             a[x, y] := 1;
             a[y, x] := 1;
        end;
        close(f);
   end;

procedure try (i, smlt : integer; var dd : tmark);
   var j : integer;
   begin
        dd[i] := smlt;
        for j := 1 to n do
            if (a[i, j] = 1) and (dd[j] = 1)
            then try (j, smlt, dd);
   end;

function loang (var mark : tmark; var dd : tmark) : integer;
    var i    : integer;
        smlt : integer;
    begin
         smlt := 1;
         dd := mark;

         for i := 1 to n do
         if dd[i] = 1 then
         begin
              inc(smlt);
              try (i, smlt, dd);
         end;
         loang := smlt;
    end;


function spt1(var b : tmark) : integer;
   var i, temp : integer;
   begin
        temp :=0;
        for i := 1 to n do
            if (b[i] = 1) then inc(temp);
        spt1 := temp;
   end;

procedure ghinhan (var bd : tmark);
   begin
        if spt1(bd) > lkq then
        begin
             lkq := spt1(bd);
             lbd := bd;
             writeln(lkq);
        end;
   end;



procedure Duyet (var bd : tmark);
   var temp, dd   : tmark;
       i, x, j, k :  integer;
   begin

        for i := 1 to n do
        if bd[i] = 1 then
        begin
             temp := bd;
             temp[i] := 0;
             x := loang (temp, dd);
             if (x > 2) then
             begin
                  for j := 2 to x do
                  begin

                       fillchar(temp, sizeof(temp), 0);
                       for k := 1 to n do
                           if (dd[k] = j) then temp[k] := 1;

                       temp[i] := 1;
                       duyet (temp);
                  end;
                  exit;
             end;
        end;
        ghinhan (bd);
   end;

procedure output;
   var f : text;
       i : integer;

   begin
        assign(f, fo); rewrite(f);
        writeln(f, lkq);
        for i := 1 to n do
        if (lbd[i]=1) then write(f, i:5);
        close(f);
   end;


procedure process;
   var bd : tmark;
       dd : tmark;
       i, j  : integer;
   begin
        lkq := 0;

        fillchar(dd, sizeof(dd), 0);

        for i := 1 to n do
        if (dd[i] = 0) then
        begin
             fillchar(bd, sizeof(bd), 1);
             try (i, 2, bd);
             for j := 1 to n do
                 if bd[j] = 2 then bd[j] := 1
                 else bd[j] :=0;

             for j := 1 to n do
                 if bd[j] = 1 then dd[j] := 1;

             duyet (bd);
        end;
        output;

   end;

procedure taotest;
    var i, j : integer;
    	f    : text;
    begin
        n := 100;
{        randomize;}
        for i := 1 to n do
        	for j := i+1 to n do
            begin
                a[i, j] := 0 ;
                if random (100) > 93 then a[i, j] := 1;

                a[j, i] := a[i, j];
            end;

    	assign(f, 'slt.101'); rewrite(f);

        writeln(f, n);
        for i := 1 to n do
            for j := i+ 1 to n do
            if (a[i, j] = 1) then writeln(f, i : 6, j : 10);

        close(f);
    end;


begin
     taotest;
     clrscr;
     input;
     process;
end.