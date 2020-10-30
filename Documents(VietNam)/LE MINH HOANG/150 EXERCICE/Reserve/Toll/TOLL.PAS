{* Ctrinh testtoll chi chay voi INP, out ra so luong min}
{$R+}
Const
     fi = 'Toll.inp';
     fo = 'Toll.out';
     nmax = 55;
     vc = 2000000000;

Var
   f1, f2 : text;
   c : array [1..nmax, 1..nmax] of byte;
   shieu : array [1..nmax] of char;
   d, pred : array [1..nmax] of longint;
   kt : array [1..nmax] of boolean;
   m, n, start, finish, sl, stest : longint;

Procedure Open_file;
Begin
  assign(f1, fi); reset(f1);
  assign(f2, fo); rewrite(f2);

  stest := 0;
End;

Procedure chuan(var s : string);
Begin
  while s[1] = ' ' do delete(s, 1, 1);
  while s[length(s)] = ' ' do delete(s, length(s), 1);
End;

Procedure trattu(c : char; var i : longint);
Var
    j : longint;

Begin
  for j := 1 to n do
      if shieu[j] = c then
         begin
           i := j;
           exit;
         end;

  inc(n);
  shieu[n] := c;
  i := n;
End;

Procedure Enter;
Var
   ii, i, j : longint;
   s : string;

Begin
  n := 0;
  fillchar(c, sizeof(c), 0);
  for ii := 1 to m do
      begin
        readln(f1, s);
        chuan(s);

        trattu(s[1], i); trattu(s[length(s)], j);
        c[i, j] := 1;
        c[j, i] := 1;
      end;

  read(f1, sl);
  readln(f1, s);
  chuan(s);
  trattu(s[1], start);
  trattu(s[length(s)], finish);
End;

Function slcan(i, j : longint) : longint;
Var
   ii, ij : longint;

Begin
  if j = 1 then slcan := i + 1
  else begin
         ii := i div 20 + 1;
         ii := i + ii + ii div 20;

         for ij := ii to vc do
             if ij - ((ij - 1) div 20 + 1) = i then
                begin
                  slcan := ij;
                  exit;
                end;
       end;
End;

Procedure Init;
Var
   i : longint;

Begin
  for i := 1 to n do d[i] := vc;
  fillchar(pred, sizeof(pred), 0);

  {Qhd tu cuoi len}
  if upcase(shieu[finish]) <> shieu[finish] then d[finish] := slcan(sl, 1)
  else d[finish] := slcan(sl, 2);
End;

Procedure Solve;
Var
   ok : boolean;
   i, j, dem, min : longint;

Begin
  fillchar(kt, sizeof(kt), false);
  dem := 0;

  while (dem < n) and (not kt[start]) do
        begin
          min := vc;
          for j := 1 to n do
              if not kt[j] then
                 if d[j] < min then
                    begin
                      min := d[j];
                      i := j;
                    end;
          kt[i] := true; inc(dem);

          for j := 1 to n do
              if not kt[j] then
               if c[j, i] <> 0 then
                  begin
                    if upcase(shieu[j]) <> shieu[j] then
                       if d[j] > slcan(d[i], 1) then
                          begin
                            d[j] := slcan(d[i], 1);
                            pred[j] := i;
                          end;

                    if upcase(shieu[j]) = shieu[j] then
                       if d[j] > slcan(d[i], 2) then
                          begin
                            d[j] := slcan(d[i], 2);
                            pred[j] := i;
                          end;
                  end;
        end;
End;

Procedure return(cs : longint);
Begin
  if pred[cs] <> 0 then
     begin
       write(f2, shieu[cs],'-');
       return(pred[cs]);
     end
  else writeln(f2, shieu[cs]);
End;

Procedure Print;
Var
   min, i, cs : longint;

Begin
  writeln(f2, '# ',stest,':');

  if start = finish then
     begin
       writeln(f2, sl);
       writeln(f2, shieu[start]);
     end
  else begin
         min := vc;
         for i := 1 to n do
             if c[start, i] <> 0 then
                if d[i] < min then
                   begin
                     min := d[i];
                     cs := i;
                   end;

         writeln(f2, min);
         write(f2, shieu[start],'-');
         return(cs);
       end;
End;

Begin
  Open_file;
  while not seekeof(f1) do
        begin
             inc(stest);
             readln(f1, m);
             if m <> -1 then
                begin
                  Enter;
                  Init;
                  Solve;
                  Print;
                end;
        end;
  Close(f1); Close(f2);
End.