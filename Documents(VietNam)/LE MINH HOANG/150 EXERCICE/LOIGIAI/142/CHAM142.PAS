program Cham142;
uses crt;
const
  InputFile: string  = 'CARGO.IN';
  OutputFile = 'CARGO.OUT';
  Key: array['0'..'9'] of LongInt =
  (
  5497,
  23,
  34,
  492,
  136,
  86,
  20,
  174,
  3576,
  2
  );
  max = 100;
  dx: array[1..4] of LongInt = (0, 0, -1, 1);
  dy: array[1..4] of LongInt = (-1, 1, 0, 0);
var
  map: array[0..max + 1, 0..max + 1] of Char;
  m, n, c, testres, res: LongInt;
  xd, yd, xs, ys, xr, yr: LongInt;
  ch: Char;
  f: Text;

procedure Enter;
var
  f: Text;
  i, j: LongInt;
begin
  FillChar(map, SizeOf(map), '#');
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n, c);
  for i := 1 to m do
    begin
      for j := 1 to n do
        begin
          Read(f, map[i, j]);
          case map[i, j] of
            '*': begin
                   xr := i; yr := j;
                   map[i, j] := '.';
                 end;
            '@': begin
                   xd := i; yd := j;
                   map[i, j] := '.';
                 end;
            '$': begin
                   xs := i; ys := j;
                 end;
          end;
        end;
      Readln(f);
    end;
  Close(f);
end;

procedure Correct;
begin
   Writeln;
   Writeln('            Ban co 1 diem');
   Writeln;
   Writeln('            $$$$$$$$$$$$$$$$$$$$$$$$$$');
   Writeln('            $$  CORRECT ! CORRECT   $$');
   wRITELN('            $$$$$$$$$$$$$$$$$$$$$$$$$$');
   Close(f);
   ReadKey;
   Halt;
end;

procedure Wrong;
begin
   Writeln;
   Writeln('            Ban co 0 diem');
   Writeln(#7);
   Writeln('            ??????????????????????????');
   Writeln('            ??  ERROR   !  ERROR    ??');
   wRITELN('            ??????????????????????????');
   Close(f);
   ReadKey;
   Halt;
end;

procedure  AskTest;
begin
  Clrscr;
  Writeln('                             142. CARGO');
  Writeln('                             ßßßßßßßßßß');
    Write('                             CARGO.IN');
  ch := ReadKey;
  Writeln(ch); Writeln;
  InputFile := InputFile + ch;
end;

function GetDirection(xs, ys, xr, yr: Integer): LongInt;
var
  d, t: Integer;
begin
  d := 0;
  for t := 1 to 4 do
    if (xs + dx[t] = xr) and (ys + dy[t] = yr) then
      begin
        d := t; Break;
      end;
   GetDirection := d;
end;

procedure Push;
var
  d: Integer;
begin
  d := GetDirection(xs, ys, xr, yr);
  if d = 0 then
    begin
      Writeln;
      Writeln('Robot (', xr, ', ', yr, ') khong day duoc Cargo (',
                xs, ', ', ys, ')');
      Wrong;
    end;
  map[xs, ys] := '.';
  while map[xs - dx[d], ys - dy[d]] = '.' do
    begin
      xs :=xs - dx[d]; ys := ys - dy[d];
    end;
  map[xs, ys] := '$';
  Testres := testres + c;
end;

procedure Pull;
var
  d: Integer;
begin
  d := GetDirection(xs, ys, xr, yr);
  if d = 0 then
    begin
      Writeln;
      Writeln('Robot (', xr, ', ', yr, ') khong day duoc Cargo (',
                xs, ', ', ys, ')');
      Wrong;
    end;
  map[xs, ys] := '.';
  if map[xr + dx[d], yr + dy[d]] <> '.' then
    begin
      Writeln('Robot (', xr, ', ', yr, ') khong duoc di sang (',
                xr + dx[d], ', ', yr + dy[d], ')');
      Wrong;
    end;
  xr := xr + dx[d]; yr := yr + dy[d];
  xs := xs + dx[d]; ys := ys + dy[d];
  map[xs, ys] := '$';
  Testres := testres + C;
end;

begin
  AskTest;
  Enter;
  Assign(f, OutputFile); Reset(f);
  Readln(f, res);
  Writeln('So cong can thuc hien:');
  Writeln('  + Dap an   : ', Key[ch]);
  Writeln('  + Hoc sinh : ', res);
  if res > key[ch] then Wrong;
  Writeln('Kiem tra duong di');
  testres := 0;
  while not SeekEof(f) do
    begin
      Read(f, ch); Write(ch);
      if ch in ['L', 'R', 'U', 'D'] then
        begin
          case ch of
            'L': dec(yr);
            'R': Inc(yr);
            'U': dec(xr);
            'D': Inc(xr);
          end;
          if map[xr, yr] <> '.' then
            begin
              Writeln('Di vao o (',xr, ', ', yr, ') = ', map[xr, yr]);
              Wrong;
            end;
          Inc(testres);
        end;
      case ch of
        '+': Push;
        '-': Pull;
        'L','R','U','D':;
        else
          begin
            Writeln('Ky tu la!');
            Wrong;
          end;
      end;
    end;
  Writeln;
  Writeln('Vi tri kien hang sau cac thao tac: ');
  Writeln('  + Yeu cau  : (', xd, ', ', yd, ')');
  Writeln('  + Ket qua  : (', xs, ', ', ys, ')');
  if (xd <> xs) or (yd <> ys) then wrong;
  Writeln('So cong tren thuc te: ', Testres);
  if Testres <> res then
    begin
      Writeln('Tien hau bat nhat!');
      Wrong;
    end;
  Correct;
end.


