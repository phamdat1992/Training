{$A+,B-,D+,E+,F+,G-,I+,L+,N+,O+,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}

program Code;
const
  inputfile = 'BURROWS.INP';
  outputfile = 'BURROWS.OUT';
  max = 1000;
  maxC = 255;
var
  a: array[0..max] of Char;
  c: array[0..maxC] of integer;
  id: array[0..max] of integer;
  n, d: integer;
  f, g: text;

 procedure Enter;
 begin
   n := 0;
   while not seekeoln(f) do
     begin
       inc(n);
       read(f, a[n]);
     end;
   readln(f, d);
 end;

 procedure DistributionCounting;
 var
   i: integer;
 begin
   fillchar(c, sizeof(c), 0);
   for i := 1 to n do inc(c[Ord(a[i])]);
   for i := 2 to maxC do c[i] := c[i] + c[i - 1];
   for i := n downto 1 do
     begin
       id[c[Ord(a[i])]] := i;
       dec(c[Ord(a[i])]);
     end;
 end;

 procedure Process;
 var
   i: integer;
 begin
   fillchar(id, sizeof(id), 0);
   DistributionCounting;
 end;

 procedure Result;
 var
   count: integer;
 begin
   count := 0;
   repeat
     write(g, a[id[d]]);
     d := id[d];
     inc(count);
   until count = n;
   writeln(g);
 end;

 procedure Solve;
 begin
   assign(f, inputfile); reset(f);
   assign(g, outputfile); rewrite(g);
   while not seekeof(f) do
     begin
       Enter;
       Process;
       Result;
     end;
   close(f); close(g);
 end;

begin
  Solve;
end.
