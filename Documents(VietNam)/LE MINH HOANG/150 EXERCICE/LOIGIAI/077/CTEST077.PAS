unit CTest077;
interface
 procedure StartCount(TimeOut: Integer);

implementation
uses crt, dos, visual;
const
 InputFile  = 'BRACKETS.IN';
 OutputFile = 'BRACKETS.OUT';
 max = 10000;
var
 Value, Limit: Integer;
 PMark, OldExit, OldInt: Pointer;
 Ch: Char;

procedure Test;
type
 T = array[1..max + max] of Char;
var
 c: ^T;
 f: Text;
 ct: char;
 i, n, k: Integer;
 S: String;
 b: Boolean;
begin
 Assign(f, InputFile + 'P'); Reset(f);
 Readln(f, n);
 New(c);
 FillChar(c^, 2 * n, '?');
 for i := 1 to 2 * n do
  begin
   if c^[i] = '?' then
    begin
     Read(f, k); c^[i] := '('; c^[i + k + 1] := ')';
    end;
  end;
 Close(f);
 Color := 233;
 MSG(40, 20, 'KiÓm tra kÕt qu¶', '                                ');
 Assign(f, OutputFile); Reset(f);
 b := True;
 for i := 1 to 2 * n do
  begin
   Read(f, ct);
   Write(#13, i:10, ': "', ct, '" ');
   b := b and (ct = c^[i]);
   if b then Write('§óng')
   else
    begin
     Write('Sai ');
     Break;
    end;
  end;
 Close(f); Dispose(c);
 Color := 47;
 MSG(40, 12, InputFile + ch, '                                        '#13);
 if b then Write('        ChÝnh x¸c! b¹n ®­îc 1 ®iÓm  ')
 else Write('        Lçi! B¹n kh«ng cã ®iÓm  ');
 ReadKey;
end;

{$F+}
procedure MyExit;
var
 Code: LongInt;
 Address: Pointer;
 Wait: Boolean;
begin
 SetIntVec($1C, OldInt);
 Release(PMark);
 Code := exitCode;
 Address := errorAddr;
 Wait := Value < 0;
 if Wait then Color := 78 else Color := 161;
 if (Code <> 0) and (Address <> nil) then
  begin
   Color := 78;
   Frame(15, 10, 65, 14, #7'Lçi');
   Writeln(' Ch­¬ng tr×nh cña b¹n sinh lçi lóc ch¹y:');
   Writeln('   + M· lçi     : ', Code);
   Write('   + §Þa chØ lçi: ', Seg(Address^), ':', Ofs(Address^));
   Wait := True;
  end
 else
  if Value < 0 then
   MSG(40, 13, #7'Lçi', 'Ch­¬ng tr×nh ch¹y v­ît qu¸ thêi gian cho phÐp');
 ExitProc := OldExit;
 if Wait then ReadKey
 else Test;
 Default; TextAttr := 7; Clrscr;
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
 Caption('Recover brackets');
 MSG(40, 3, 'Input?', 'Tªn file d÷ liÖu: BRACKETS.IN '#8);
 ch := ReadKey; Write(ch);
 GetMem(p, 60000);
 Assign(f1, InputFile + ch); Reset(f1, 1);
 Assign(f2, InputFile + 'P'); Rewrite(f2, 1);
 repeat
  BlockRead(f1, p^, 60000, s);
  BlockWrite(f2, p^, s);
 until Eof(f1);
 Close(f1);
 Close(f2);
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
 StartCount(1);
 Mark(PMark);
end.
