unit CTest075;
interface
 procedure StartCount(TimeOut: Integer);

implementation
uses crt, dos, visual;
const
 InputFile  = 'HORSES.IN';
 dx: array[1..8] of ShortInt = (1, -1, 1, -1, 2, -2, 2, -2);
 dy: array[1..8] of ShortInt = (2, 2, -2, -2, 1, 1, -1, -1);
var
 Value, Limit: Integer;
 OldExit, OldInt: Pointer;
 ch: Char;

procedure Test;
begin
end;

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
 if Wait then Color := 78 else Color := 161;
 if (Code <> 0) and (Address <> nil) then
  begin
   Color := 78;
   Frame(10, 3, 70, 8, #7'Error');
   Writeln('Your program has performed a run-time error:');
   Writeln('  + Error Code: ', Code);
   Writeln('  + Error Addr: ', Seg(Address^), ':', Ofs(Address^));
   Wait := True;
  end
 else
  if Value < 0 then
   begin
    Frame(25, 3, 55, 6, #7'Error');
    Writeln('   Time out! Time out!');
   end
  else
   begin
    Frame(20, 3, 60, 6, 'Running time');
    Writeln((Limit - Value) / 18.2:1:4, ' (s)');
   end;
 if Wait then
  begin
   Writeln('Bye bye! see you again, khong can phai cham nua');
   ReadKey;
  end
 else Test;
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
   Mem[$B800:4] := Value mod 10 + 48;
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
 
 S: Word;
 p: Pointer;
 f1, f2: file;
begin
 TextAttr := 7; Writeln;
 Caption('Knights  ');
 Msg(40, 4, 'Input?', 'From file: HORSES.IN '#8);
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
 Write('Done');
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
 StartCount(15);
end.
