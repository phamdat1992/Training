{$M 4000,0,0}
program TheExplorer;
uses crt, dos;
const
 InputFile  = 'MAP.INP';
 OutputFile = 'MAP.OUT';
 max = 5001;
 Dirs: String = 'ESNW';

var
 CorrectLen, len: Integer;
 Point, Rep: Integer;
 FName: String;
 ch: Char;
procedure CreateTest;
var
 l, i: Integer;
 f: Text;
begin
 l := Random(4000) + 1000;
 Assign(f, InputFile); Rewrite(f);
 for i := 1 to l do Write(f, Dirs[Random(4) + 1]);
 Close(f);
end;

function ReadResult: Integer;
var
 f: Text;
 ch: Char;
 c: Integer;
begin
 {$I-}
 Assign(f, OutputFile); Reset(f);
 if IOresult <> 0 then Halt;
 {$I+}
 c := 0;
 while not SeekEoln(f) do
  begin
   Read(f, ch);
   if IOresult <> 0 then Halt;
   Inc(c);
  end;
 Close(f);
 Erase(f);
 ReadResult := c;
end;

begin
 Randomize;
 FName := ParamStr(1);
 if FName = '' then
  begin
   Write('File name: '); Readln(FName);
  end;
 if Pos('.', Fname) = 0 then FName := FName + '.EXE';
 Point := 0;
 for Rep := 1 to 10 do
  begin
   Write('Test ', Rep, ':  ');
   CreateTest;
   Exec('d:\_temp\053.EXE', '');
   CorrectLen := ReadResult;
   Exec(Fname, '');
   Writeln('H xong');
   len := ReadResult;
   if CorrectLen = len then
    begin
     Writeln('Correct');
     Inc(Point);
    end
   else
    begin
     Writeln('Wrong');
     Write('Do you want to continue...'); ch := Upcase(Readkey);
     if ch = 'N' then Break;
    end;
  end;
 Writeln('Point : ', Point);
 Readln;
end.
