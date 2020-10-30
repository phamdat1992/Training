Unit CIOI;
interface
implementation
uses crt;
const
  InputFile: string = 'IOI.IN';
  OutputFile = 'IOI.OUT';
var
  ch: Char;
  SaveExit: Pointer;

procedure AskTest;
begin
  Clrscr;
  Writeln('                                 IOI 3003');
  Writeln('                                 ฿฿฿฿฿฿฿฿');
    Write('                                  IOI.IN'); ch := ReadKey;
  Writeln(ch);
  InputFile := InputFile + ch;
end;

procedure RedirectDevice;
begin
  Close(Input); Close(Output);
  Assign(Input, InputFile); Reset(Input);
  Assign(Output, OutputFile); Rewrite(Output);
end;

procedure Correct;
begin
  Writeln;
  Writeln('                     ษออออออออออออออออออออป');
  Writeln('                     บ  CORRECT! CORRECT! บ');
  Writeln('                     ศออออออออออออออออออออผ');
  ReadKey;
  Halt;
end;

procedure Wrong;
begin
  Writeln(#7);
  Writeln('                     ษออออออออออออออออออออป');
  Writeln('                     บ    ERROR! ERROR!   บ');
  Writeln('                     ศออออออออออออออออออออผ');
  ReadKey;
  Halt;
end;

procedure NewExit;
begin
  ExitProc := SaveExit;
  {$I-}
  Close(Input); if IOResult = 0 then;
  Close(Output); if IOResult = 0 then;
  {$I+}
  Assign(Input, ''); Reset(Input);
  Assign(Output, ''); Rewrite(Output);
end;

begin
  AskTest;
  RedirectDevice;
  SaveExit := ExitProc;
  ExitProc := @NewExit;
end.

