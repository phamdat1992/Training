type
  arrtd = array[0..3, 0..3] of byte;
  arr = array[1..10, 1..10] of byte;
const
  tren: arrtd = ((0, 1, 1, 0), (0, 1, 1, 0), (3, 2, 2, 3), (3, 2, 2, 3));
  duoi: arrtd = ((0, 0, 3, 3), (1, 1, 2, 2), (1, 1, 2, 2), (0, 0, 3, 3));
  fi = 'ROT.IN1';
  fo = 'ROT.OUT';
var a, b, c: arr;
    n, h, min: byte;
    time: longint absolute $0:$46C;
    tbegin, tend, dt: longint;
    f: text;

    procedure Enter;
    var i, j: byte;
    begin
      assign(f, fi); reset(f);
      readln(f, n);
      for i := 1 to n do
        for j := 1 to n do read(f, a[i, j]);
      close(f);
      Min := 100;
    end;

    procedure Define(i: byte);
    var j, u, v: byte;
    begin
      h := 0;
      if a[i, i] <> b[i, i] then h := 1;
      for j := i-1 downto 1 do
      begin
        u := b[j, i-1];
        v := b[j+1, i];
        b[j, i] := tren[u, v];
        if a[j, i] <> b[j, i] then inc(h);
        u := b[i-1, j];
        v := b[i, j+1];
        b[i, j] := duoi[u, v];
        if a[i, j] <> b[i, j] then inc(h);
      end;
    end;

    procedure Try(i, old: byte);
    var j: byte;
    begin
      for j := 0 to 3 do
      begin
        b[i, i] := j;
        Define(i);
        if old+h < min then
          if i = n then
          begin
            min := old+h;
            c := b;
          end else Try(i+1, old+h);
      end;
    end;

    procedure Result;
    var i, j: byte;
        k: integer;
    begin
      assign(f, fo); rewrite(f);
      writeln(f, min);
      for i := 1 to n do
        for j := 1 to n do
        if a[i, j] <> c[i, j] then
        begin
          k := c[i, j];
          if k < a[i, j] then k := k+4;
          k := k-a[i, j];
          writeln(f, i, ' ', j, ' ', k*90);
        end;
      close(f);
    end;

BEGIN
  writeln;
  writeln('File du lieu ', fi);
  Enter;
  tbegin := time;
  Try(1, 0);
  tend := time;
  dt := tend-tbegin;
  writeln('Thoi gian ', dt/18.2:1:2, ' (sec)');
  Result;
  writeln('Da ghi ket qua len file ', fo);
END.
