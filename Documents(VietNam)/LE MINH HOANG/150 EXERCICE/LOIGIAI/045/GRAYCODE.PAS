{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
program GrayCode;
uses crt;
const
 OutputFile = 'GRAYCODE.OUT';
 max = 30;
 maxCache = 2;
 SL = SizeOf(LongInt);
var
 n: Byte;
 m: LongInt;
 Threshold: array[0..max] of LongInt;

 Cache: array[1..maxCache] of LongInt; {Advance file access}
 pCache, nCache: Integer;

procedure Enter;
var
 i: Byte;
begin
 Clrscr;
 Write('n = '); Readln(n);
 m := 1 shl LongInt(n) - 1;
 for i := 0 to n do Threshold[i] := 1 shl LongInt(i) - 1;
end;

function GetNumber(Position: LongInt): LongInt;
var
 k: Byte;
 Result: LongInt;
begin
 Result := 0;
 for k := n downto 1 do
  begin
   Result := Result shl 1;
   if Position > Threshold[k - 1] then
    begin
     Inc(Result);
     Position := Threshold[k] - Position;
    end;
  end;
 GetNumber := Result;
end;

procedure Process;
var
 f: file;
 i: LongInt;
begin
 Assign(f, OutputFile); Rewrite(f, SL);
 nCache := 0;
 for i := 0 to m do
  begin
   Inc(nCache);
   Cache[nCache] := GetNumber(i);
   if nCache = maxCache then
    begin
     BlockWrite(f, Cache, nCache);
     nCache := 0;
    end;
  end;
 BlockWrite(f, Cache, nCache);
 Close(f);
end;

procedure SelfTest;
var
 f: File;
 i: Integer;
 Correct: Boolean;
 Start: LongInt;

 function OK(a, b: LongInt): Boolean;
 var
  t: LongInt;
  c: Byte;
 begin
  t := a xor b;
  c := 0;
  repeat
   if odd(t) then Inc(c);
   if c = 2 then Break;
   t := t shr 1;
  until t = 0;
  OK := c = 1;
 end;

begin
 Writeln('Quick Self Test: ');
 Assign(f, OutputFile); Reset(f, SL);
 Writeln('Number Count: ', FileSize(f), ' = 2^', Ln(FileSize(f)) / Ln(2):1:3);
 Correct := True;
 BlockRead(f, Start, 1); Cache[1] := Start;
 repeat
  BlockRead(f, Cache[2], maxCache - 1, nCache);
  Inc(nCache);
  for i := 1 to nCache - 1 do
   begin
    Correct := Correct and OK(Cache[i], Cache[i + 1]);
    if not Correct then
     begin
      Writeln(FilePos(f));
      Writeln(Cache[i], ' ', Cache[i + 1]);
      Break;
     end;
   end;
  Cache[1] := Cache[nCache];
 until not Correct or eof(f);
 Correct := Correct and OK(Cache[1], Start);
 Writeln(Correct);
end;

begin
 Enter;
 Process;
 SelfTest;
end.
