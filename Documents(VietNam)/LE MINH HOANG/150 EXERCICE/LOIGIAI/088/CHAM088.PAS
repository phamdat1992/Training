program ParallelProgrammeTest;
uses crt, Visual;
{R-,S-,Q-,I-,D-}
const
  InputFile: String = 'SOFTWARE.IN';
  OutputFile = 'SOFTWARE.OUT';
  maxN = 100;
  maxT = 100;
type
  TLine = array[0..maxN * maxT div 16] of Word;
var
  BestTime, n, Limit: Integer;
  Mask: array[0..15] of Word;
  p, c: array[1..maxN] of Integer;
  Mark: array[1..maxN] of Boolean;
  Trace: array[1..maxN] of ^TLine;
  fP: array[0..maxN * maxT] of Integer;
  f: Text;
  ch: Char;
  {fP(x): Thoi gian toi thieu ma LTV Pascal phai lam trong truong hop LTV C++
                  lam trong x phut}
procedure Enter;
var
  f: Text;
  S1, S2, i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do Read(f, p[i]);
  S1 := 0; S2 := 0;
  for i := 1 to n do
    begin
      Read(f, c[i]);
      if i < n shr 1 then S1 := S1 + p[i]
      else S2 := S2 + c[i];
    end;
  if S1 > S2 then Limit := S1 else Limit := S2; {Greedy Init}
  Close(f);
end;

procedure Init;
var
  i: Integer;
begin
  fP[0] := 0;
  for i := 1 to n do
    begin
      New(Trace[i]);
      FillChar(Trace[i]^, SizeOf(Trace[i]^), 0);
    end;
  for i := 0 to 15 do Mask[i] := Word(1) shl i;
end;

procedure SetBit1(i, j: Integer);
begin
  Trace[i]^[j shr 4] := Trace[i]^[j shr 4] or Mask[j and 15];
end;

function GetBit(i, j: Integer): Boolean;
begin
  GetBit := Trace[i]^[j shr 4] and Mask[j and 15] <> 0;
end;

procedure Optimize;
var
  i, t: Integer;
begin
  (*  fP(t)[i] := min {fP(t)[i - 1] + p[i], fP(t - c[i])[i - 1]}   *)
  for i := 1 to n do
    for t := Limit downto 0 do
      begin
        fP[t] := fP[t] + p[i]; {Viec i do LTV Pascal lam}
        if (t >= c[i]) and (fP[t] > fP[t - c[i]]) then
          begin
            fP[t] := fP[t - c[i]]; {Viec i do LTV C++ lam}
            SetBit1(i, t);
          end;
      end;
end;

procedure Result;
var
  m, t: Integer;
begin
  BestTime := MaxInt;
  for t := 0 to Limit do
    begin
      if t >= BestTime then Break;
      if t > fP[t] then m := t
      else m := fP[t];
      if BestTime > m then  BestTime := m;
    end;
end;

procedure Halt;
begin
  {$I-}
  Close(f); if IOResult = 0 then;
  {$I+}
  ReadKey;
  TextMode(C80); Textattr := 7; Clrscr;
  System.Halt;
end;

procedure WriteP(p: Integer);
var
  f: file of Integer;
begin
  Assign(f, 'POINT.PNT'); Rewrite(f);
  Write(f, p);
  Close(f);
end;

function ReadP: Integer;
var
  f: file of Integer;
  P: Integer;
begin
  Assign(f, 'POINT.PNT'); Reset(f);
  Read(f, p);
  Close(f);
  ReadP := p;
end;

procedure ShowP;
var
  S: String;
begin
  Str(ReadP, S);
  if Length(S) < 2 then S := '0' + S;
  Visual.Color := 30;
  MSG(60, 3, 'Tæng', 'Tæng ®iÓm ®ang lµ ' + S + '/10');
end;

procedure Correct;
begin
  Visual.Color := 47;
  MSG(20, 3, InputFile, '   B¹n cã 1 ®iÓm   ');
  WriteP(ReadP + 1);
  ShowP;
  if ReadP = 10 then
    Logo('§óng hÕt c¸c test', 'Perfect! Perfect!');
  Halt;
end;

procedure Wrong;
begin
  Visual.Color := 78;
  MSG(20, 3, InputFile, '   B¹n cã 0 ®iÓm   '#7);
  ShowP;
  Halt;
end;

procedure AskTest;
begin
  Caption('Bµi 088: "T­ duy kiÓu óc"');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: SOFTWARE.IN  '#8#8);
  ch := ReadKey;
  Write(ch);
  if ch = '1' then WriteP(0);
  if ch = #13 then
    begin
      MSG(40, 13, '§iÓm', 'Tæng ®iÓm cña b¹n ®ang lµ:  '#8#8);
      Write(ReadP);
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure Test;
var
  i, S, workp, workc, Sp, Sc: Integer;
  Mark: array[1..maxN] of Integer;
begin
  Caption('ChÊm bµi: "T­ duy kiÓu óc"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, S);
  Writeln('Dßng 1: ');
  Writeln('  + §¸p ¸n  : ', BestTime);
  Writeln('  + Häc sinh: ', S);
  if S > BestTime then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end
  else
    if S < BestTime then Writeln('Tèt h¬n ®¸p ¸n!')
    else Writeln('Tåi nh­ ®¸p ¸n!');
  FillChar(Mark, SizeOf(Mark), 0);
  Sp := 0; Sc := 0;
  Writeln('C¸c c«ng ®o¹n viÕt b»ng PASCAL:');
  while not SeekEoln(f) do
    begin
      Read(f, workp); Sp := Sp + p[workp];
      Write(workp, ' ');
      if Mark[workp] <> 0 then
        begin
          Writeln('ViÖc ', workp, ' ®­îc ph©n hai lÇn!');
          Wrong;
        end;
      Mark[workp] := 1
    end;
  Writeln;
  Readln(f);
  Writeln('C¸c c«ng ®o¹n viÕt b»ng C++:');
  while not SeekEoln(f) do
    begin
      Read(f, workc); Sc := Sc + c[workc];
      Write(workc, ' ');
      if Mark[workc] <> 0 then
        begin
          Writeln('ViÖc ', workc, ' ®­îc ph©n hai lÇn!');
          Wrong;
        end;
      Mark[workc] := 2;
    end;
  for i := 1 to n do
    if Mark[i] = 0 then
      begin
        Writeln('Viec ', i, ' chua duoc phan cong');
      end;
  Writeln;
  Writeln(' + Tæng thêi gian thùc hiÖn cña LTV PASCAL: ', Sp);
  Writeln(' + Tæng thêi gian thùc hiÖn cña LTV C++   : ', Sc);
  if (Sp > S) or (Sc > S) then
    begin
      Writeln('M©u thuÉn víi dßng I');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng ®¾n!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Optimize;
  Result;
  Test;
end.
