program RandomTest;
const
  P: String = 'IWN';
var
  f: Text;
  m, n, i, j, k: Integer;
  B: array[0..1091] of Boolean;
  S: array[0..1091] of String[6];

function Convert(k, Len: Integer): String;
var
  S: String;
  i: Integer;
begin
  S := '';
  for i := 1 to Len do
    begin
      S :=  Chr(Ord('0') + (k mod 3)) + S;
      k := k div 3;
    end;
  Convert := S;
end;

begin
  Randomize;
  FillChar(S, SizeOf(S), 0);
  Write('n<=100, m <= 1092: '); Readln(n, m);
  for k := 1 to 6 do
    for i := 0 to Round(Exp(Ln(3) * k)) - 1 do
      begin
        S[j] := Convert(i, k);
        b[j] := True;
        Inc(j);
      end;
  for i := 0 to m - 1 do b[i] := False;
  Assign(f, 'STR.IN0'); Rewrite(f);
  Writeln(f, n, ' ', m);
  for i := 0 to 1091 do
    if not b[i] then
      begin
        for j := 1 to Length(S[i]) do
          S[i][j] := P[Ord(S[i][j]) - Ord('0') + 1];
        Writeln(f, S[i]);
        Writeln(f, Random(32767) + Random(32767) + 1);
      end;
  Close(f);
end.
