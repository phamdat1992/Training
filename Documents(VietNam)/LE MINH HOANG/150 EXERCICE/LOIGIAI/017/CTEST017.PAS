unit CTest017;
interface
  procedure StartCount(TimeOut: Integer);

implementation
uses crt, dos;
const
  InputFile  = 'BOARD.IN';
var
  Value, Limit: Integer;
  OldExit, OldInt: Pointer;

{$F+}
procedure MyExit;
var
  Code: LongInt;
  Address: Pointer;
  Wait: Boolean;
begin
  SetIntVec($1C, OldInt);
  Code := exitCode;
  Address := errorAddr;
  Wait := Value < 0;
  if (Code <> 0) and (Address <> nil) then
    begin
      Writeln('Your program perform a run-time error:');
      Writeln('  + Error Code: ', Code);
      Writeln('  + Error Addr: ', Seg(Address^), ':', Ofs(Address^));
      Wait := True;
    end
  else
    if Value < 0 then Writeln('Error: Time Out!')
    else
      Writeln('Running Time is: ', (Limit - Value) / 18.2:1:4, ' (s)');
  Writeln('GOOD BYE!');
  if Wait then
    begin
      Write('Press <Enter>...');
      Readln;
    end;
  ExitProc := OldExit;
end;
{$F-}

procedure MyInt; interrupt;
var
  i: Integer;
begin
  asm
    PUSHF
    CALL OldInt;
  end;
  if Value >= 0 then
    begin
      Mem[$B800:0] := Value div 100 + 48;
      Mem[$B800:1] := 78;
      Mem[$B800:2] := Value div 10 mod 10+ 48;
      Mem[$B800:3] := 78;
      Mem[$B800:4] := Value mod 10+ 48;
      Mem[$B800:5] := 78;
      Dec(Value);
    end
  else
    begin
      Mem[$B800:0] := Ord('T');
      Mem[$B800:2] := Ord('i');
      Mem[$B800:4] := Ord('m');
      Mem[$B800:6] := Ord('e');
      Mem[$B800:8] := Ord(' ');
      Mem[$B800:10] := Ord('o');
      Mem[$B800:12] := Ord('u');
      Mem[$B800:14] := Ord('t');
      Mem[$B800:16] := Ord('!');
      i := 1;
      while i <= 17 do
        begin
          Mem[$B800:i] := 206;
          i := i + 2;
        end;
    end;
end;

procedure StartCount(TimeOut: Integer);
begin
  Value := Round(TimeOut * 18.2);
  Limit := Value;
  OldExit := ExitProc;
  ExitProc := @MyExit;
  GetIntVec($1C, OldInt);
  SetIntVec($1C, @MyInt);
end;

procedure AskTest;
var
  ch: Char;
  S: Word;
  p: Pointer;
  f1, f2: file;
begin
  TextAttr := 7;
  Writeln;
  Write('Create Input File ', InputFile, 'P from ', InputFile);
  ch := ReadKey;
  Writeln(ch);
  Write('Copying File...');
  GetMem(p, 60000);
  Assign(f1, InputFile + ch); Reset(f1, 1);
  Assign(f2, InputFile + 'P'); Rewrite(f2, 1);
  repeat
    BlockRead(f1, p^, 60000, s);
    BlockWrite(f2, p^, s);
  until Eof(f1);
  Close(f1);
  Close(f2);
  Writeln('Done');
  FreeMem(p, 60000);
end;

begin
  asm
    MOV AX, $B800
    MOV ES, AX
    XOR DI, DI
    MOV CX, 2000
    MOV AX, $0720
    REP STOSW
  end;
  AskTest;
  StartCount(5);
end.
