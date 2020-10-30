program   lap_lich_sua_chua_o_to;
const
  fi = 'schedule.in1';
  fo = 'schedule.out';
var
  n : integer;
  a, c, b, d, luu : array [1..100] of integer;
  cost : array [0..100] of longint;
  done  : array [1..100] of boolean;
  min : longint;

procedure   enter;
var
  i : integer;
begin
  readln(n);
  for i := 1 to n do read(a[i]);
  readln;
  for i := 1 to n do read(b[i]);
  readln;
end;

function    check(u : integer) : boolean;
var
  i : integer;
begin
  for i := 1 to n do
   if done[i] and (i <> u) then
    begin
     check := false;
     exit;
    end;
   check := true;
end;

procedure   init;
begin
    fillchar(done, sizeof(done), true);
    min := MaxLongInt;
    cost[0] := 0;
end;

procedure   try(i : integer);
var
    j, k : integer;
begin
    for j := 1 to n do
     if done[j] then
      begin
       d[i] := j; c[i] := 0;
       for k := 1 to i do c[i] := c[i] + b[d[k]];
       cost[i] := cost[i - 1] + a[d[i]] * c[i];
       if cost[i] < min then
        begin
         if check(j) then
          begin
           min := cost[i];
           luu := d;
          end
         else
          begin
           done[j] := false;
           try(i + 1);
           done[j] := true;
          end;
        end;
      end;
end;

procedure   printresult;
var
   i : integer;
begin
   writeln(min);
   for i := 1 to n do write(luu[i], ' ');
end;

BEGIN
   assign(input, fi); reset(input);
   assign(output, fo); rewrite(output);
   enter;
   init;
   try(1);
   printresult;
   close(input); close(output);
END.