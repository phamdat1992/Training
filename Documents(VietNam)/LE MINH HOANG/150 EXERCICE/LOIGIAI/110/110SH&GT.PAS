program  So_hieu_va_gia_tri;
const
   fi = 'permute.in1';
   fo = 'permute.out';
var
   a, b : array [1..12] of byte;
   GT : array [0..12] of Longint;
   free : array [1..12] of boolean;
   p, q, count : Longint;
   n : integer;

procedure  enter;
var
   f : text;
begin
   assign(f, fi); reset(f);
   n := 0;
   while not SeekEoln(f) do
     begin
       inc(n); read(f, a[n]);
     end;
   readln(f);
   readln(f, p);
   close(f);
end;

procedure  Init;
var
   i : integer;
begin
   fillchar(free, sizeof(free), true);
   GT[0] := 1;
   for i := 1 to n do  GT[i] := GT[i - 1] * i;
   count := 0;
end;

procedure  Solve;
var
   i, j, k : integer;
begin
   q := 0;
   for i := 1 to n do
     begin
       k := 0;
       for j := 1 to a[i] - 1 do
         if free[j] then inc(k);
       q := q + k * GT[n - i];
       free[a[i]] := false;
     end;
   writeln(Output, q + 1);
end;

procedure  Solve2;
var
   i, j, k : integer;
begin
   Fillchar(free, sizeof(free), true);
  
   for i := 1 to n do
    begin
      j := (p - 1) div GT[n - i] + 1;
      for k := 1 to n do
        if Free[k] then
          begin
            Dec(j);
            if j = 0 then Break;
          end;
      b[i] := k;
      Free[k] := False;
      p := (p - 1) mod GT[n - i] + 1;
    end;
  for i := 1 to n do write(b[i], ' ');
end;

begin
   enter;
   init;
   Assign(Output, fo); Rewrite(Output);
   Solve;
   Solve2;
   Close(Output);
end.