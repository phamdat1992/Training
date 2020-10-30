{Test bai COMPANY
dau bai: COMPANY.DAT, dap an: DAPAN.TXT, loi giai: COMPANY.SOL
ket qua test: TEST.TXT}
uses CRT;
const
  siz = 100;
var a: array[1..siz, 1..siz] of byte;
    n: integer;

    function LTrim(s: string): string;
    var i, l: integer;
    begin
      i := 1; l := length(s);
      while (i <= l) and (s[i] = ' ') do inc(i);
      LTrim := Copy(s, i, l-i+1);
    end;

    procedure Split(var s, sfirst: string);
    var i: integer;
    begin
      i := pos(' ', s);
      if i > 0 then
      begin
        sfirst := Copy(s, 1, i-1);
        delete(s, 1, i-1);
      end else
      begin
        sfirst := s;
        s := '';
      end;
    end;

    procedure Dapan;
    var f, g: text;
        i, j, c: integer;
        st, sf: string;
    procedure Xuly;
    var x, y, i, j: integer;
        p, q: array[1..siz] of integer;
        np, nq, nn, s: integer;
    begin
      if n = 0 then exit;
      for x := 1 to n do
      begin
        {khoi tao}
        np := 1; p[1] := x;
        for i := 1 to n do q[i] := i;
        q[x] := q[n]; nq := n-1; nn := n;
        while nq < nn do
        begin
          nn := nq;
          for i := 1 to nn do
          begin
            s := 0; y := q[i];
            for j := 1 to np do s := s+a[p[j], y];
            if s > 50 then  {ket nap y vao p va loai y khoi q}
            begin
              inc(np); p[np] := y;
              q[i] := q[nq]; dec(nq); break;
            end;
          end;
        end;
        {sap xep}
        for i := 2 to np do
          for j := np downto i do
          if p[j-1] > p[j] then
          begin
            y := p[j-1]; p[j-1] := p[j]; p[j] := y;
          end;
        for i := 1 to np do if p[i] <> x then writeln(g, x:5, p[i]:5);
      end;  {for x}
      writeln(g);
      fillchar(a, sizeof(a), 0); n := 0;
    end;
    begin  {Dapan}
      clrscr;
      fillchar(a, sizeof(a), 0); n := 0;
      assign(f, 'COMPANY.DAT'); reset(f);
      assign(g, 'DAPAN.TXT'); rewrite(g);
      while not eof(f) do
      begin
        readln(f, st);
        if st <> '' then
        begin
          st := LTrim(st);
          Split(st, sf);
          Val(sf, i, c);
          if n < i then n := i;
          st := LTrim(st);
          Split(st, sf);
          Val(sf, j, c);
          if n < j then n := j;
          st := LTrim(st);
          Split(st, sf);
          Val(sf, a[i, j], c);
        end else Xuly;
      end;
      Xuly;
      close(f); close(g);
    end;

    procedure Test;
    var
      dapan, ketqua: array[1..siz] of string[20];
      ndapan, nketqua, i, m, het, dem: integer;
      f, g, ff: text;
      st: string;
    begin
      assign(f, 'DAPAN.TXT'); reset(f);
      assign(g, 'COMPANY.SOL'); reset(g);
      assign(ff, 'TEST.TXT'); rewrite(ff);
      het := 0; dem := 0;
      while het < 3 do
      begin
        inc(dem);
        writeln(ff, '         DATA ', dem);
        writeln(ff, 'Dap an         Ket qua');
        st := '*'; ndapan := 0;
        while not eof(f) and (st <> '') do
        begin
          readln(f, st);
          if st <> '' then
          begin
            inc(ndapan); dapan[ndapan] := st;
          end;
        end;
        if eof(f) then het := het or 1;
        st := '*'; nketqua := 0;
        while not eof(g) and (st <> '') do
        begin
          readln(g, st);
          if st <> '' then
          begin
            inc(nketqua); ketqua[nketqua] := st;
          end;
        end;
        if eof(g) then het := het or 2;
        m := ndapan;
        if m < nketqua then m := nketqua;
        for i := ndapan+1 to m do dapan[i] := '          ';
        for i := nketqua+1 to m do ketqua[i] := '';
        for i := 1 to m do writeln(ff, dapan[i], '     ', ketqua[i]);
      end;     {while het < 3}
      close(f); close(g); close(ff);
    end;

BEGIN
  Dapan;
  Test;
END.
