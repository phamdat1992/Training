program SortArray;
const
 InputFile  = 'SORT.INP';
 OutputFile = 'SORT.OUT';
 max = 20;
 maxV = 100;
var
 A: array[1..max] of Integer;
 X: array[1..max] of Byte;
 Free: array[-maxV..2 * maxV] of Boolean;
 n: Byte;
 f: Text;
 Count: Longint;
 Time: Longint absolute $0000:$046C;
 OldTime: Longint;
procedure Enter;
var
 f: Text;
 i: Byte;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n);
 for i := 1 to n do Read(f, A[i]);
 Close(f);
end;

procedure Init;
var
 i: Byte;
begin
 FillChar(Free, SizeOf(Free), False);
 for i := 1 to n do Free[A[i]] := True;
 Count := 0;
 Assign(f, OutputFile); Rewrite(f);
end;

procedure PrintResult;
var
 i: Byte;
begin
 Inc(Count);
 for i := 1 to n do Write(f, A[X[i]], ' ');
 Writeln(f);
end;

function Check(Post, Value: Byte): Boolean;
var
 i, j: Byte;
begin
 for i := 1 to Post - 1 do
  if Free[2 * Value - A[X[i]]] then
   begin
    Check := False;
    Exit;
   end;
 Check := True;
end;

procedure Try(i: Byte);
var
 j: Byte;
begin
 for j := 1 to n do
  if Free[A[j]] and Check(i, A[j]) then
   begin
    X[i] := j;
    if i = n then PrintResult
    else
     begin
      Free[A[j]] := False;
      Try(i + 1);
      Free[A[j]] := True;
     end;
   end;
end;

begin
 Enter;
 OldTime := Time;
 Init;
 Try(1);
 Writeln((Time - OldTime)/18.2:1:2);
 Write(f, Count);
 Close(f);
 Writeln(Count);
end.
