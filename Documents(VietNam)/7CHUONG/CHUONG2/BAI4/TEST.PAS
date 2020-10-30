{test bai TRONGCAY.DOC}
uses  crt ;
const
  fi :string= 'C';
  fo = 'CAY.OUT';
var
  a, b: array[1..100, 1..100] of char;
  f: text;
  i, j, m, n: byte;
  s: integer;
  x : char ;
begin
  clrscr ;
  write ( '                 Ban Cham Test   CAY.IN' ) ;
  x := readkey ;writeln ( x ) ;delay ( 300 ) ;fi := fi + x+'.' ;
  assign(f, fi);
  reset(f);
  readln(f, m, n);
  for i := 1 to m do
  begin
    for j := 1 to n do read(f, a[i, j]);
    readln(f);
  end;
  close(f);
  assign(f, fo);
  reset(f);
  for i := 1 to m do
  begin
    for j := 1 to n do read(f, b[i, j]);
    readln(f);
  end;
  close(f);
  for i := 1 to m do
    for j := 1 to n do
    if a[i, j] = '0' then
    begin
      if b[i, j] <> '0' then
      begin
        writeln('Error: vi tri ', i, ', ', j, ' khong duoc co cay!');
        writeln('Diem: 0');
        halt;
      end;
    end else
      if b[i, j] = '0' then
      begin
        writeln('Error: vi tri ', i, ', ', j, ' can phai co cay!');
        writeln('Diem: 0');
        halt;
      end;
  {kiem tra dong}
  for i := 1 to m do
  begin
    s := 0;
    for j := 1 to n do
    begin
      if b[i, j] = '1' then inc(s);
      if b[i, j] = '2' then dec(s);
    end;
    s := abs(s);
    if s > 1 then
    begin
      writeln('Error: dong ', i, ' (chenh nhau ', s, ')');
      writeln('Diem: 0');
      halt;
    end;
  end;
  {kiem tra cot}
  for j := 1 to n do
  begin
    s := 0;
    for i := 1 to m do
    begin
      if b[i, j] = '1' then inc(s);
      if b[i, j] = '2' then dec(s);
    end;
    s := abs(s);
    if s > 1 then
    begin
      writeln('Error: cot ', j, ' (chenh nhau ', s, ')');
      writeln('Diem: 0');
      halt;
    end;
  end;
  {kiem tra toan bang}
  s := 0;
  for i := 1 to m do
    for j := 1 to n do
    begin
      if b[i, j] = '1' then inc(s);
      if b[i, j] = '2' then dec(s);
    end;
  s := abs(s);
  if s > 1 then
  begin
    writeln('Error: toan bang (chenh nhau ', s, ')');
      writeln('Diem: 0');
      halt;
  end;
  writeln('OK');
  writeln('Diem: 1');
  readln ;
end.
