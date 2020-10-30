unit CTest076;
interface
 procedure StartCount(TimeOut: Integer);

implementation
uses crt, dos, visual;
const
 InputFile  = 'GUEST.IN';
var
 Value, Limit: Integer;
 OldExit, OldInt: Pointer;
 ch: Char;
 p: Integer;
 f1, f2: Text;
 PMark: Pointer;

procedure Writep;
var
 f: File Of Integer;
begin
 Assign(f, 'Point.TXT'); Rewrite(f);
 Write(f, p);
 Close(f);
end;

function ReadP: Integer;
var
 f: File Of Integer;
 p: Integer;
begin
 p := 0;
 {$I-}
 Assign(f, 'Point.TXT'); Reset(f);
 if IOResult <> 0 then
  begin
   Rewrite(f); Write(f, p); Close(f); Reset(f);
  end;
 {$I+}
 Read(f, p);
 Readp := p;
 Close(f);
end;

procedure Halt;
begin
 {$I-}
 Close(f1); if IOResult = 0 then;
 Close(f2); if IOResult = 0 then;
 {$I+}
 RestoreDefaultFont;
 System.Halt;
end;

procedure Correct;
begin
 p := ReadP; Inc(p); WriteP;
 Color := 252;
 MSG(30, 3, 'ChÝnh x¸c', '  /10 ®iÓm cho b¹n');
 Write(#13, p:2);
 if p = 10 then
  Logo('You have got a perfect solution', 'Success! Success');
 ReadKey;
 Halt;
end;

procedure Wrong;
begin
 p := ReadP;
 Color := 78;
 MSG(30, 3, #7'Lçi', '  /10 ®iÓm cho b¹n');
 Write(#13, p:2);
 ReadKey;
 Halt;
end;

procedure Test;
type
 TListI = array[1..10000] of Integer;
 TListB = array[1..10000] of Boolean;
var
 c1, d1, c2, d2, i, k, n: LongInt;
 Mark: ^TListB;
 a, b: ^TListI;
 S: String;
begin
 Caption('Bé test bµi "Nh÷ng ng­êi thÝch ®ïa"');
 Str((Limit - Value) / 18.2:1:4, S);
 Msg(60, 3, 'Thêi gian', InputFile + ch + ' - ' + S + ' (s)');
 Color := 159;
 Frame(3, 7, 77, 22, 'ChÊm bµi "Nh÷ng ng­êi thÝch ®ïa"');
 Assign(f1, 'GUEST.OU' + ch); Reset(f1);
 Assign(f2, 'GUEST.OUT'); Reset(f2);
 Readln(f1, c1, d1);
 Readln(f2, c2, d2);
 Writeln('Dßng 1: (ChØ kiÓm tra sè thø II)');
 Writeln(' + KÕt qu¶ ®óng : ', c1, ' ', d1);
 Writeln(' + KÕt qu¶ HS   : ', c2, ' ', d2);
 if (c1 > 10000) or (d1 <> d2) then
  begin
   Writeln('YÕu råi');
   Wrong;
  end;
 Writeln('Tèt');
 Writeln('KiÓm tra lêi gi¶i: ');
 Close(f1);
 New(a); New(b); New(Mark);
 Assign(f1, 'GUEST.IN' + ch); Reset(f1);
 Readln(f1, n);
 for i := 1 to n do Readln(f1, a^[i], b^[i]);
 Close(f1);
 FillChar(Mark^, SizeOf(Mark^), False);
 for i := 1 to c2 do
  begin
   Readln(f2, k);
   if k = 0 then
    begin
     Writeln(' + Sai khu«n d¹ng d÷ liÖu. YÕu råi!');
     Wrong;
    end;
   Mark^[k] := True;
   d2 := d2 - b^[k];
   if d2 < 0 then
    begin
     Writeln(' + TÝnh tæng sai. YÕu råi!');
     Wrong;
    end;
   if (a^[k] <> 0) and (Mark^[a^[k]]) then
    begin
     Writeln(' + SÕp cña ng­êi ', k, ' lµ ', a^[k], ' ®· cã mÆt. MÊt vui råi!');
     Wrong;
    end;
  end;
 if d2 > 0 then
  begin
   Writeln(' + TÝnh tæng sai. YÕu råi!');
   Wrong;
  end
 else
  Writeln('Tèt');
 Correct;
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
 St: String[2];
begin
 Caption('Nh÷ng ng­êi thÝch ®ïa');
 MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: GUEST.IN');
 repeat
  ch := ReadKey;
 until ch in ['0'..'9', #13];
 Write(ch);
 if ch = #13 then
  begin
   Str(Readp, St);
   MSG(40, 14, 'Tæng ®iÓm', 'B¹n cã ' + St + '/10 points');
   Readkey;
   Halt;
  end;
 ctest076.p := 0;
 if ch = '1' then Writep;
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
 Mark(PMark);
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
end.