uses Crt;
type
  st9 = string[9];
var
  bd: array[1..9] of st9;
  s, s0: st9;
  b: array[1..9] of byte;  {day bien doi}
  Min, ttmin: integer;
  stop, yes: boolean;
  ch: char;
  t: string;

  function Config(s: st9; m: byte): st9;
  {tra lai trang thai cac phong nhan duoc tu trang thai s
  va phep bien doi m}
  var i, j: byte;
      p: st9;
  begin
    p := bd[m];
    for i := 1 to length(p) do
    begin
      j := ord(p[i])-48;
      s[j] := succ(s[j]);
      if s[j] = '3' then s[j] := '0';
    end;
    Config := s;
  end;

  function Convert(s: st9): st9;
  var ss: string[3];
      i: byte;
  begin
    ss := 'TXV';
    for i := 1 to 9 do
      s[i] := ss[ord(s[i])-47];
    Convert := s;
  end;

  procedure DocFile;
  var f: text;
   name: string;
   i: byte;
  begin
    clrscr;
    write('Doc file du lieu: ');
    readln(name);
    name:='c:\hung\robot\'+name;
    assign(f, name);
    reset(f);
    for i := 1 to 9 do readln(f, bd[i]);
    readln(f, s);
    close(f);
    writeln('Cac day bien doi:');
    for i := 1 to 9 do writeln(i, '. ', bd[i]);
    s0 := '';
    for i := 1 to length(s) do
      s0 := s0+chr(pos(s[i],'TXV')+47);
    writeln('Trang thai ban dau: ', s); {, ' --> ', s0);}
    writeln('********************************************');
    write('Doc file ket qua: '); readln(name);
    assign(f, name);
    reset(f);
    readln(f, t);
    writeln('  ', t);
    writeln('********************************************');
    close(f);
  end;

  procedure KhoiTao;
  var i: integer;
  begin
    for i := 1 to 9 do b[i] := 0;
    stop := false; s := s0;
    Min := MaxInt;
  end;

  procedure Select;
  var j: byte;
      v: integer;
  begin
    v := 0;
    for j := 1 to 9 do v := v+b[j]*length(bd[j]);
    if Min > v then Min := v;
  end;

  procedure Sinh;
  var i: byte;
      v: integer;
  begin
    if s = '000000000' then Select;
    i := 9;
    while (i > 0) and (b[i] = 2) do
    begin
      s := Config(s, i);
      b[i] := 0;
      dec(i);
    end;
    if i > 0 then
    begin
      s := Config(s, i);
      inc(b[i]);
    end else stop := true;
  end;

  procedure KiemTra;
  var i, j: byte;
  begin
    s := s0;
    ttmin := 0;
    for i := 1 to length(t) do
    begin
      j := ord(t[i])-48;
      {write(s, ' -(', j, ')-> ');}
      s := Config(s, j);
      ttmin := ttmin+length(bd[j]);
    end;
    {writeln(s);}
    writeln('  Min = ', ttmin);
    write('  ', convert(s));
    if s = '000000000' then writeln('  Valid')
    else begin
           writeln('  Invalid');
           ch := readkey;
           halt;
         end;
    s := s0;
  end;

BEGIN
  DocFile;
  KhoiTao;
  writeln('Ket qua kiem tra:');
  if t <> '0' then KiemTra;
  while not stop do Sinh;
  yes := Min < MaxInt;
  if t = '0' then
  begin
    if not yes then writeln('  Valid')
    else writeln('  Invalid');
    ch := readkey;
    halt;
  end
  else
    if Min < ttmin then writeln('  No optimal')
    else writeln('  Optimal');
  ch := readkey;
END.
