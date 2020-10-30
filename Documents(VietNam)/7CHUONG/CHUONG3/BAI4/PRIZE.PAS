program wizard;
uses crt;
const
  fin: string = 'PRIZE.IN1';
  fou: string = 'PRIZE.OUT';
var
  z, i, j, k, l, p, q, n, m, best: longint;
  a: array [1..8, 1..8, 1..8, 1..8] of longint;

begin
  assign(input, fin);
  reset(input);
  assign(output, fou);
  rewrite(output);

  read(n, m);

  { Gan cac phan tu cua mang a la -1 }
  fillchar(a, sizeof(a), $ff);
  { Начальные значения }
  for i := 1 to 8 do
    for j := 1 to 8 do
      for k := 1 to 8 do
        for l := 1 to 8 do
        begin
          if abs((i-k)*(j-l)) = 2 then
            a[i][j][k][l] := 1;
          if (abs(i-k) + abs(j-l)) = 0 then
            a[i][j][k][l] := 0;
        end;

  { Алгоритм Флойда }
  for p := 1 to 8 do
    for q := 1 to 8 do
      for i := 1 to 8 do
        for j := 1 to 8 do
          for k := 1 to 8 do
            for l := 1 to 8 do
              if (a[i][j][p][q] <> -1) and
                 (a[p][q][k][l] <> -1) and
                 ((a[i][j][p][q] + a[p][q][k][l] < a[i][j][k][l]) or
                  (a[i][j][k][l] = -1)) then
              begin
                a[i][j][k][l] := a[i][j][p][q] + a[p][q][k][l];
              end;

  { Ищем лучшую клетку }
  best := 0;
  for i := 1 to 8 do
  begin
    for j := 1 to 8 do
    begin
      p := 0;
      for k := 1 to 8 do
        for l := 1 to 8 do
          if a[i][j][k][l] <= n then
            p := p + (1 shl (n - a[i][j][k][l]));
      if (p > best) and (p <= m) then
        best := p;
    end;
  end;

  { Выводим число }
  writeln(best);

  { Выводим все клетки }
  for i := 1 to 8 do
    for j := 1 to 8 do
    begin
      p := 0;
      for k := 1 to 8 do
        for l := 1 to 8 do
          if a[i][j][k][l] <= n then
            p := p + (1 shl (n - a[i][j][k][l]));
      if (p = best) then
        write(chr(ord('a') + i - 1), j, ' ');
    end;

  close(input);
  close(output);
end.

Answers to all tests
Ans to Test 1
6
a3 a4 a5 a6 b2 b7 c1 c8 d1 d8 e1 e8 f1 f8 g2 g7 h3 h4 h5 h6
Ans to Test 2
10
c3 c4 c5 c6 d3 d4 d5 d6 e3 e4 e5 e6 f3 f4 f5 f6
Ans to Test 3
17
a1 a8 h1 h8
Ans to Test 4
36
b4 b5 d2 d7 e2 e7 g4 g5
Ans to Test 5
0
Ans to Test 6
196
b3 b6 c2 c7 f2 f7 g3 g6
Ans to Test 7
207
b4 b5 d2 d7 e2 e7 g4 g5
Ans to Test 8
537
a1 a8 h1 h8
Ans to Test 9
900
c4 c5 d3 d6 e3 e6 f4 f5

Ans to Test 0
1
a1 a2 a3 a4 a5 a6 a7 a8 b1 b2 b3 b4 b5 b6 b7 b8 c1 c2 c3 c4 c5 c6 c7 c8 d1 d2 d3 d4 d5 d6 d7 d8 e1 e2 e3 e4 e5 e6 e7 e8 f1 f2 f3 f4 f5 f6 f7 f8 g1 g2 g3 g4 g5 g6 g7 g8 h1 h2 h3 h4 h5 h6 h7 h8

Ans to Test a
9984
a2 a7 b1 b8 g1 g8 h2 h7
Ans to Test b
15168
d4 d5 e4 e5
Ans to Test c
8798208
a1 a8 h1 h8

Ans to Test d
14745600
c4 c5 d3 d6 e3 e6 f4 f5
Ans to Test e
0
Ans to Test f
471859200
c4 c5 d3 d6 e3 e6 f4 f5