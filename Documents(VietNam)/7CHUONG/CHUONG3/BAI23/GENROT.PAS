uses crt, graph;
type
  arrxy = array[0..3] of integer;
  arrtd = array[0..3, 0..3] of byte;
  arr = array[1..20, 1..20] of byte;
const
  tren: arrtd = ((0, 1, 1, 0), (0, 1, 1, 0), (3, 2, 2, 3), (3, 2, 2, 3));
  duoi: arrtd = ((0, 0, 3, 3), (1, 1, 2, 2), (1, 1, 2, 2), (0, 0, 3, 3));
var a, b, c, d: arr;
    n, h, min: byte;
    x1, y1, x2, y2, xf, yf: arrxy;
    w: integer;
    tt: string;
    time: longint absolute $0:$46C;
    tbegin, tend, dt: longint;


    procedure DefMin;
    var i, j, u, v: byte;
    begin
      h := 0;
      for i := 1 to n do
      begin
        b[i, i] := a[i, i];
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
      min := h;
    end;

    procedure Enter;
    var f: text;
        name: string;
        i, j: byte;
        v: integer;
    begin
      write('File Input: '); readln(name);
      if name <> '' then
      begin
        assign(f, name); reset(f);
        readln(f, n);
        for i := 1 to n do
          for j := 1 to n do read(f, a[i, j]);
        close(f);
      end else
      begin
        randomize;
        write('Size = '); readln(n);
        if n > 15 then n := 15;
        for i := 1 to n do
          for j := 1 to n do a[i, j] := random(4);
      end;
      w := 230 div n;
      v := w-1;
      x1[0] := 0; x1[1] := 0; x1[2] := 0; x1[3] := 0;
      y1[0] := 0; y1[1] := w; y1[2] := 0; y1[3] := w;
      x2[0] := w; x2[1] := w; x2[2] := w; x2[3] := w;
      y2[0] := w; y2[1] := 0; y2[2] := w; y2[3] := 0;
      xf[0] := 1; xf[1] := 1; xf[2] := v; xf[3] := v;
      yf[0] := v; yf[1] := 1; yf[2] := 1; yf[3] := v;
    end;

    procedure InitGr;
    var gd, gm : integer;
    begin
      gd := detect;
      initgraph(gd, gm, '..\..\tp\bgi');
      if GraphResult <> GrOk then Halt;
      settextstyle(smallfont, 0, 4);
    end;

    procedure DrawFig(x0, y0: integer; var Fig: arr);
    var i, j, k: byte;
        x, y: integer;
    begin
      setfillstyle(1, 7); setcolor(8);
      for i := 1 to n do
        for j := 1 to n do
        begin
          x := (j-1)*w+x0;
          y := (i-1)*w+y0;
          rectangle(x, y, x+w, y+w);
          k := Fig[i, j];
          line(x+x1[k], y+y1[k], x+x2[k], y+y2[k]);
          floodfill(x+xf[k], y+yf[k], 8);
        end;
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

    procedure Result(x0, y0: integer; var Fig: arr);
    var i, j, k: byte;
        x, y: integer;
        st, tt: string;
    begin
      DrawFig(x0, y0, fig);
      setcolor(4);
      settextjustify(centertext, centertext);
      for i := 1 to n do
        for j := 1 to n do
        if a[i, j] <> fig[i, j] then
        begin
          x := x0+(j-1)*w+w div 2;
          y := y0+(i-1)*w+w div 2;
          k := fig[i, j];
          if k < a[i, j] then k := k+4;
          k := k-a[i, j];
          str(k*90, tt);
          outtextxy(x, y, tt);
        end;
       setcolor(15);
       str(min, st);
       st := 'min = '+st;
       str(dt/18.2:1:2, tt);
       tt := 'thoi gian = '+tt;
       settextjustify(lefttext, bottomtext);
       outtextxy(x0-110, y0+100, st);
       outtextxy(x0-110, y0+110, tt);
    end;

    procedure WriteFile;
    var f: text;
        fn: string;
        i, j: byte;
    begin
      write('Ghi dau bai len file: ');
      readln(fn);
      if fn = '' then exit;
      assign(f, fn);
      rewrite(f);
      writeln(f, n);
      for i := 1 to n do
      begin
        for j := 1 to n do write(f, a[i, j]:2);
        writeln(f);
      end;
      writeln(f, min);
      close(f);
    end;

BEGIN
  Enter;
  InitGr;
  DrawFig(0, 0, a);
  str(n, tt);
  tt := 'Size = '+tt;
  setcolor(15);
  outtextxy(90, 240, tt);
  tbegin := time;
  DefMin;
  tend := time;
  dt := tend-tbegin;
  Result(360, 0, b);
  tbegin := time;
  Try(1, 0);
  tend := time;
  dt := tend-tbegin;
  Result(360, 240, c);
  setcolor(15);
  outtextxy(200, 470, 'Go Enter de ket thuc ...');
  readln;
  closegraph;
  WriteFile;
END.