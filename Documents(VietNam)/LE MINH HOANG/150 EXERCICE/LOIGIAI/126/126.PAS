program Olympic;
const
  InputFile  = 'OLYMPIC.INP';
  OutputFile = 'OLYMPIC.OUT';
  max = 255;
type
  TSet = set of 1..max;
  TNode = record
    code: Integer;
    data: Integer;
  end;
var
  Sx, Sy: array[1..max] of TSet;
  matchX, matchY, matchL, matchR: array[1..max] of Integer;
  Trace: array[1..4, 1..max] of TNode;
  Q: array[1..4 * max] of TNode;
  first, last: Integer;
  n, m: Integer;
  Time: LongInt absolute 0:$46C;
  Start: LongInt;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  FillChar(Sx, SizeOf(Sx), 0);
  FillChar(Sy, SizeOf(Sy), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for i := 1 to n do
    begin
      while not SeekEoln(f) do
        begin
          Read(f, j);
          Include(Sx[i], (j));
        end;
      Readln(f);
    end;
  for i := 1 to n do
    begin
      while not SeekEoln(f) do
        begin
          Read(f, j);
          Include(Sy[i], (j));
        end;
      Readln(f);
    end;
  Close(f);
end;

procedure Init;
var
  i, j, k, x, y: Integer;
  MarkX, MarkY: array[1..max] of Boolean;
begin
  FillChar(matchX, SizeOf(matchX), 0);
  FillChar(matchY, SizeOf(matchY), 0);
  FillChar(matchL, SizeOf(matchL), 0);
  FillChar(matchR, SizeOf(matchR), 0);
  FillChar(MarkX, SizeOf(MarkX), True);
  FillChar(MarkY, SizeOf(MarkY), True);
  for i := 1 to m do
    begin
      x := 0; y := 0;
      for j := 1 to n do
        if MarkX[j] and (i in Sx[j]) then
          begin
            x := j; Break;
          end;
      for j := 1 to n do
        if MarkY[j] and (i in Sy[j]) then
          begin
            y := j; Break;
          end;
      if (x <> 0) and (y <> 0) then
        begin
          matchX[x] := i;
          matchY[y] := i;
          matchL[i] := x;
          matchR[i] := y;
          MarkX[x] := False;
          MarkY[y] := False;
        end;
    end;
end;

procedure Convert(code, data: Integer; var node: TNode);
begin
  Node.code := code;
  Node.data := data;
end;

procedure EmptyQueue;
begin
  last := 0; first := 1;
end;

procedure Push(Pcode: Integer; Pdata: Integer);
begin
  Inc(last);
  with Q[last] do
    begin
      code := Pcode;
      data := Pdata;
    end;
end;

procedure Pop(var Node: TNode);
begin
  Node := Q[first];
  Inc(first);
end;

function BFS1(Node: TNode): Integer;
var
  t: TNode;
  i: Integer;
begin
  case Node.code of
    1:
      for i := 1 to m do
        if (Trace[2, i].code = 0) and (i in Sx[Node.data])
           and (i <> matchX[Node.data]) then
             begin
               Trace[2, i] := Node;
               Push(2, i);
             end;
    2:
      begin
        if (matchL[Node.data] <> 0) and
           (Trace[1, matchL[Node.data]].code = 0) then
          begin
            Trace[1, matchL[Node.Data]] := Node;
            Push(1, matchL[Node.Data]);
          end;
        if (matchL[Node.data] = 0) and
           (Trace[3, Node.data].code = 0) then
           begin
             Trace[3, Node.data] := Node;
             Push(3, Node.data);
           end;
      end;
    3:
      begin
        for i := 1 to n do
          if (Trace[4, i].code = 0) and (Node.data in Sy[i])
             and (i <> matchR[Node.data]) then
               begin
                 Trace[4, i] := Node;
                 if matchY[i] = 0 then
                   begin
                     BFS1 := i;
                     Exit;
                   end;
                 Push(4, i);
               end;
        if (MatchR[Node.data] <> 0) and
           (Trace[2, Node.data].code = 0) then
           begin
             Trace[2, Node.data] := Node;
             Push(2, Node.data);
           end;
      end;
    4:
      if Trace[3, matchY[Node.data]].Code = 0 then
        begin
          Trace[3, matchY[Node.data]] := Node;
          Push(3, matchY[Node.data]);
        end;
  end;
  BFS1 := 0;
end;

function FindPath: Integer;
var
  x: Integer;
  Node: TNode;
  Finish: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  EmptyQueue;
  for x := 1 to n do
    if matchX[x] = 0 then
      begin
        Push(1, x);
        Trace[1, x].Code := -1;
      end;
  while first <= last do
    begin
      Pop(Node);
      Finish := BFS1(Node);
      if Finish <> 0 then
        begin
          FindPath := Finish;
          Exit;
        end;
    end;
  FindPath := 0;
end;

procedure Enlarge(finish: Integer);
var
  Node, Prev: TNode;
begin
  Convert(4, finish, Node);
  repeat
    Prev := Trace[Node.code, Node.data];
    if Prev.Code = -1 then Exit;
    if Node.Code > Prev.Code then
      case Node.Code of
        4:
          begin
            matchY[Node.data] := Prev.data;
            matchR[Prev.data] := Node.data;
          end;
        2:
          begin
            matchL[Node.data] := Prev.data;
            matchX[Prev.data] := Node.data;
          end;
      end;
    Node := Prev;
  until False;
end;

procedure Solve;
var
  i, finish: Integer;
begin
  for i := 1 to n do
    begin
      finish := FindPath;
      if finish <> 0 then Enlarge(finish)
      else Break;
    end;
end;

procedure Result;
var
  f: Text;
  i: Integer;
  mark: array[1..max] of Boolean;
begin
  Assign(f, OutputFile); Rewrite(f);
  FillChar(mark, SizeOf(mark), False);
  for i := 1 to n do
    mark[matchX[i]] := True;
  for i := 1 to m do
    if mark[i] then
      Writeln(f, matchL[i], ' ', matchR[i])
    else
      Writeln(f, '0 0');
  Close(f);
end;

begin
  Start := Time;
  Enter;
  Init;
  Solve;
  Result;
  Writeln((Time - Start) / 18.2:1:4, '(s)');
end.

3
2 3
3
1
2
1 2 3
2 3