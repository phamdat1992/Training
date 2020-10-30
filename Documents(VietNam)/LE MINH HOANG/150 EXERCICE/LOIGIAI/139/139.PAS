program HorseMan;
const
  InputFile  = 'HORSEMAN.INP';
  OutputFile = 'HORSEMAN.OUT';
  max = 100;
  maxC = max * max + 1;
  hdx: array[1..8] of Integer = (1, 2, 2, 1, -1, -2, -2, -1);
  hdy: array[1..8] of Integer = (2, 1, -1, -2, -2, -1, 1, 2);
  mdx: array[1..4] of Integer = (0, 0, 1, -1);
  mdy: array[1..4] of Integer = (1, -1, 0, 0);
type
  TDistance = array[1..max, 1..max] of Integer;
  TQueueBFS = array[1..max * max] of Integer;
  TNode = record
    data, code: Integer;
  end;
  TQueue = array[1..max * 4] of TNode;
var
  a: array[-1..max + 2, -1..max + 2] of Char;
  manX, manY, horseX, horseY, postX, postY: array[1..max] of Integer;
  dis, dman, dhorse: ^TDistance;
  Qx, Qy: ^TQueueBFS;
  TraceBFS: array[1..max, 1..max] of Byte;
  Trace: array[1..max, 1..4] of TNode;
  matchX, matchY, matchL, matchR: array[1..max] of Integer;
  man, horse: array[1..max] of set of Byte;
  cmax, p, q, n, m, first, last, res: Integer;

  start: LongInt;
  time: LongInt absolute 0:$46C;

procedure Enter;
var
  f: Text;
  i, j, t: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, p, q);
  m := 0; n := 0; t := 0;
  FillChar(a, SizeOf(a), '#');
  for i := 1 to p do
    begin
      for j := 1 to q do
        begin
          Read(f, a[i, j]);
          case a[i, j] of
            '@':
                begin
                  Inc(m);
                  postX[m] := i; postY[m] := j;
                end;
            '*':
                begin
                  Inc(n);
                  manX[n] := i; manY[n] := j;
                end;
            '&':
                begin
                  Inc(t);
                  horseX[t] := i; horseY[t] := j;
                end;
          end;
        end;
      Readln(f);
    end;
  Close(f);
end;

procedure AllocMem;
begin
  New(dis); New(dman); New(dhorse);
  New(Qx); New(Qy);
end;

procedure InitBFS(x, y: Integer);
var
  i, j: Integer;
begin
  for i := 1 to p do
    for j := 1 to q do dis^[i, j] := maxC;
  Qx^[1] := x;
  Qy^[1] := y;
  dis^[x, y] := 0;
  last := 1; first := 1;
end;

procedure PushXY(x, y: Integer);
begin
  Inc(last);
  Qx^[last] := x; Qy^[last] := y;
end;

procedure PopXY(var x, y: Integer);
begin
  x := Qx^[first]; y := Qy^[first];
  Inc(first);
end;

procedure BFSMan(startx, starty, finishx, finishy: Integer);
var
  x, y, d, newx, newy, count: Integer;
begin
  InitBFS(startx, starty);
  count := 0;
  while first <= last do
    begin
      PopXY(x, y);
      for d := 1 to 4 do
        begin
          newx := x + mdx[d]; newy := y + mdy[d];
          if (a[newx, newy] <> '#') and (dis^[newx, newy] = maxC) then
            begin
              dis^[newx, newy] := dis^[x, y] + 1;
              TraceBFS[newx, newy] := d;
              if a[newx, newy] = '*' then
                begin
                  Inc(count);
                  if count = n then Exit;
                  if (newx = finishx) and (newy = finishy) then Exit;
                end;
              PushXY(newx, newy);
            end;
        end;
    end;
end;

procedure BFSHorse(startx, starty, finishX, finishY: Integer);
var
  x, y, d, newx, newy, count: Integer;
begin
  InitBFS(startX, startY);
  count := 0;
  while first <= last do
    begin
      PopXY(x, y);
      for d := 1 to 8 do
        begin
          newx := x + hdx[d]; newy := y + hdy[d];
          if (a[newx, newy] <> '#') and (dis^[newx, newy] = maxC) then
            begin
              dis^[newx, newy] := dis^[x, y] + 1;
              TraceBFS[newx, newy] := d;
              if a[newx, newy] = '&' then
                begin
                  Inc(count);
                  if count = n then Exit;
                  if (newx = finishx) and (newy = finishy) then Exit;
                end;
              PushXY(newx, newy);
            end;
        end;
    end;
end;

procedure GetCost;
var
  j, i: Integer;
begin
  for j := 1 to m do
    begin
      BFSMan(postX[j], postY[j], 0, 0);
      for i := 1 to n do
        dman^[i, j] := dis^[manX[i], manY[i]];
      BFSHorse(postX[j], postY[j], 0, 0);
      for i := 1 to n do
        dhorse^[i, j] := dis^[horseX[i], horseY[i]];
    end;
  cmax := 0;
  for i := 1 to n do
    for j := 1 to n do
      begin
        if dman^[i, j] > cmax then cmax := dman^[i, j];
        if dhorse^[i, j] > cmax then cmax := dhorse^[i, j];
      end;
end;

procedure InitSet(threshold: Integer);
var
  i, j: Integer;
begin
  FillChar(man, SizeOf(man), 0);
  FillChar(horse, SizeOf(horse), 0);
  for i := 1 to n do
    for j := 1 to m do
      begin
        if dman^[i, j] <= threshold then Include(man[i], j);
        if dhorse^[i, j] <= threshold then Include(horse[i], j);
      end;
end;

function Greedy: Integer;
var
  j, i, x, y, Flow: Integer;
begin
  Flow := 0;
  for j := 1 to m do
    begin
      x := 0; y := 0;
      for i := 1 to n do
        if (matchX[i] = 0) and (j in man[i]) then
          begin
            x := i; Break;
          end;
      for i := 1 to n do
        if (matchY[i] = 0) and (j in horse[i]) then
          begin
            y := i; Break;
          end;
      if (x <> 0) and (y <> 0) then
        begin
          matchX[x] := j; matchY[y] := j;
          matchL[j] := x; matchR[j] := y;
          Inc(Flow);
        end;
    end;
  Greedy := Flow;
end;

function FindPath: Integer;
var
  i, j, x, y, first, last, ffound: Integer;
  node: TNode;
  Q: TQueue;

  procedure Push(pdata, pcode: Integer);
  begin
    Inc(last);
    Q[last].code := pcode; Q[last].data := pdata;
  end;

  procedure Pop(var pdata, pcode: Integer);
  begin
    pcode := Q[first].code; pdata := Q[first].data;
    Inc(first);
  end;

  procedure Update(node: TNode);
  var
    i, j: Integer;
  begin
    case node.code of
      1:
        for j := 1 to m do
          if (Trace[j, 2].code = 0) and (j in man[node.data])
             and (matchX[node.code] <> j) then
            begin
              Trace[j, 2] := node;
              Push(j, 2);
            end;
      2:
        begin
          if (Trace[node.data, 3].code = 0) and (matchL[node.data] = 0) then
            begin
              Trace[node.data, 3] := node;
              Push(node.data, 3);
            end;
          if (matchL[node.data] <> 0) and
             (Trace[matchL[node.data], 1].code = 0) then
            begin
              Trace[matchL[node.data], 1] := Node;
              Push(matchL[node.data], 1);
            end;
        end;
      3:
        begin
          for i := 1 to n do
            if (Trace[i, 4].code = 0) and (node.data in horse[i])
               and (matchY[i] <> node.data) then
              begin
                Trace[i, 4] := node;
                if matchY[i] = 0 then
                  begin
                    ffound := i;
                    Exit;
                  end;
              end;
          if (Trace[node.data, 2].code = 0) and
             (matchR[node.data] <> 0) then
            begin
              Trace[node.data, 2] := node;
              Push(node.data, 2);
            end;
        end;
      4:
        begin
          Trace[matchY[node.data], 3] := node;
          Push(matchY[node.data], 3);
        end;
    end;
  end;

begin
  FillChar(Trace, SizeOf(Trace), 0);
  first := 1; last := 0;
  for i := 1 to n do
    if matchX[i] = 0 then
      begin
        Push(i, 1);
        Trace[i, 1].code := -1;
      end;
  ffound := 0;
  while first <= last do
    begin
      Pop(Node.data, Node.code);
      Update(Node);
      if ffound <> 0 then Break;
    end;
  FindPath := ffound;
end;

function Solution(threshold: Integer): Boolean;
var
  finish, Flow: Integer;

  procedure IncFlow(finish: Integer);
  var
    node, next: TNode;
  begin
    Inc(Flow);
    node.data := finish; node.code := 4;
    repeat
      next := Trace[node.data, node.code];
      if next.code = -1 then Exit;
      if node.code > next.code then
        case node.code of
          4:  begin
                matchY[node.data] := next.data;
                matchR[next.data] := node.data;
              end;
          2:  begin
                matchX[next.data] := node.data;
                matchL[node.data] := next.data;
              end;
        end;
      node := next;
    until False;
  end;

begin
  FillChar(matchX, SizeOf(matchX), 0);
  FillChar(matchY, SizeOf(matchY), 0);
  FillChar(matchL, SizeOf(matchL), 0);
  FillChar(matchR, SizeOf(matchR), 0);
  InitSet(threshold);
  Flow := Greedy;
  repeat
    finish := FindPath;
    if finish <> 0 then IncFlow(finish)
    else Break;
  until False;
  Solution := Flow = n;
end;

procedure Solve;
var
  inf, sup, median: Integer;
begin
  inf := 0; sup := cmax;
  repeat
    median := (inf + sup) div 2;
    if Solution(median) then sup := median
    else inf := median;
  until inf + 1 >= sup;
  res := sup;
  solution(res);
end;

procedure Result;
var
  f: Text;
  i, j: Integer;

  procedure TraceMan(sx, sy, x, y: Integer);
  var
    d: Integer;
  begin
    repeat
      d := TraceBFS[x, y];
      if (x = sx) and (y = sy) then Break;
      case d of
        1: Write(f, 'W');
        2: Write(f, 'E');
        3: Write(f, 'N');
        4: Write(f, 'S');
      end;
      x := x - mdx[d]; y := y - mdy[d];
    until False;
    Writeln(f);
  end;

  procedure TraceHorse(sx, sy, x, y: Integer);
  var
    d: Integer;
  begin
    repeat
      d := TraceBFS[x, y];
      if (x = sx) and (y = sy) then Break;
      case d of
        1: Write(f, '5');
        2: Write(f, '6');
        3: Write(f, '7');
        4: Write(f, '8');
        5: Write(f, '1');
        6: Write(f, '2');
        7: Write(f, '3');
        8: Write(f, '4');
      end;
      x := x - hdx[d]; y := y - hdy[d];
    until False;
    Writeln(f);
  end;

begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, res);
  for i := 1 to n do
    begin
      j := matchX[i];
      BFSMan(postX[j], postY[j], manX[i], manY[i]);
      Writeln(f, manX[i], ' ', manY[i]);
      TraceMan(postX[j], postY[j], manX[i], manY[i]);
    end;
  for i := 1 to n do
    begin
      j := matchY[i];
      BFSHorse(postX[j], postY[j], horseX[i], horseY[i]);
      Writeln(f, horseX[i], ' ', horseY[i]);
      Tracehorse(postX[j], postY[j], horseX[i], horseY[i]);
    end;
  Close(f);
end;

begin
  start := Time;
  Enter;
  AllocMem;
  GetCost;
  Solve;
  Result;
  Writeln('Time = ', (Time - start)/18.2:1:4);
end.