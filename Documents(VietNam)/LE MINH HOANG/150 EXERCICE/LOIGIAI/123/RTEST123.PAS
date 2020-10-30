program RollingCube;
uses crt;
const
  InputFile  = 'ROLL.IN7';
  OutputFile = 'ROLL.OUT';
  max = 80;
  LeftCode: array[1..6, 1..6] of Byte =
  (
  (0, 4, 2, 5, 3, 0),
  (3, 0, 6, 1, 0, 4),
  (5, 1, 0, 0, 6, 2),
  (2, 6, 0, 0, 1, 5),
  (4, 0, 1, 6, 0, 3),
  (0, 3, 5, 2, 4, 0)
  );
var
  map: array[1..max, 1..max] of Byte;
  c, m, n, startX, startY: Integer;

function Up(sk, sx, sy: Integer; var rk, rx, ry: Integer): Integer;
var
  Face: Integer;
begin
  Face := sk;
  rx := sx - 1; ry := sy;
  if (rx = 0) or not (map[rx, ry] in [0, Face]) then Up := -1
  else
    begin
      rk := 7 - map[sx, sy];
      Up := Face;
    end;
end;

function Down(sk, sx, sy: Integer; var rk, rx, ry: Integer): Integer;
var
  Face: Integer;
begin
  Face := 7 - sk;
  rx := sx + 1; ry := sy;
  if (rx > m) or not (map[rx, ry] in [0, Face]) then Down := -1
  else
    begin
      rk := map[sx, sy];
      Down := Face;
    end;
end;

function Left(sk, sx, sy: Integer; var rk, rx, ry: Integer): Integer;
var
  Face: Integer;
begin
  Face := LeftCode[map[sx, sy], sk];
  rx := sx; ry := sy - 1;
  if (ry = 0) or not (map[rx, ry] in [0, Face]) then Left := -1
  else
    begin
      rk := sk;
      Left := Face;
    end;
end;

function Right(sk, sx, sy: Integer; var rk, rx, ry: Integer): Integer;
var
  Face: Integer;
begin
  Face := 7 - LeftCode[map[sx, sy], sk];
  rx := sx; ry := sy + 1;
  if (ry > n) or not (map[rx, ry] in [0, Face]) then Right := -1
  else
    begin
      rk := sk;
      Right := Face;
    end;
end;

procedure Init;
begin
  Write('m, n, x, y: '); Readln(m, n, startX, startY);
  FillChar(map, SizeOf(map), 0);
  map[startX, startY] := 6;
end;

procedure Try;
const
  s: string = 'UDLR';
var
  V, d, px, py, pk, x, y, k: Integer;
  i, j: Integer;

  procedure Go(d: Integer);
  begin
    case d of
      1: V := Up(pk, px, py, k, x, y);
      2: V := Down(pk, px, py, k, x, y);
      3: V := Left(pk, px, py, k, x, y);
      4: V := Right(pk, px, py, k, x, y);
    end;
    if V = -1 then Exit;
    Write(s[d]);
    if map[x, y] = 0 then map[x, y] := V;
    pk := k; px := x; py := y;
  end;

begin
  pk := 2;
  px := startX;
  py := startY;
  i := 2;
  repeat
    d := Random(4) + 1;
    Go(d);
  until (px = 1) or (px = m) or (py = 1) or (py = n);
  Writeln;
end;

procedure WriteFile;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, InputFile); Rewrite(f);
  Writeln(f, m, ' ', n, ' ', startX, ' ', startY);
  for i := 1 to m do
    begin
      for j := 1 to n do
        if (map[i, j] = 0) and (Random(6) = 1) then map[i, j] := Random(7);
      for j := 1 to n do Write(f, map[i, j], ' ');
      Writeln(f);
    end;
  Close(f);
end;

begin
  Init;
  for c := 1 to 30 do Try;
  WriteFile;
end.
(*
procedure Try1;
const
  s: string = 'UDLR';
var
  V, d, px, py, pk, x, y, k: Integer;
  i, j: Integer;

  function Go(d: Integer): Boolean;
  begin
    case d of
      1: V := Up(pk, px, py, k, x, y);
      2: V := Down(pk, px, py, k, x, y);
      3: V := Left(pk, px, py, k, x, y);
      4: V := Right(pk, px, py, k, x, y);
    end;
    Go := False;
    if V = -1 then Exit;
    Write(s[d]);
    if map[x, y] = 0 then map[x, y] := V;
    pk := k; px := x; py := y;
    Go := (px = 1) or (px = m) or (py = 1) or (py = n)
  end;

begin
  {79 79 2 2}
  pk := 2;
  px := startX;
  py := startY;
  repeat
    for j := 3 to 78 do
      if Go(4) then Exit;
    if Go(2) then Exit;
    if Go(2) then Exit;
    for j := 78 downto 3 do
      if Go(3) then Exit;
    if Go(2) then Exit;
    if Go(2) then Exit;
  until False;
  Writeln;
end;

procedure Try1;
const
  s: string = 'UDLR';
var
  V, d, px, py, pk, x, y, k: Integer;
  i, j: Integer;

  function Go(d: Integer): Boolean;
  begin
    case d of
      1: V := Up(pk, px, py, k, x, y);
      2: V := Down(pk, px, py, k, x, y);
      3: V := Left(pk, px, py, k, x, y);
      4: V := Right(pk, px, py, k, x, y);
    end;
    Go := False;
    if V = -1 then Exit;
    Write(s[d]);
    if map[x, y] = 0 then map[x, y] := V;
    pk := k; px := x; py := y;
    Go := (px = 1) or (px = m) or (py = 1) or (py = n)
  end;

begin
  {80 80 40 40}
  pk := 2;
  px := startX;
  py := startY;
  i := 2;
  repeat
    for j := 1 to i do
      if Go(2) then Exit;
    for j := 1 to i do
      if Go(3) then Exit;
    for j := 1 to i + 2 do
      if Go(1) then Exit;
    for j := 1 to i + 2 do
      if Go(4) then Exit;
    Inc(i, 4);
  until False;
  Writeln;
end;
