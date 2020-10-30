{$R-,Q-,S-,I-}
unit CTest078;
interface
 procedure StartCount(TimeOut: Integer);

implementation
uses crt, dos, visual;
const
 InputFile  = 'CHAIN.IN';
 OutputFile = 'CHAIN.OUT';
var
 Value, Limit: Integer;
 OldExit, OldInt, PMark: Pointer;
 ch: Char;
 f1, f2: Text;
procedure Halt;
begin
 {$I-}
 Close(f1); if IOResult = 0 then;
 Close(f2); if IOResult = 0 then;
 {$I+}
 TextMode(C80); TextAttr := 7; Clrscr;
 System.Halt;
end;

procedure Wrong;
begin
 while keypressed do ReadKey;
 Color := 78;
 MSG(60, 3, #7'Lçi', 'Test nµy: 0 ®iÓm');
 ReadKey;
 Halt;
end;

procedure Correct;
begin
 while keypressed do ReadKey;
 Color := 47;
 MSG(60, 3, 'ChÝnh x¸c', 'Test nµy: 1 ®iÓm');
 ReadKey;
 Halt;
end;

procedure Test;
type
 TList = array[1..10000] of Integer;
var
 Mark, Lab: ^TList;
 u, v, i, n: Integer;
begin
 Color := 159;
 FlatFlatFrame(3, 7, 78, 23, 'KiÓm tra kÕt qu¶');
 New(Lab); New(Mark);
 FillChar(Lab^, SizeOf(Lab^), 0);
 Assign(f1, InputFile + 'P'); Reset(f1);
 Readln(f1, n);
 Assign(f2, OutputFile); Reset(f2);
 Writeln('KiÓm tra nh·n (Sè ghi trong ngoÆc lµ nh·n)');
 for i := 1 to n do
  begin
   Read(f2, Lab^[i]);
   if (Lab^[i] <= 0) or (Lab^[i] > n) then
    begin
     Writeln('  + Cã nh·n Lab[', i, '] = ', Lab^[i]);
     Wrong;
    end;
  end;
 Close(f2);
 FillChar(Mark^, SizeOf(Mark^), 0);
 for i := 1 to n do
  if Mark^[Lab^[i]] <> 0 then
   begin
    Writeln('  + §Ønh ', Mark^[Lab^[i]], ' vµ', i, ' ®Òu cã nh·n ', Lab^[i]);
    Wrong;
   end
  else
   Mark^[Lab^[i]] := i;
 FillChar(Mark^, SizeOf(Mark^), 0);
 for i := 1 to n - 1 do
  begin
   Readln(f1, u, v);
   Writeln(i:5, '. C¹nh: ', u, '(', Lab^[u], ')-',
                             v, '(', Lab^[v], ')');
   if Mark^[Abs(Lab^[u] - Lab^[v])] <> 0 then
    begin
     Writeln('  + Cã hai c¹nh mµ chªnh lÖch hai ®Çu mót ®Òu lµ: ',
                Abs(Lab^[u] - Lab^[v]));
     Wrong;
    end
   else
    Mark^[Abs(Lab^[u] - Lab^[v])] := 1;
  end;
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
 Caption('Bé Test bµi "D©y xÝch"');
 MSG(20, 3, 'Input?', 'Tªn file d÷ liÖu: CHAIN.IN  '#8#8);
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
 StartCount(10);
 Mark(PMark);
end.
