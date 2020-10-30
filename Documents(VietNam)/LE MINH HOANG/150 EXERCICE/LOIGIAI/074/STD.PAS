{$M 65520 0 655360}
program CutVertices;
const
 InputFile: String = '.INP';
 OutputFile: String = '.OUT';
 max = 1000;
 maxM = 10000;
type
 TEdgeList = array[1..maxM, 1..2] of Integer;
var
 adj: array[1..2 * maxM] of Integer;
 head, AdjCount: array[1..max + 1] of Integer;
 e: ^TEdgeList;
 Numbering, Low, nC: array[1..max] of Integer;
 Mark: array[1..max] of Boolean;
 n, m, Count, nV, t: Integer;
 s: String[2];
 Time: LongInt absolute 0:$46C;
 Start: LongInt;

procedure Enter;
var
 f: Text;
 u, v, i: Integer;
begin
 New(e);
 FillChar(AdjCount, SizeOf(AdjCount), 0);
 Assign(f, InputFile); Reset(f);
 Readln(f, n, m);
 for i := 1 to m do
  begin
   Readln(f, u, v);
   Inc(AdjCount[u]); Inc(AdjCount[v]);
   e^[i, 1] := u; e^[i, 2] := v;
  end;
 Close(f);
 head[1] := 1;
 for i := 2 to n + 1 do
  head[i] := head[i - 1] + AdjCount[i - 1];
 FillChar(AdjCount, SizeOf(AdjCount), 0);
 for i := 1 to m do
  begin
   u := e^[i, 1]; v := e^[i, 2];
   adj[head[u] + AdjCount[u]] := v; Inc(AdjCount[u]);
   adj[head[v] + AdjCount[v]] := u; Inc(AdjCount[v]);
  end;
 Dispose(e);
end;

procedure Visit(u: Integer);
var
 MaxBack, iv, v: Integer;
begin
 Inc(Count); Numbering[u] := Count;
 Low[u] := Numbering[u];
 MaxBack := 0;
 for iv := head[u] to head[u + 1] - 1 do
  begin
   v := adj[iv];
   if Numbering[v] = 0 then
    begin
     Inc(nC[u]);
     Visit(v);
     if Low[u] > Low[v] then Low[u] := Low[v];
     if MaxBack < Low[v] then MaxBack := Low[v];
    end
   else
    if Low[u] > Numbering[v] then Low[u] := Numbering[v];
  end;
 Mark[u] := MaxBack >= Numbering[u];
 if Mark[u] then Inc(nV);
end;

procedure Solve;
var
 u: Integer;
begin
 FillChar(Numbering, SizeOf(Numbering), 0);
 FillChar(Mark, SizeOf(Mark), False);
 FillChar(nc, SizeOf(nc), 0);
 Count := 0; nV := 0;
 for u := 1 to n do
  if Numbering[u] = 0 then
   begin
    Visit(u);
    if Mark[u] and (nC[u] < 2) then
     begin
      Mark[u] := False;
      Dec(nV);
     end;
   end;
end;

procedure Result;
var
 f: Text;
 i: Integer;
begin
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, nV);
 for i := 1 to n do
  if Mark[i] then Write(f, i, ' ');
 Close(f);
end;

begin
 Start := Time;
 for t := 0 to 19 do
  begin
   Writeln(t);
   Str(t, s); if t < 10 then s := '0' + s;
   InputFile := s + '.INP';
   OutputFile := s + '.OUT';
   Enter;
   Solve;
   Result;
  end;
 Writeln('Time = ', (Time - Start)/18.2:1:4);
end.

13 14
1 3
3 6
6 4
4 1
4 2
2 5
5 7
7 4
6 9
9 8
8 4
8 10
11 12
5 12

13 16
1 2
1 3
1 6
1 7
3 7
4 5
4 6
5 6
5 7
7 8
7 10
7 12
8 9
10 11
10 12
10 13
