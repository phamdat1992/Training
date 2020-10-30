uses crt;
const
  max = 13;
  name = 'disk.OUT';
  k: array['0'..'9'] of byte = (4, 5, 6, 7, 8, 9, 10, 11, 12, 13);
  dapan: array['0'..'9'] of longint =
         (43, 119, 327, 895, 2447, 6687, 18271, 49919, 136383, 372607);
type
  arr = array[0..max] of byte;
  state = record
            top: byte;
            disk: arr;
          end;
var
  f: text;
  coc: array[1..3] of state;
  n, i, j: byte;
  count: longint;
  ch: char;

BEGIN
  clrscr;
  write('TEST '); ch := readkey;
  writeln(ch);
  n := k[ch];
  {khoi dong cac coc}
  fillchar(coc, sizeof(coc), 0);
  with coc[1] do
  begin
    top := n;
    for i := 1 to n do disk[i] := i;
  end;
  count := 0;
  assign(f, name); reset(f);
  while not eof(f) do
  begin
    inc(count);
    readln(f, i, j);
    if j <> i mod 3+1 then
    begin
      writeln('Error at line ', count, ': coc ', j,
              ' khong nam canh coc ', i);
      readln; halt;
    end;
    if coc[i].top = 0 then
    begin
      writeln('Error at line ', count, ': coc ', i,
              ' khong co dia');
      readln; halt;
    end;
    if coc[j].disk[coc[j].top] >= coc[i].disk[coc[i].top] then
    begin
      writeln('Error at line ', count, ': dia khong chuyen duoc');
      readln; halt;
    end;
    {cap nhat trang thai coc i va j}
    with coc[j] do
    begin
      inc(top);
      disk[top] := coc[i].disk[coc[i].top];
    end;
    dec(coc[i].top);
  end;
  close(f);
  writeln('Tong so buoc chuyen: ', count, ' (dap an ', dapan[ch], ')');
  write('Ket qua chuyen: ');
  if coc[2].top < n then
    writeln('Error: chua chuyen xong!')
  else
    if count > dapan[ch] then
      writeln('Chua toi uu')
    else
    begin
      writeln('OK');
      if count < dapan[ch] then writeln('Extra: tot hon dap an!');
    end;
  readln;
END.
