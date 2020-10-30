{$A+,B-,D+,E+,F-,G+,I+,L+,N+,O-,P-,Q-,R-,S-,T-,V+,X+,Y+}
{$M 4000 0 65536}
program AutoTest;
uses crt, dos;
const
  PATH = 'D:\_TEMP\';
  InputFile = '.IN';
  OutputFile = '.OUT';
  TestFile = PATH + '.EXE';
  AutoTestFile = PATH + '.EXE';
  TIMEOVER = 1 * 18.2;
  stest: array[1..10] of Char = '1234567890';
var
  chTest: Char;
  ecode, i: Integer;
  Start: LongInt;
  Time: LongInt absolute 0:$46C;
  dt: Real;
procedure ShowTest;
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
  CenterStr('Input File: ' + InputFile + chTest);
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

begin
  for i := 1 to 10 do
    begin
      chTest := stest[i];
      ShowTest;
      Start := Time;
      Exec(TestFile, '');
      ecode := DosExitCode;
      if ECode <> 0 then
        begin
          Writeln(#7#7'Your program performed a runtime error: ', ECode);
          ReadKey;
          Continue;
        end;
      dt := Time - Start;
      Writeln('During Time: ', dt / 18.2:1:4, ' (s)');
      if (Time - Start) > TIMEOVER then
        begin
          Writeln(#7#7'Time out! Time out!');
          ReadKey;
          Continue;
        end;
      Exec(AutoTestFile, chTest);
    end;
  Exec(AutoTestFile, #13);
end.