{test bai toan xo so}
const
  maxN = 100;        {so nguoi toi da}
  maxM = 50;         {so o toi da}
  maxK = 10;         {so o chon toi da}
type
  levelpers = array[1..maxN] of byte;  {diem tung nguoi}
  ans = array[1..maxK] of byte;        {cach chon}
var
  answ: array[1..maxN] of ans;
  level: levelpers;
  n, m, k: byte;      {n: so nguoi, m: so o, k: so o chon}
  p: set of byte;     {to hop duoc duyet}
  np: word;           {so dap an}
  f: text;
  name: string;

  procedure ReadInput;
  var i, j: byte;
  begin
    writeln;
    write('File input: '); readln(name);
    if name = '' then halt;
    assign(f, name); reset(f);
    readln(f, n, m, k);
    for i := 1 to n do
    begin
      for j := 1 to k do read(f, answ[i][j]);
      readln(f, level[i]);
    end;
    readln(f, np);
    close(f);
    writeln('  so nguoi: ', n, ', so o: ', m,
            ', so o chon: ', k, ', so ket qua: ', np);
  end;

  function Ok: boolean;
  var i, j, s: byte;
  begin
    for i := 1 to n do
    begin
      s := 0;
      for j := 1 to k do
        if answ[i, j] in p then inc(s);
      if s <> level[i] then
      begin
        Ok := false; exit;
      end;
    end;
    Ok := true;
  end;

  procedure Test;
  var i, j, err, tt: byte;
  begin
{    write('File output: '); readln(name);
    if name = '' then halt;}
    name := 'XOSO.OUT';
    assign(f, name); reset(f);
    err := 0; tt := 0;
    while not seekeof(f) do
    begin
      p := [];
      inc(tt); write(tt:3, '.');
      for j := 1 to k do
      begin
        read(f, i); write(i:3); p := p+[i];
      end;
      if Ok then writeln('   Ok')
      else begin
             writeln('   Error'); inc(err);
           end;
    end;
    close(f);
    writeln('Ket qua test:');
    if err = 0 then
      writeln('  cac ket qua deu hop ly')
    else
      writeln('  co ', err, ' ket qua sai');
    write('  so ket qua: ');
    if tt = np then writeln('Ok')
    else
      if tt < np then writeln('thieu (', tt, '/', np, ')')
      else writeln('thua (', tt, '/', np, ')');
  end;

BEGIN
  ReadInput;
  Test;
  readln;
END.