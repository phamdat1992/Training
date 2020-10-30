program CUT;
const
 max = 100;
var
 m, n: Byte;
 b: array[1..max, 1..max] of Integer;
 f: Text;

procedure Enter;
var
 f: Text;
begin
 Assign(f, 'CUT.INP'); Reset(f);
 Readln(f, m, n);
 Close(f);
end;

function Min(a, b: Integer): Integer;
begin
 if a > b then Min := b else Min := a;
end;

procedure Init;
var
 i, j, k: Integer;
begin
 k := Min(m, n);
 for i := 1 to m do
  for j := 1 to n do b[i, j] := MaxInt;
 for i := 1 to k do b[i, i] := 1;
end;


function GetB(i, j: Byte): Integer;
var
 k: Byte;
begin
 if b[i, j] = MaxInt then
  begin
   for k := 1 to i - 1 do
    b[i, j] := Min(b[i, j], GetB(k, j) + GetB(i - k, j));
   for k := 1 to j - 1 do
    b[i, j] := Min(b[i, j], GetB(i, k) + GetB(i, j - k));
  end;
 GetB := b[i, j];
end;

function GetCut(m, n: Byte): ShortInt;
var
 k: Byte;
begin
 for k := 1 to m - 1 do
  if b[m, n] = b[k, n] + b[m - k, n] then
   begin
    GetCut := k; Exit;
   end;
 for k := 1 to n - 1 do
  if b[m, n] = b[m, k] + b[m, n - k] then
   begin
    GetCut := - k; Exit;
   end;
end;

procedure Result(x1, y1, x2, y2: Byte);
var
 w, h: Byte;
 k: ShortInt;
begin
 w := x2 - x1 + 1; h := y2 - y1 + 1;
 if w = h then Writeln(f, x1, ' ', y1, ' ', w)
 else
  begin
   k := GetCut(w, h);
   if k > 0 then
    begin
     Result(x1, y1, x1 + k - 1, y2);
     Result(x1 + k, y1, x2, y2);
    end
   else
    begin
     k := -k;
     Result(x1, y1, x2, y1 + k - 1);
     Result(x1, y1 + k, x2, y2);
    end;
  end;
end;

begin
 Enter;
 Init;
 Assign(f, 'CUT.OUT'); Rewrite(f);
 Writeln(f, GetB(m, n));
 Result(1, 1, m, n);
 Close(f);
end.
4 6
