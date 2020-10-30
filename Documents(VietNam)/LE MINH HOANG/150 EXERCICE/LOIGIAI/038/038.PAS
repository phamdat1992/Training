program Palindrom_String;
const
  InputFile  = 'STR.INP';
  OutputFile = 'STR.OUT';
  max = 128;
var
  S, T: String;
  B: array[1..max, 1..max] of Byte;
  n: Byte;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, S);
  n := Length(S);
  Close(f);
end;

function Min(a, b: Byte): Byte;
begin
  if a < b then Min := a else Min := b;
end;

procedure Optimize;
var
  i, j, l: Byte;
begin
  FillChar(B, SizeOf(B), 0);
  for i := 1 to n - 1 do
    if S[i] <> S[i + 1] then B[i, i + 1] := 1;
  for l := 3 to n do
    for i := 1 to n - l + 1 do
      begin
        j := i + l - 1;
        if S[i] = S[j] then B[i, j] := B[i + 1, j - 1]
        else
          B[i, j] := Min(B[i + 1, j], B[i, j - 1]) + 1;
      end;
end;

procedure Trace;
var
  T1, T2: String;
  C: Char;
  i, j: Byte;
begin
  T1 := ''; T2 := '';
  i := 1; j := n;
  while j - i > 1 do
    begin
      if S[i] = S[j] then
        begin
          C := S[i];
          Inc(i); Dec(j);
        end
      else
        if B[i, j] = B[i + 1, j] + 1 then
          begin
            C := S[i];
            Inc(i);
          end
        else
          begin
            C := S[j];
            Dec(j);
          end;
      T1 := T1 + C; T2 := C + T2;
    end;
  if i = j then T1 := T1 + S[i]
  else
    if S[i] = S[j] then T1 := T1 + S[i] + S[j]
    else T1 := T1 + S[i] + S[j] + S[i];
  T := T1 + T2;
end;

procedure Result;
var
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, T);
  Close(f);
end;

begin
  Enter;
  Optimize;
  Trace;
  Result;
end.
