unit TCount;
interface
implementation
const
  Interval = 1193180/65536;
var
  Time: LongInt absolute 0:$46C;
  Start: LongInt;
  SaveExit: Pointer;
{$F+}
procedure CustomExit;
begin
  Writeln('During Time: ', (Time - Start) / Interval:1:10, '(s)');
  ExitProc := SaveExit;
end;

begin
  SaveExit := ExitProc;
  ExitProc := @CustomExit;
  Start := Time;
end.
