{giai bai ROBOT}
uses Crt;
type
  st9 = string[9];
var
  bd: array[1..9] of st9;
  s, s0: st9;
  kq, b: array[1..9] of byte;  {day bien doi}
  Min: integer;
  stop: boolean;
  ch: char;
  f: text;
  name: string;

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

  procedure Nhap;
  var i: byte;
  begin
    clrscr;
    write('Doc file: ');
    readln(name);
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
  end;

  procedure KhoiTao;
  var i: integer;
  begin
    for i := 1 to 9 do b[i] := 0;
    kq := b;
    stop := false; s := s0;
    Min := MaxInt;
  end;

  procedure Select;
  var j: byte;
      v: integer;
  begin
    v := 0;
    for j := 1 to 9 do v := v+b[j]*length(bd[j]);
    if Min > v then
    begin
      kq := b;
      Min := v;
    end;
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

  procedure InKq;
  var i, j, k: byte;
  begin
    write('Ghi ket qua len file: '); readln(name);
    assign(f, name); rewrite(f);
    if Min < MaxInt then
    begin
      for i := 1 to 9 do
        for j := 1 to kq[i] do write(f, i);
    end else write(f, '0');
    close(f);
  end;

BEGIN
  repeat
    Nhap; KhoiTao;
    while not stop do Sinh;
    InKq;
    write('Go Esc de ket thuc, go Enter de lap lai ... ');
    ch := readkey;
  until ch = #27;
END.
