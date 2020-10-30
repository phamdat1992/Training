program Compatible_Board;
const
 InputFile  = 'REL.INP';
 OutputFile = 'REL.OUT';
 max = 100;
var
 A: array[1..max, 1..max] of ShortInt;
 T: array[1..max] of Byte;
 n: Byte;
 NotFound: Boolean;

procedure Enter;
var
 f: Text;
 i, j: Byte;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n);
 for i := 1 to n do
  for j := 1 to n do Read(f, A[i, j]);
 Close(f);
end;

procedure Init;
begin
 FillChar(T, n, 1);
end;

function Optimize: Boolean;
var
 i, j: Byte;
 b: Boolean;
begin
 b := True;
 for i := 1 to n do
  for j := 1 to n do
   begin
    case A[i, j] of
     -2:  {T[i] >= T[j]}
      if T[i] < T[j] then
       begin
        T[i] := T[j];
        b := False;
       end;
     2:  {T[i] <= T[j]}
      if T[i] > T[j] then
       begin
        T[j] := T[i];
        b := False;
       end;
     -1:  {T[i] > T[j]}
      if T[i] <= T[j] then
       begin
        T[i] := T[j] + 1;
        b := False;
       end;
     1: {T[i] < T[j]}
      if T[i] >= T[j] then
       begin
        T[j] := T[i] + 1;
        b := False;
       end;
     0: {T[i] = T[j]}
      if T[i] <> T[j] then
       begin
        if T[i] > T[j] then T[j] := T[i] else T[i] := T[j];
        b := False;
       end;
    end;
    if (T[i] > n) or (T[j] > n) then
     begin
      NotFound := True;
      Optimize := False;
      Exit;
     end;
   end;
 Optimize := b;
end;

procedure Process;
var
 OK: Boolean;
 i, j: Byte;
begin
 NotFound := False;
 OK := False;
 repeat
  OK := OK or Optimize;
 until OK or NotFound;
end;

procedure Result;
var
 f: Text;
 i: Byte;
begin
 Assign(f, OutputFile); Rewrite(f);
 if NotFound then Write(f, 'NO SOLUTION')
 else
  for i := 1 to n do Write(f, T[i], ' ');
 Close(f);
end;

begin
 Enter;
 Init;
 Process;
 Result;
end.
