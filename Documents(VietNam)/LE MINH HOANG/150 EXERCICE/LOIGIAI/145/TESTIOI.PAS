program TestIOI;
uses crt;
const
  InputFile: string = 'IOI.IN';
  OutputFile = 'IOI.OUT';
  res: array['0'..'9'] of LongInt =
  (
  961916,
  77,
  144,
  1373,
  69472,
  169733,
  262853,
  385178,
  654480,
  854115
  );
  max = 102;
  maxK = 1002;
var
  ch: Char;
  f: Text;
  Kind: array[1..max * max + max] of Integer;
  c: array[1..max, 1..maxK] of LongInt;
  FreeMan: array[1..max] of Boolean;
  n, k: Integer;
  HSRes, Res2: LongInt;

procedure AskTest;
begin
  Clrscr;
  Writeln('                                 IOI 3003');
  Writeln('                                 ฿฿฿฿฿฿฿฿');
    Write('                                  IOI.IN'); ch := ReadKey;
  Writeln(ch);
  InputFile := InputFile + ch;
end;

procedure Halt;
begin
  {$I-}
  Close(f); if IOResult = 0 then;
  {$I+}
  System.Halt;
end;

procedure Correct;
begin
  Writeln;
  Writeln('                     ษออออออออออออออออออออป');
  Writeln('                     บ  CORRECT! CORRECT! บ');
  Writeln('                     ศออออออออออออออออออออผ');
  ReadKey;
  Halt;
end;

procedure Wrong;
begin
  Writeln(#7);
  Writeln('                     ษออออออออออออออออออออป');
  Writeln('                     บ    ERROR! ERROR!   บ');
  Writeln('                     ศออออออออออออออออออออผ');
  ReadKey;
  Halt;
end;

procedure enter;
var
  f: Text;
  i, x, y: INteger;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, k);
  for i := 1 to n * n + n do Read(f, Kind[i]);
  Readln(f);
  FillChar(c, SizeOf(c), 0);
  while not SeekEof(f) do
    Readln(f, x, y, c[x, y]);
  Close(f);
end;

procedure Test;
var
  i, j, k, h, t: Integer;
  exam: array[1..max] of Integer;
begin
  Assign(f, OutputFile); Reset(f);
  Readln(f, HSRes);
  Writeln('Kiem tra tong diem toan doan:');
  Writeln('  + Dap an   :', res[ch]);
  Writeln('  + Hoc sinh :', HSRes);
  Delay(1000);
  if HSRes < res[ch] then
    begin
      Writeln('Khong toi uu!');
      Wrong;
    end;
  FillChar(FreeMan, SizeOf(FreeMan), False);
  Res2 := 0;
  for i := 1 to n + 1 do
    begin
      Writeln('Kiem tra ngay thu ', i, '...');
      FillChar(exam, SizeOf(exam), 0);
      for j := 1 to n do
        begin
          k := (i - 1) * n + j;
          Readln(f, t);
          if (t < 1) or (t > n + 1) then
            begin
              Writeln('So hieu hoc sinh sai = ', t);
              Wrong;
            end;
          if Exam[t] <> 0 then
            begin
              Writeln('Hoc sinh ', t, ' duoc giao 2 bai');
              Wrong;
            end;
          Exam[t] := j;
          Res2 := Res2 + c[t, Kind[k]];
        end;
      for h := 1 to n + 1 do
        if Exam[h] = 0 then FreeMan[h] := True;
    end;
  Writeln('Chi phi tinh theo lich: ', res2);
  if res2 <> HSRes then
    begin
      Writeln('Tien hau bat nhat');
      Wrong;
    end;
  for h := 1 to n + 1 do
    if not FreeMan[h] then
      begin
        Writeln('Hoc sinh ', h, ' khong duoc nghi ngay nao!');
        Wrong;
      end;
  Correct;
end;

begin
  AskTest;
  Enter;
  Test;
end.

