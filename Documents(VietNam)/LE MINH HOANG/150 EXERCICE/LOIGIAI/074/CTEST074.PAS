unit CTest074;
interface
 procedure StartCount(TimeOut: Integer);

implementation
uses crt, dos, visual;
const
 InputFile  = '.INP';
 OutputFile = '.OUT';
var
 Value, Limit: Integer;
 OldExit, OldInt, PMark: Pointer;
 ch: String[2];

function ReadPoint: Integer;
var
 f: File Of Integer;
 i: Integer;
begin
 {$I-}
 Assign(f, 'POINT.TXT'); Reset(f);
 if IOResult <> 0 then ReadPoint := 0
 else
  begin
   Read(f, i);
   ReadPoint := i;
   Close(f);
  end;
 {$I+}
end;

procedure WritePoint(p: Integer);
var
 f: file of Integer;
begin
 Assign(f, 'POINT.TXT'); Rewrite(f);
 Write(f, p);
 Close(f);
end;

procedure Perfect;
begin
 Logo('You are a super programmer', 'Perfect! Perfect!');
end;

procedure ShowPoint;
var
 p: Integer;
 S: string[2];
begin
 p := ReadPoint; Str(p, S); S:= S;
 Color := 228;
 if p = 20 then
  begin
   Msg(8, 3, 'Hoµn h¶o', 'B¹n cã: ' + S + '/20 §iÓm');
   Perfect;
  end
 else Msg(8, 3, 'Tæng ®iÓm', 'B¹n cã: ' + S + '/20 §iÓm');
end;

procedure Wrong;
begin
 while keypressed do ReadKey;
 Color := 78;
 MSG(35, 3, #7'Lçi', 'Test nµy: 0 ®iÓm');
 ShowPoint;
 ReadKey;
 Halt;
end;

procedure Correct;
begin
 while keypressed do ReadKey;
 WritePoint(ReadPoint + 1);
 Color := 47;
 MSG(35, 3, 'ChÝnh x¸c', 'Test nµy: 1 ®iÓm');
 ShowPoint;
 ReadKey;
 Halt;
end;

procedure Test;
var
 a, b: array[1..1000] of Integer;
 i, j, n, n2: Integer;
 f: Text;
 S: String[5];
begin
 Caption('Bé test bµi to¸n t×m ®Ønh c¾t trong ®å thÞ');
 Color := 30;
 Str((Limit - Value)/18.2:5:2, S);
 Msg(65, 3, 'Thêi gian', ch + InputFile + ' - ' + S + ' (gi©y)');
 Color := 159;
 FlatFrame(3, 7, 78, 23, 'ChÊm bµi');
 Assign(f, ch + OutputFile); Reset(f);
 Readln(f, n);
 for i := 1 to n do Read(f, a[i]);
 Close(f);
 Assign(f, 'CNODE' + OutputFile); Reset(f);
 Readln(f, n2);
 for i := 1 to n2 do Read(f, b[i]);
 Close(f);
 Writeln('Sè l­îng ®Ønh c¾t: ');
 Writeln('  + §¸p ¸n  : ', n);
 Writeln('  + Häc sinh: ', n2);
 if n <> n2 then
  begin
   writeln('YÕu råi!');
   Wrong;
  end
 else
  writeln('Tèt!');
 Writeln('C¸c ®Ønh c¾t: ');
 Write('  + §¸p ¸n  : ');
 for i := 1 to n do Write(a[i], ','); Writeln;
 Write('  + Häc sinh: ');
 for i := 1 to n do Write(b[i], ','); Writeln;
 for i := 1 to n do
  for j := 1 to n do
   if a[i] = b[j] then a[i] := 0;
 for i := 1 to n do
  if a[i] <> 0 then
   begin
    Writeln('Lçi! Kh«ng cã ®Ønh: ', a[i], '. YÕu råi');
    Wrong;
   end;
 Writeln('Tèt!');
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
begin
 Caption('Bµi to¸n liÖt kª ®Ønh c¾t');
 MSG(40, 3, 'D÷ liÖu vµo?', 'Sè hiÖu Test (0..19):   '#8#8);
 Readln(ch); Writeln(ch);
 if ch = '0' then WritePoint(0);
 if ch = '' then
  begin
   ShowPoint;
   Readkey; Halt;
  end;
 while Length(Ch) < 2 do ch := '0' + ch;
 GetMem(p, 60000);
 Assign(f1, ch + InputFile); Reset(f1, 1);
 Assign(f2, 'CNODE' + InputFile); Rewrite(f2, 1);
 repeat
  BlockRead(f1, p^, 60000, s);
  BlockWrite(f2, p^, s);
 until Eof(f1);
 Close(f1);
 Close(f2);
 FreeMem(p, 60000);
 Default;
 TextAttr := 7; Clrscr;
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
