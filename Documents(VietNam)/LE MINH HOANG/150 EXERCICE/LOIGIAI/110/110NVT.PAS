program  So_hieu_va_gia_tri;
const
   fi = 'permute.in9';
   fo = 'permute.out';
var
   a : array [1..12] of byte;
   GT : array [0..12] of Longint;
   free : array [1..12] of boolean;
   p, q, count, Time : Longint;
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
   i, j, k, L, R : integer;
begin
   j := (p - 1) div GT[n - 1] + 1;
   p := p - GT[n - 1] * (j - 1);
   a[1] := j;
   if j = 1 then
     for i := 2 to n do a[i] := i
   else
     begin
       a[2] := 1;
       i := 2; k := 1;
       while i <= n do
         begin
           inc(i); inc(k);
           if k = j then inc(k);
           a[i] := k;
         end;
     end;
   count := 0;
   repeat
     i := n - 1;
     inc(count); if count = p then break;
     while (i > 0) and (a[i] > a[i + 1]) do dec(i);
     if i = 0 then break;
     j := n;
     while a[j] < a[i] do Dec(j);
     k := a[i]; a[i] := a[j]; a[j] := k;
     L := i + 1; R := n;
     while L < R do
       begin
         k := a[L]; a[L] := a[R]; a[R] := k;
         Inc(L); Dec(R);
       end;
   until  i = 0;
   for i := 1 to n do write(a[i], ' ');
end;

begin
   Enter;
   Init;
   Time := MemL[0 : $46C];
   Assign(Output, fo); Rewrite(Output);
   Solve;
   Solve2;
   writeln('Time : ', (MemL[0 : $46C] - Time) / 18.2 : 10 : 9);
   Close(Output);
end.