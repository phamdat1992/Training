type
  arrtd = array[0..3, 0..3] of byte;
  arr = array[1..10, 1..10] of byte;
const
  tren: arrtd = ((0, 1, 1, 0), (0, 1, 1, 0), (3, 2, 2, 3), (3, 2, 2, 3));
  duoi: arrtd = ((0, 0, 3, 3), (1, 1, 2, 2), (1, 1, 2, 2), (0, 0, 3, 3));
  fi = 'ROT.IN1';
  fo = 'ROT.OUT';
var a, b: arr;
    n, h, min: byte;
    f: text;

    procedure ReadData;
    var i, j: byte;
    begin
      writeln;
      writeln('File du lieu ', fi);
      assign(f, fi); reset(f);
      readln(f, n);
      for i := 1 to n do
        for j := 1 to n do read(f, a[i, j]);
      read(f, h);
      close(f);
    end;

    Procedure ReadResult;
    var i, j, k, p: byte;
        g: integer;
    begin
      writeln('File ket qua ', fo);
      assign(f, fo); reset(f);
      readln(f, min);
      for p := 1 to min do
      begin
        readln(f, i, j, g);
        k := g div 90;
        a[i, j] := (a[i, j]+k) mod 4;
      end;
      close(f);
    end;

    procedure Def;
    var i, j, u, v: byte;
    begin
      for i := 1 to n do
      begin
        b[i, i] := a[i, i];
        for j := i-1 downto 1 do
        begin
          u := b[j, i-1];
          v := b[j+1, i];
          b[j, i] := tren[u, v];
          u := b[i-1, j];
          v := b[i, j+1];
          b[i, j] := duoi[u, v];
        end;
      end;
    end;

    procedure Test;
    var i, j: byte;
    begin
      writeln('Ket qua test:');
      for i := 1 to n do
        for j := 1 to n do
        if b[i, j] <> a[i, j] then
        begin
          writeln('  Error (', i, ', ', j, ')');
          readln; exit;
        end;
        if h < min then
        begin
          writeln('  No optimal (optimal = ', h, ')');
          readln; exit;
        end;
        if min = h then writeln('  Ok') else writeln('  Extra');
        readln;
    end;

BEGIN
  ReadData; ReadResult; Def; Test;
END.
