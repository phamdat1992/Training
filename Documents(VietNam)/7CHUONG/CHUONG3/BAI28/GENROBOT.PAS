{sinh du lieu cho bai ROBOT}
uses Crt;
type
  st9 = string[9];
var
  bd: array[1..9] of st9;
  s, s0: st9;
  kq, b: array[1..9] of byte;  {day bien doi}
  Min, tt: integer;
  stop: boolean;
  ch: char;

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
  var f: text;
   name: string;
   i: byte;
  begin
    clrscr;
    write('Doc file: ');
    readln(name);
    if name = '' then
    begin
      bd[1] := '1245';
      bd[2] := '123';
      bd[3] := '2356';
      bd[4] := '147';
      bd[5] := '13579';
      bd[6] := '369';
      bd[7] := '4578';
      bd[8] := '789';
      bd[9] := '5689';
    end else
    begin
      assign(f, name);
      reset(f);
      for i := 1 to 9 do readln(f, bd[i]);
      close(f);
    end;
    writeln('Cac day bien doi:');
    for i := 1 to 9 do writeln(i, '. ', bd[i]);
    window(1, 12, 80, 25);
  end;

  procedure NgauNhien;
  var i: byte;
  begin
    randomize;
    s := '';
    for i := 1 to 9 do
      s := s+chr(random(3)+48);
    writeln('Trang thai ban dau = ', s);
  end;

  procedure KhoiTao;
  var i: integer;
  begin
    clrscr;
    write('Trang thai ban dau (go rong de sinh ngau nhien): ');
    readln(s);
    if s = '' then NgauNhien;
    for i := 1 to 9 do b[i] := 0;
    kq := b;
    stop := false; s0 := s;
    Min := MaxInt; tt := 0;
  end;

  procedure Select;
  var j, k: byte;
      v: integer;
  begin
    inc(tt);
    v := 0; k := 0;
    for j := 1 to 9 do
    begin
      k := k+b[j];
      v := v+b[j]*length(bd[j]);
    end;
    writeln(tt:3, ') ', v:3, ' (', k, ')');
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
    if Min < MaxInt then
    begin
      write('Day bien doi tim duoc = ');
      k := 0;
      for i := 1 to 9 do
      begin
        inc(k, kq[i]);
        for j := 1 to kq[i] do write(i);
      end;
      writeln(' (', k, ' buoc)');
      writeln('Min = ', Min);
    end else writeln('Khong bien doi duoc');
  end;

  procedure KiemTra;
  var i, j: byte;
  begin
    s := s0;
    for i := 1 to 9 do
      for j := 1 to kq[i] do
      begin
        write(s, ' -(', i, ')-> ');
        s := Config(s, i);
      end;
    writeln(s);
  end;

  procedure Thu;
  var i, j: byte;
      t: st9;
  begin
    clrscr;
    bd[1] := '1245';
    bd[2] := '123';
    bd[3] := '2356';
    bd[4] := '147';
    bd[5] := '13579';
    bd[6] := '369';
    bd[7] := '4578';
    bd[8] := '789';
    bd[9] := '5689';
    writeln('Cac day bien doi:');
    for i := 1 to 9 do writeln(i, '. ', bd[i]);
    write('Cho trang thai dau: '); readln(s);
    write('Cho day bien doi: '); readln(t);
    for i := 1 to 9 do kq[i] := ord(t[i])-48;
    for i := 1 to 9 do
      for j := 1 to kq[i] do
      begin
        write(s, ' -(', i, ')-> ');
        s := Config(s, i);
      end;
    writeln(s);
  end;

{BEGIN
  Thu; readln;
END.}

BEGIN
  Nhap;
  repeat
    KhoiTao;
    while not stop do Sinh;
    InKq; KiemTra;
    write('Go Esc de ket thuc, go Enter de lap lai ... ');
    ch := readkey;
  until ch = #27;
END.
