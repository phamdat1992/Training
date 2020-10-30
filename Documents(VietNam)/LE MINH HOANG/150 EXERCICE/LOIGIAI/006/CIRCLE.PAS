program Circle; {Standard}
const
 InputFile  = 'CIRCLE.INP';
 OutputFile = 'CIRCLE.OUT';
 max = 9;
 Count: array[2..9] of LongInt =
 (2, 2, 4, 96, 1024, 2880, 81024, 770144);
var
 X: array[1..2 * max] of Byte;
 Free: array[1..2 * max] of Boolean;
 Accept: array[1..2 * max, 1.. 2 * max] of Boolean;
 n, m: Byte;
 Time: Longint absolute $0000:$046C;
 OldTime: Longint;
 f: Text;
 BackCount: Longint;

procedure Enter;
var
 f: Text;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n);
 m := n SHL 1;
 Close(f);
end;

function P_Number(X: Byte): Boolean;
var
 b: Boolean;
 i: Byte;
begin
 b := X > 1;
 for i := 2 to Trunc(Sqrt(X)) do b := b and (X mod i <> 0);
 P_Number := b;
end;

procedure Init;
var
 i, j: Byte;
begin
 FillChar(Free, m, True);
 for i := 1 to m do
  for j := 1 to m do Accept[i, j] := P_Number(i + j);
 BackCount := Count[n];
end;

procedure WriteResult;
var
 i: Byte;
begin
 Dec(BackCount, 2);
 for i := 2 to m do Write(f, X[i],' ');
 Write(f, X[1]);
 Writeln(f);
 Write(f, '1 ', X[1]);
 for i := m downto 3 do Write(f, ' ', X[i]);
 Writeln(f);
end;

procedure Try(i: Byte);
var
 j: Byte;
begin
 if odd(i) then j := 2 else j := 3;
 repeat
  if BackCount = 0 then Exit;
  if Free[j] and Accept[X[i - 1], j] then
   begin
    X[i] := j;
    if i <> m then
     begin
      Free[j] := False;
      Try(i + 1);
      Free[j] := True;
     end
    else
     if Accept[j, X[1]] then WriteResult;
   end;
  Inc(j, 2);
 until j > m;
end;

procedure TryAll;
var
 i, j: Byte;
begin
 X[2] := 1; Free[1] := False;
 for i := 2 to m do
  for j := i + 1 to m do
   if Accept[1, i] and Accept[j, 1] then
    begin
     X[1] := j; X[3] := i;
     Free[i] := False; Free[j] := False;
     Try(4);
     Free[i] := True; Free[j] := True;
    end;
end;

begin
 OldTime := Time;
 Enter;
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, Count[n]);
 Init;
 TryAll;
 Close(f);
 Writeln('Time: ', (Time - OldTime)/18.2:1:2);
end.
