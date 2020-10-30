program Network;
const
  InputFile  = 'NREDUCE.INP';
  OutputFile = 'NREDUCE.OUT';
  max = 500;
  maxm = 10000;
type
  TEdge = record
    u, v: Integer;
    w: ShortInt;
  end;
var
  n, m, nE, SavenE: Integer;
  Lab, SaveLab: array[1..max] of Integer;
  EList: array[1..maxm] of TEdge;
  solution: Boolean;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for i := 1 to m do
    with EList[i] do Readln(f, u, v, w);
  Close(f);
end;

procedure InitForest;
var
  i: Integer;
begin
  for i := 1 to n do Lab[i] := -1;
end;

function GetRoot(u: Integer): Integer;
begin
  while Lab[u] >= 0 do u := Lab[u];
  GetRoot := u;
end;

procedure Union(r1, r2: Integer);
var
  x: Integer;
begin
  x := Lab[r1] + Lab[r2];
  if Lab[r1] > Lab[r2] then
    begin
      Lab[r1] := r2;
      Lab[r2] := x;
    end
  else
    begin
      Lab[r2] := r1;
      Lab[r1] := x;
    end;
end;

{Tim rung khung doi voi cac kenh loai code}
function Kruskal(code: Integer): Boolean;
var
  i: Integer;
  r1, r2: Integer;
begin
  for i := 1 to m do
    with EList[i] do
      if w = code then
        begin
          r1 := GetRoot(u); r2 := GetRoot(v);
          if r1 <> r2 then
            begin
              w := -w;  {Mark}
              Inc(nE);
              if nE = n - 1 then
                begin
                  Kruskal := True;
                  Exit;
                end;
              Union(r1, r2);
            end;
        end;
  Kruskal := False;
end;

procedure Result;
var
  f: Text;
  i: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  if not Solution then Writeln(f, -1)
  else
    begin
      Writeln(f, m - (n + n - 2 - SavenE));
      for i := 1 to m do
        if EList[i].w > 0 then Writeln(f, i);
    end;
  Close(f);
end;

begin
  Enter;
  InitForest;
  nE := 0;
  Solution := Kruskal(3); {Dung rung khung loai 3}
  if not Solution then {Neu rung chua phai la cay khung}
    begin
      SavenE := nE; SaveLab := Lab;  {Save}
      {Chap them cac kenh loai 1 de duoc rung khung loai 1&3}
      Solution := Kruskal(1);
      nE := SavenE; Lab := SaveLab;  {Restore}
      {Sau khi phuc hoi lai rung khung loai 3,
       Chap them cac kenh loai 2 de duoc rung khung loai 2&3}
      Solution := Solution and Kruskal(2);
    end;
  Result;
end.
5 7
1 2 3
2 3 3
3 4 3
5 3 2
5 4 1
5 2 2
1 5 1