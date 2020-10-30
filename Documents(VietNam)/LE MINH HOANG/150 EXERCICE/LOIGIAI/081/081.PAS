program Labyr;
uses crt;
const
 InputFile  = 'LABYR.INP';
 OutputFile = 'LABYR.OUT';
 max = 1000;
 
 dx: array[1..4] of Integer = (1, 0, 0, -1);
 dy: array[1..4] of Integer = (0, 1, -1, 0);
type
 TLine = array[0..(max + 1) div 16] of Word;
 PLine = ^TLine;
 TCell = record
  x, y: Integer;
 end;
var
 Map: array[0..max + 1] of PLine;
 m, n: Integer;
 nv, Result: LongInt;
 Bit: array[0..15] of Word;

 Time: LongInt absolute 0:$46C;
 Start: LongInt;

function IsFree(x, y: Integer): Boolean;
begin
 IsFree := Map[x]^[y shr 4] and Bit[y and 15] <> 0;
end;

procedure PutCell(x, y: Integer);
begin
 Map[x]^[y shr 4] := Map[x]^[y shr 4] or Bit[y and 15];
 Inc(nv);
end;

procedure RemoveCell(x, y: Integer);
begin
 Map[x]^[y shr 4] := Map[x]^[y shr 4] xor Bit[y and 15];
 Dec(nv);
end;

procedure GoOut;
var
 f: Text;
begin
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, Result);
 Close(f);
 Writeln('Time = ', (Time - Start)/18.2:1:4, ' (s)');
 Halt;
end;

procedure Init;
var
 i: Word;
begin
 for i := 0 to 15 do Bit[i] := 1 shl i;
end;

procedure Enter;
var
 i, j: Integer;
 ch: Char;
 f: Text;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n, m);
 for i := 0 to m + 1 do
  begin
   New(Map[i]);
   FillChar(Map[i]^, SizeOf(Map[i]^), 0);
  end;
 nv := 0;
 for i := 1 to m do
  begin
   for j := 1 to n do
    begin
     Read(f, ch);
     if ch = '.' then
      PutCell(i, j);
    end;
   Readln(f);
  end;
 Close(f);
 if nv < 2 then
  begin
   Result := 0;
   GoOut;
  end;
end;

function GetDeg(i, j: Integer): Integer;
var
 S, d: Integer;
begin
 S := 0;
 for d := 1 to 4 do
  if IsFree(i + dx[d], j + dy[d]) then Inc(S);
 GetDeg := S;
end;

procedure PrintMap;
var
 i, j: Integer;
begin
 Writeln;
 for i := 1 to m do
  begin
   for j := 1 to n do
    if IsFree(i, j) then Write('. ')
    else Write('x ');
   Writeln;
  end;
 Readln;
end;

procedure Solve;
var
 n1, n2, i: LongInt;
 d, a, b: Integer;
 c: TCell;
 f: array[1..2] of file of TCell;
begin
 Assign(f[1], 'Hang1.tmp'); Rewrite(f[1]);
 n1 := 0;
 with c do
  for x := 1 to m do
   for y := 1 to n do
    if IsFree(x, y) and (GetDeg(x, y) = 1) then
     begin
      Inc(n1);
      Write(f[1], c);
     end;
 Assign(f[2], 'Hang2.tmp'); Rewrite(f[2]);
 a := 1; b := 2;
 Result := 0;
 while n1 > 2 do
  begin
   Seek(f[a], 0); Seek(f[b], 0);
   n2 := 0;
   for i := 1 to n1 do
    begin
     Read(f[a], c);
     if not IsFree(c.x, c.y) then Continue;
     RemoveCell(c.x, c.y);
     for d := 1 to 4 do
      if IsFree(c.x + dx[d], c.y + dy[d]) then
       begin
        c.x := c.x + dx[d]; c.y := c.y + dy[d];
        if GetDeg(c.x, c.y) = 1 then
         begin
          Write(f[b], c);
          Inc(n2);
         end;
        Break;
       end;
    end;
   a := 3 - a; b := 3 - b;
   n1 := n2;
   Inc(Result, 2);
  end;
 Close(f[1]); Close(f[2]);
 Erase(f[1]); Erase(f[2]);
 Result := Result + nv - 1;
end;

begin
 Start := Time;
 Init;
 Enter;
 Solve;
 GoOut;
end.
