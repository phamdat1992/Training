program Test_FibinacciString;
uses crt, dos;
const
 InputFile  = 'FIBISTR.IN0';
 OutputFile = 'FIBISTR.OUT';
 max = 35;
var
 S: array[1..13] of String;
 F: array[1..35] of LongInt;

procedure CreateFile;
var
 f: Text;
 i, l: LongInt;
 St: String;
begin
 S[1] := 'A'; S[2] := 'B';
 for i := 3 to 13 do S[i] := S[i - 1] + S[i - 2];

 Assign(f, InputFile); Rewrite(f);
 S[1] := 'A'; S[2] := 'B';
 for i := 3 to 13 do S[i] := S[i - 1] + S[i - 2];
 for i := 1 to 10000 do
  begin
   l := Random(25) + 1;
   St := Copy(S[13], Random(100) + 1, l);
   if Random(10) = 1 then St := St + Chr(Random(2) + 65);
   Writeln(f, Random(26) + 10, ' ', St);
  end;
 Close(f);
end;

begin
  Randomize;
  CreateFile
end.