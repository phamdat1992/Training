program AssignmentProblemSolver;
uses crt, visual;
const
  InputFile: string = 'ASSIGN.IN';
  OutputFile = 'ASSIGN.OUT';
  max = 400;
  maxE = 10001;
  maxC = max * maxE + 1;
type
  TLine = array[1..max] of Integer;
  PLine = ^TLine;
  TBoard = array[0..max + 1] of PLine;
var
  cost: TBoard;
  mincost, superman: TLine;
  typ: array[1..max] of Integer;
  matchX, matchY: array[1..max] of Integer;
  d: array[1..max] of LongInt;
  arg: array[1..max] of Integer;
  Queue: array[1..max] of Integer;
  Trace: array[1..max] of Integer;
  Fx, Fy: array[1..max] of LongInt;
  nAdd, m, n, r, k, first, last, start, finish: Integer;
  res: LongInt;
  PMark: Pointer;
  f: Text;
  ch: Char;
{$R-,Q-}
procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  Mark(PMark);
  for i := 0 to max + 1 do
    begin
      New(cost[i]);
      FillChar(cost[i]^, SizeOf(cost[i]^), $FF); {-1}
    end;
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n, r);
  FillChar(typ, SizeOf(typ), 0);
  for i := 1 to m do Read(f, typ[i]);
  Readln(f);
  while not SeekEof(f) do
    Read(f, i, j, cost[i]^[j]);
  Close(f);
  for j := 1 to n do
    begin
      minCost[j] := maxE;
      for i := 1 to r do
        if (cost[i]^[j] <> -1) and (cost[i]^[j] < minCost[j]) then
          begin
            minCost[j] := cost[i]^[j];
            superman[j] := i;
          end;
    end;
  Cost[0]^ := minCost;
end;

function c(i, j: Integer): LongInt;
var
  t: LongInt;
begin
  if cost[typ[i]]^[j] = -1 then c := maxC
  else c := cost[typ[i]]^[j];
end;

procedure Init;
var
  i, j: Integer;
begin
  FillChar(matchX, SizeOf(matchX), 0);
  FillChar(matchY, SizeOf(matchY), 0);
  if m > n then k := m else k := n;
  for i := m + 1 to k do typ[i] := max + 1;
  for i := 1 to k do
    begin
      Fx[i] := maxC;
      for j := 1 to k do
        if Fx[i] > c(i, j) then Fx[i] := c(i, j);
    end;
  for j := 1 to k do
    begin
      Fy[j] := maxC;
      for i := 1 to k do
        if Fy[j] > c(i, j) - Fx[i] then
          Fy[j] := c(i, j) - Fx[i];
    end;
end;

procedure InitBFS;
var
  y: Integer;
begin
  first := 1; last := 1;
  Queue[1] := start;
  FillChar(Trace, SizeOf(Trace), 0);
  for y := 1 to k do
    begin
      d[y] := maxC;
      arg[y] := start;
    end;
  finish := 0;
end;

procedure Push(x: Integer);
begin
  Inc(last);
  Queue[last] := x;
end;

function Pop: Integer;
begin
  Pop := Queue[first];
  Inc(first);
end;

procedure FindAugmentingPath;
var
  x, y: Integer;
  tmp: LongInt;
begin
  repeat
    x := Pop;
    for y := 1 to k do
      if Trace[y] = 0 then
        begin
          tmp := c(x, y) - Fx[x] - Fy[y];
          if tmp = 0 then
            begin
              Trace[y] := x;
              if matchY[y] = 0 then
                begin
                  finish := y;
                  Exit;
                end;
              Push(matchY[y]);
            end;
          if d[y] > tmp then
            begin
              d[y] := tmp;
              arg[y] := x;
            end;
        end;
  until first > last;
end;

procedure SubX_AddY;
var
  Delta: LongInt;
  y, x: Integer;
begin
  Delta := maxC;
  for y := 1 to k do
    if (Trace[y] = 0) and (d[y] < Delta) then Delta := d[y];
  for y := 1 to k do
    if Trace[y] <> 0 then
      begin
        x := matchY[y];
        Fy[y] := Fy[y] - Delta;
        Fx[x] := Fx[x] + Delta;
      end;
  Fx[start] := Fx[start] + Delta;
  for y := 1 to k do
    if Trace[y] = 0 then
      begin
        d[y] := d[y] - Delta;
        if d[y] = 0 then
          begin
            Trace[y] := arg[y];
            if matchY[y] = 0 then
              begin
                finish := y;
                Exit;
              end;
            Push(matchY[y]);
          end;
      end;
end;

procedure Enlarge;
var
  x, next: Integer;
begin
  repeat
    x := Trace[finish];
    next := matchX[x];
    matchX[x] := finish;
    matchY[finish] := x;
    finish := next;
  until finish = 0;
end;

procedure Solve;
var
  i, j: Integer;
  front, rear: Integer;
begin
  Init;
  for i := 1 to k do
    begin
      start := i;
      InitBFS;
      repeat
        FindAugmentingPath;
        if finish = 0 then SubX_AddY;
      until finish <> 0;
      Enlarge;
    end;
  for j := 1 to k do
    begin
      i := matchY[j];
      if c(i, j) = maxC then {X[i] to be superman}
        typ[i] := 0;
    end;
  front := 0;
  for rear := 1 to k do
    if typ[rear] <> 0 then
      begin
        Inc(front);
        typ[front] := typ[rear];
      end;
  for rear := front + 1 to n do typ[rear] := 0;
  m := n;
  Init;
  for i := 1 to n do
    begin
      start := i;
      InitBFS;
      repeat
        FindAugmentingPath;
        if finish = 0 then SubX_AddY;
      until finish <> 0;
      Enlarge;
    end;
  nAdd := 0; res := 0;
  for j := 1 to n do
    begin
      i := matchY[j];
      if typ[i] = 0 then
        begin
          typ[i] := superman[j];
          Inc(nAdd);
        end;
      res := res + c(i, j);
    end;
end;
{$R+,Q+}
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
  {$I-}
  Assign(f, 'POINT.PNT'); Reset(f);
  if IOResult <> 0 then
    begin
      WriteP(0);
      Reset(f);
    end;
  {$I+}
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
  MSG(60, 3, 'Tæng', 'Tæng ®iÓm ®ang lµ ' + S + '/50');
end;

procedure Correct;
begin
  Visual.Color := 47;
  MSG(20, 3, InputFile, '   B¹n cã 1 ®iÓm   ');
  WriteP(ReadP + 5);
  ShowP;
  if ReadP = 50 then
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
var
  S: String[1];
begin
  Caption('Bµi 131: "TuyÓn nh©n c«ng"');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: ' + InputFile + '  '#8#8);
  if (ParamCount <> 0) and (ParamStr(1) <> '') then
    begin
      S := ParamStr(1);
      ch := S[1];
    end
  else  ch := ReadKey;
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
  Lab, count: array[1..max] of Integer;
  HSAdd2, hsRes2, HSAdd, hsRes, i, j: LongInt;
begin
  Caption('ChÊm bµi 131: "TuyÓn nh©n c«ng"');
  Visual.Color := 159;
  Release(PMark);
  Enter;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, HSAdd, hsRes);
  Writeln('KÕt qu¶: ');
  Writeln('  + §¸p ¸n   : Thªm ', nAdd, ', träng sè: ', Res);
  Writeln('  + Häc sinh : Thªm ', hsAdd, ', träng sè: ', hsRes);
  if (nAdd < hsAdd) or
     (nAdd = hsAdd) and (Res < hsRes) then
       begin
         Writeln('Kh«ng tèi ­u!');
         Wrong;
       end;
  FillChar(count, SizeOf(count), 0);
  for i := 1 to m do Inc(count[typ[i]]);
  hsRes2 := 0; hsAdd2 := 0;
  for i := 1 to n do
    begin
      Readln(f, j);
      if (j < 1) or (j > r) then
        begin
          Writeln('Kh«ng cã thî lo¹i ', j);
          Wrong;
        end;
      if cost[j]^[i] = -1 then
        begin
          Writeln('Thî lo¹i ', j, ' kh«ng lµm ®­îc viÖc ', i);
          Wrong;
        end;
      hsRes2 := hsRes2 + cost[j]^[i];
      Dec(count[j]);
      if count[j] < 0 then Inc(hsAdd2);
    end;
  Writeln('TÝnh theo ph­¬ng ¸n: ');
  Writeln('  Thªm vµo ', hsAdd2, ' träng sè ', hsRes2);
  if (hsAdd2 <> hsAdd) or (hsRes2 <> hsRes) then
    begin
      Writeln('TiÒn hËu bÊt nhÊt!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Solve;
  Test;
end.

1 2 3
1
1 1 10
1 2 30
3 1 1
3 2 25
2 2 40

10 4 6
1 3 5 5 5 5 5 5 5 5
1 1 10
1 2 10
1 3 10
3 1 10
3 2 10
3 3 10
2 2 9
2 1 8
4 2 6
4 3 5
6 4 0

5 6 6
1 2 3 4 5
1 1 10000
2 1 0
2 2 10000
3 2 0
3 3 10000
4 3 0
4 4 10000
5 4 0
5 5 10000
6 5 0
6 6 10000