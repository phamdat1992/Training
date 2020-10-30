program RTest077;
const
 S: array[1..2] of Char = '()';
 name: array[1..10] of Char = '1234567890';
 na: array[1..10] of Integer =
  (5, 10, 100, 1000, 2000, 5000, 7000, 8000, 9999, 10000);
var
 c: array[1..20000] of Char;
 i, n: Integer;

function Get(i: Integer): Integer;
var
 T, j: Integer;
begin
 T := 0;
 for j := i to 2 * n do
  begin
   if c[j] = '(' then Inc(T) else Dec(T);
   if T = 0 then
    begin
     Get := j - i - 1;
     Exit;
    end;
  end;
end;

procedure Create(Filename: String);
var
 t, i: Integer;
 f: Text;
begin
 Writeln(Filename);
 t := 0;
 for i := 1 to 2 * n do
  begin
   if t = 0 then c[i] := '('
   else
    if t = 2 * n - i + 1 then c[i] := ')'
    else
     c[i] := S[Random(2) + 1];
   if c[i] = '(' then Inc(t) else Dec(t);
  end;
 Assign(f, Filename); Rewrite(f);
 Writeln(f, n);
 for i := 1 to 2 * n do
  if c[i] = '(' then Write(f, Get(i), ' ');
 Close(f);
end;

begin
 for i := 1 to 10 do
  begin
   n := na[i];
   Create('BRACKETS.IN' + name[i]);
  end;
end.
