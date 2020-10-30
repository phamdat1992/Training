{$M 65520,0,655360}
program CargoMove;
uses crt, visual;
const
  InputFile: string = 'CARGO.IN';
  OutputFile = 'CARGO.OUT';
  max = 80;
  maxC = max * max * 4 + 1;
  DName: array[1..4] of Char = 'SEWN';
  DLName: array[1..4] of Char = 'sewn';
  dx: array[1..4] of ShortInt = (1, 0, 0, -1);
  dy: array[1..4] of ShortInt = (0, 1, -1, 0);
type
  THeapArr = array[1..max * max * 4] of ShortInt;
  TWBoard = array[1..4, 1..max, 1..max] of Integer;
  TBBoard = array[1..4, 1..max, 1..max] of ShortInt;
var
  m, n: Integer;
  a: array[0..max + 1, 0..max + 1] of Char;
  heapX, heapY, heapK: ^THeapArr;
  d, pos: ^TWBoard;
  Trace: ^TBBoard;
  TraceBFS: array[1..max, 1..max] of ShortInt;
  nHeap: Integer;
  XS, YS, kD, XD, YD, XR, YR: Integer;
  res: LongInt;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  FillChar(a, SizeOf(a), '#');
  Assign(f, InputFile); Reset(f);
  readln(f, m, n);
  XS := 0; YS := 0;
  XD := 0; YD := 0;
  for i := 1 to m do
    begin
      for j := 1 to n do
        begin
          Read(f, a[i, j]);
          case a[i, j] of
            '@':
              begin
                XD := i; YD := j;
              end;
            '$':
              begin
                XS := i; YS := j;
              end;
            '*':
              begin
                XR := i; YR := j;
              end;
          end;
        end;
      Readln(f);
    end;
  Close(f);
end;
{$R-,Q-}
function NodeValue(iHeap: Integer): Integer;
begin
  NodeValue := d^[heapK^[iHeap], heapX^[iHeap], heapY^[iHeap]];
end;

procedure SetNodeValue(iHeap, k, x, y: Integer);
begin
  heapK^[iHeap] := k;
  heapX^[iHeap] := x;
  heapY^[iHeap] := y;
  Pos^[k, x, y] := iHeap;
end;

procedure Push(k, x, y: Integer);
var
  r, c: Integer;
begin
  c := Pos^[k, x, y];
  if c = 0 then
    begin
      Inc(nHeap);
      c := nHeap;
    end;
  r := c div 2;
  while (r > 0) and (NodeValue(r) > d^[k, x, y]) do
    begin
      SetNodeValue(c, heapK^[r], heapX^[r], heapY^[r]);
      c := r;
      r := c div 2;
    end;
  SetNodeValue(c, k, x, y);
end;

function Valid(k, x, y: Integer): Boolean;
begin
  Valid := a[x + dx[k], y + dy[k]] <> '#';
end;

procedure Init;
var
  k, x, y: Integer;
begin
  New(d);
  for k := 1 to 4 do
    begin
      for x := 1 to m do
        for y := 1 to n do d^[k, x, y] := MaxC;
    end;
  New(pos);
  FillChar(pos^, SizeOf(pos^), 0);
  New(heapK); New(heapX); New(heapY);
  nHeap := 0;
  for k := 1 to 4 do
    if Valid(k, XD, YD) then
      begin
        d^[k, XD, YD] := 0;
        Push(k, XD, YD);
      end;
  New(Trace);
end;

procedure Pop(var pk, px, py: Integer);
var
  tk, tx, ty: Integer;
  r, c: Integer;
begin
  pk := heapK^[1]; px := heapX^[1]; py := heapY^[1];
  pos^[pk, px, py] := -1;
  tk := heapK^[nHeap]; tx := heapX^[nHeap]; ty := heapY^[nHeap];
  Dec(nHeap);
  r := 1;
  while r * 2 <= nHeap do
    begin
      c := r * 2;
      if (c < nHeap) and (NodeValue(c + 1) < NodeValue(c)) then
        Inc(c);
      if d^[tk, tx, ty] <= NodeValue(c) then Break;
      SetNodeValue(r, heapK^[c], heapX^[c], heapY^[c]);
      r := c;
    end;
  SetNodeValue(r, tk, tx, ty);
end;

function BFS(x1, y1, x2, y2, xC, yC: Integer): Integer;
label Done;
var
  Qx, Qy: array[1..max * max] of ShortInt;
  Layer: array[1..max, 1..max] of Integer;
  first, last: Integer;
  d, x, y, newx, newy: Integer;
  Save: Char;
begin
  Qx[1] := x1; Qy[1] := y1;
  first := 1; last := 1;
  Save := a[xC, yC];
  a[xC, yC] := '#';
  FillChar(Layer, SizeOf(Layer), 0);
  Layer[x1, y1] := 1;
  while first <= last do
    begin
      x := Qx[first]; y := Qy[first];
      Inc(first);
      for d := 1 to 4 do
        begin
          newx := x + dx[d]; newy := y + dy[d];
          if (a[newx, newy] <> '#') and (Layer[newx, newy] = 0) then
            begin
              Layer[newx, newy] := Layer[x, y] + 1;
              if (newx = x2) and (newy = y2) then goto Done;
              Inc(last);
              Qx[last] := newx; Qy[last] := newy;
            end;
        end;
    end;
Done:
  a[xC, yC] := Save;
  if Layer[x2, y2] = 0 then BFS := MaxC
  else BFS := Layer[x2, y2] - 1;
end;

procedure Update(pk, px, py: Integer);
var
  k, x, y, dis: Integer;
  FD: Integer;
begin
  FD := d^[pk, px, py];
  k := pk;
  x := px + dx[pk]; y := py + dy[pk];
  if Valid(k, x, y) and (FD + 1 < d^[k, x, y]) then
    begin
      d^[k, x, y] := FD + 1;
      Trace^[k, x, y] := 0;
      Push(k, x, y);
    end;
  x := px; y := py;
  for k := 1 to 4 do
    if Valid(k, x, y) then
      begin
        if FD >= d^[k, x, y] then Continue;
        dis := BFS(x + dx[pk], y + dy[pk], x + dx[k], y + dy[k],
                   x, y);
        if FD + dis < d^[k, x, y] then
          begin
            d^[k, x, y] := FD + dis;
            Trace^[k, x, y] := pk;
            Push(k, x, y);
          end;
      end;
end;

function CanFinish: Boolean;
var
  k: Integer;
begin
  for k :=1 to 4 do
    if Valid(k, xS, yS) and (pos^[k, xS, yS] >= 0) then
      begin
        CanFinish := False;
        Exit;
      end;
  CanFinish := True;
end;

procedure Dijkstra;
var
  pk, px, py: Integer;
begin
  while nHeap <> 0 do
    begin
      Pop(pk, px, py);
      if CanFinish then Break;
      Update(pk, px, py);
    end;
end;

procedure GetResult;
var
  dis: Integer;
  k: Integer;
begin
  res := MaxLongInt;
  for k := 1 to 4 do
    if Valid(k, xS, yS) then
      begin
        dis := BFS(xS + dx[k], yS + dy[k], xR, yR, xS, yS);
        if d^[k, XS, yS] + dis < res then
          begin
            res := d^[k, XS, yS] + dis;
            kd := k;
          end;
      end;
  if res >= MaxC then res := -1;
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
  MSG(60, 3, 'TÊng', 'TÊng Æi”m Æang lµ ' + S + '/10');
end;

procedure Correct;
begin
  Visual.Color := 47;
  MSG(20, 3, InputFile, '   Bπn c„ 1 Æi”m   ');
  WriteP(ReadP + 1);
  ShowP;
  if ReadP = 10 then
    Logo('ßÛng h’t c∏c test', 'Perfect! Perfect!');
  Halt;
end;

procedure Wrong;
begin
  Visual.Color := 78;
  MSG(20, 3, InputFile, '   Bπn c„ 0 Æi”m   '#7);
  ShowP;
  Halt;
end;

procedure AskTest;
var
  S: String[1];
begin
  Caption('Bµi 003: "CARGO"');
  MSG(40, 3, 'Input?', 'Cho t™n file d˜ li÷u: ' + InputFile + '  '#8#8);
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
      MSG(40, 13, 'ßi”m', 'TÊng Æi”m cÒa bπn Æang lµ:  '#8#8);
      Write(ReadP);
      Halt;
    end;
  InputFile := InputFile + ch;
end;

function Adj(x1, y1, x2, y2: Integer): Boolean;
begin
  Adj := Abs(x1 - x2) + Abs(y1 - y2) = 1;
end;

procedure Test;
var
  i, hsRes: LongInt;
  d, newxR, newyR, newxS, newyS: Integer;
  c: Char;
begin
  Caption('Ch m bµi 003: "ß»y hµng"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'Ki”m tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, hsRes);
  Writeln('Chi ph› Æ»y hµng: ');
  Writeln('  + ß∏p ∏n:   ', res);
  Writeln('  + H‰c sinh: ', hsRes);
  if (res = hsRes) and (res = -1) then
    begin
      Writeln('K’t qu∂ ÆÛng!');
      Correct;
    end;
  if (res <> hsRes) and ((res = -1) or (hsRes = -1)) then
    begin
      Writeln('K’t qu∂ sai!');
      Wrong;
    end;
  if (res < hsRes) then
    begin
      Writeln('Kh´ng tËi ≠u!');
      Wrong;
    end;
  Enter;
  a[xR, yR] := '.';
  a[xD, yD] := '.';
  for i := 1 to hsRes do
    begin
      Read(f, ch);
      if not (ch in ['N', 'S', 'W', 'E', 'n', 's', 'w', 'e']) then
        begin
          Writeln('Ph–p di chuy”n th¯ ', i, ' = ', ch, ' kh´ng hÓp l÷!');
          Wrong;
        end;
      newxS := xS; newyS := yS;
      case ch of
        'n', 's', 'w', 'e':
          begin
            d := System.pos(ch, 'sewn');
            newxR := xR + dx[d]; newyR := yR + dy[d];
          end;
        'N', 'S', 'W', 'E':
          begin
            if not Adj(xR, yR, xS, yS) then
              begin
                Writeln('Ph–p di chuy”n th¯ ', i, ' = ', ch);
                Writeln('ß»y hµng khi kh´ng Æ¯ng cπnh hµng!');
                Wrong;
              end;
            d := System.pos(ch, 'SEWN');
            newxR := xR + dx[d]; newyR := yR + dy[d];
            newxS := xS + dx[d]; newyS := yS + dy[d];
          end;
      end;
      if a[newxS, newyS] = '#' then
        begin
          Writeln('Ph–p di chuy”n th¯ ', i, ': ');
          Writeln('Ki÷n hµng Æi Æ’n ´ (', newxs, ', ', newys, ') = ',
                        a[newxS, newyS]);
          Wrong;
        end;
      a[xS, yS] := '.';
      a[newxS, newyS] := '$';
      xS := newxS; yS := newyS;
      if (a[newxR, newyR] <> '.') then
        begin
          Writeln('Ph–p di chuy”n th¯ ', i, ': ');
          Writeln('Xe Æ»y Æi Æ’n ´ (', newxR, ', ', newyR, ') = ',
                        a[newxR, newyR]);
          Wrong;
        end;
      xR := newxR; yR := newyR;
    end;
  Writeln('Vﬁ tr› ki÷n hµng sau khi chuy”n: (', xS, ', ', yS, ')');
  Writeln('Vﬁ tr› c«n chuy”n Æ’n          : (', xD, ', ', yD, ')');
  if (xS <> xD) or (yS <> yD) then Wrong;
  Writeln('K’t qu∂ ÆÛng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Dijkstra;
  GetResult;
  Test;
end.
