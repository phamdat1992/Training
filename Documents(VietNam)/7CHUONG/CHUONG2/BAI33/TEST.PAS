const
  max = 100;
  max2 = max*max;
var
  m, n, mn, da: integer;
  a, rr: array[1..max, 1..max] of byte;
  aa: array[1..max, 1..max] of integer;
  cell: array[1..max2] of byte;
  f: text;
  fn: string;

  function Rot(r, b: byte): byte;
  var i, b1, b2: byte;
  begin
    for i := 1 to r do
    begin
      b1 := b shr 2;
      b2 := byte(b shl 6);
      b := b1 or b2;
    end;
    Rot := b;
  end;


  procedure ReadInp;
  var i, j: integer;
  begin
{    write('Input name: '); readln(fn);}
    assign(f, 'XEP.INP'); reset(f);
    readln(f, m, n); mn := m*n;
    for i := 1 to mn do read(f, cell[i]);
    for i := 1 to m do
      for j := 1 to n do read(f, a[i, j]);
    read(f, da);
    close(f);
  end;

  procedure ReadOut;
  var i, j, k, tr: integer;
      b, r: byte;
  begin
{    write('Output name: '); readln(fn);}
    assign(f, 'XEP.OUT'); reset(f);
    read(f, tr);
    if tr = -1 then
    begin
      write('Khong xep duoc! ');
      if da = -1 then writeln('Ok') else writeln('Error');
      halt;
    end;
    reset(f);
    for i := 1 to m do
      for j := 1 to n do
      begin
        read(f, aa[i, j]);
        if (aa[i, j] < 1) or (aa[i, j] > mn) then
        begin
          writeln('So hieu o dong ', i, ', cot ', j, ' sai!');
          halt;
        end;
      end;
    for i := 1 to m do
      for j := 1 to n do
      begin
        read(f, rr[i, j]);
        if not (rr[i, j] in [0..3]) then
        begin
          writeln('Gia tri quay o dong ', i, ', cot ', j, ' sai!');
          halt;
        end;
      end;
    close(f);
    {kiem tra tinh hop le}
    tr := 0;
    for i := 1 to m do
      for j := 1 to n do
      begin
        k := aa[i, j];
        r := rr[i, j];
        b := cell[k];
        b := Rot(r, b);
        if b <> a[i, j] then
        begin
          writeln('Khong dung mau o dong ', i, ', cot ', j);
          halt;
        end;
        tr := tr+r;
      end;
    write('Hop le! So lan nhan phim = ', tr);
    if tr > da then writeln(', dap an = ', da, ', chua toi uu!')
    else writeln(', Ok');
  end;

begin
  ReadInp;
  ReadOut;
end.