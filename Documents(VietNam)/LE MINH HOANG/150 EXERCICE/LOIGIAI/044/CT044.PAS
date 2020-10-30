{$M 65520 0 262144}
{$R-,S-,Q-}
unit CT044;
interface

implementation
uses crt, dos;
const
  InputFile = 'GRAPH.IN';
  OutputFile = 'GRAPH.OUT';
  AutoTest = 'D:\_temp\CHAM044.EXE';
  TimeOver = 1 * 18.2;
var
  Time: LongInt absolute 0:$46C;
  Start: LongInt;
  SaveExit: Pointer;
  chtest: Char;

procedure AskTest;
var
   p: Pointer;
   s: Word;
   f1, f2: file;
   procedure CenterStr(S: String);
   var
     x, y: Integer;
   begin
     x := whereX; y := whereY;
     x := (80 - Length(S)) shr 1;
     GotoXY(x, y); Write(S);
   end;
begin
  Clrscr;
  Writeln;
  CenterStr('ษอออออออออออออออออออออออออออออออป'); Writeln;
  CenterStr('บ                               บ'); Writeln;
  CenterStr('ศอออออออออออออออออออออออออออออออผ'); Writeln;
  GotoXY(1, 3);
  CenterStr('Input File: ' + InputFile);
  chTest := ReadKey; Write(chTest);
  Writeln;
  Writeln;
  Write('Copying File ', InputFile, chTest, ' to ', InputFile, 'P ... ');
  GetMem(p, 60000);
  Assign(f1, InputFile + chTest); Reset(f1, 1);
  Assign(f2, InputFile + 'P'); Rewrite(f2, 1);
  repeat
    BlockRead(f1, p^, 60000, s);
    BlockWrite(f2, p^, s);
  until Eof(f1);
  Close(f1);
  Close(f2);
  FreeMem(p, 60000);
  Writeln('done');
  Writeln;
end;

{$F+}
procedure MyExit;
var
  dt: LongInt;
  TestFlag: Boolean;
begin
  TestFlag := True;
  dt := Time - Start;
  Writeln('During time is: ', dt / 18.2:1:4, ' (s)');
  Writeln;
  if dt > Timeover then
    begin
      Writeln('Time out! Timeout!');
      TestFlag := False;
    end;
  if ExitCode <> 0 then
    begin
      Writeln('Your program has performed a runtime error!'#7#7);
      Writeln('   + Error Code: ', ExitCode);
      Writeln('   + Error Address: ', Seg(ErrorAddr^), ':', Ofs(ErrorAddr^));
      TestFlag := False;
    end;
  ExitProc := SaveExit;
  if TestFlag then
    Exec(AutoTest, chTest)
  else
    ReadKey;
end;
{$F-}

procedure Init;
begin
  AskTest;
  Start := Time;
  SaveExit := ExitProc;
  ExitProc := @MyExit;
end;

begin
  Init;
end.
