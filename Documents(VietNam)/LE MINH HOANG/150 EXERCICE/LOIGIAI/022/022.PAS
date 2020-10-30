program AirLines;
const
  InputFile  = 'AIRLINES.IN0';
  OutputFile = 'AIRLINES.OUT';
  max = 100;
  maxCompany = 16;
  maxWord = $FFFF;
  Continum = 10001;
type
  TCmps = set of 1..16;
var
  Comps: array[1..max, 1..max] of TCmps;
  d: array[1..max, 1..maxCompany] of Integer;
  ListA, ListC: array[1..max * maxCompany] of Integer;
  TraceAirport: array[1..max, 1..maxCompany] of Integer;
  TraceCompany: array[1..max, 1..maxCompany] of Integer;

  n, nList, S, F, C, A: Integer;
  PAirport, PCompany: Integer;
  MinD: Word;

procedure Enter;
var
  fi: Text;
  i, m: Integer;
  u, v, k: Integer;
begin
  Assign(fi, InputFile); Reset(fi);
  Readln(fi, n, m, C, A, S, F);
  FillChar(Comps, SizeOf(Comps), 0);
  for i := 1 to m do
    begin
      Read(fi, u, v);
      while not SeekEoln(fi) do
        begin
          Read(fi, k);
          Comps[u, v] := Comps[u, v] + [k];
        end;
      Readln(fi);
      Comps[v, u] := Comps[u, v]
    end;
  Close(fi);
end;

procedure Init;
var
  i, ap, cmp: Integer;
begin
  for ap := 1 to n do
    for cmp := 1 to maxCompany do d[ap, cmp] := Continum ;
  for i := 1 to maxCompany do d[F, i] := 0;
  nList := maxCompany;
  for i := 1 to maxCompany do
    begin
      ListA[i] := F;
      ListC[i] := i;
    end;
end;

procedure FindPermanent;
var
  i, Ap, Cmp, index: Integer;
begin
  MinD := maxWord;
  for i := 1 to nList do
    begin
      Ap := ListA[i];
      Cmp := ListC[i];
      if d[Ap, Cmp] < MinD then
        begin
          MinD := d[Ap, Cmp];
          PAirport := Ap;
          PCompany := Cmp;
          index := i;
        end;
    end;
  ListA[index] := ListA[nList];
  ListC[index] := ListC[nList];
  Dec(nList);
end;

procedure OptimizeLabel;
var
  i, j: Integer;
  b: Boolean;
begin
  {Bay tu san bay PAirport san bay i bang may bay cua hang PCompany}
  for i := 1 to n do
    if (PCompany in Comps[PAirport, i]) and
          (d[i, PCompany] > MinD + C) then
      begin
        b := d[i, PCompany] = Continum;
        d[i, PCompany] := MinD + C;
        TraceAirport[i, PCompany] := PAirport;
        TraceCompany[i, PCompany] := PCompany;
        if b then
          begin
            Inc(nList);
            ListA[nList] := i; ListC[nList] := PCompany;
          end;
      end;
  for j := 1 to maxCompany do {Walk}
    if d[PAirport, j] > MinD + A then
      begin
        b := d[PAirport, j] = Continum;
        d[PAirport, j] := MinD + A;
        TraceAirport[PAirport, j] := PAirport;
        TraceCompany[PAirport, j] := PCompany;
        if b then
          begin
            Inc(nList);
            ListA[nList] := PAirport; ListC[nList] := j;
          end;
      end;
end;

procedure FindPath; {Shortest path by Dijkstra}
begin
  repeat
    FindPermanent;
    if PAirport = S then Break;
    OptimizeLabel;
  until False;
end;

procedure Result;
var
  fo: Text;
  NextAirport, NextCompany: Integer;
begin
  Assign(fo, OutputFile); Rewrite(fo);
  Writeln(fo, d[PAirport, PCompany]);
  repeat
    NextAirport := TraceAirport[PAirport, PCompany];
    NextCompany := TraceCompany[PAirport, PCompany];
    if PAirport <> NextAirport then
      Writeln(fo, PAirport, ' ', NextAirport, ' ', NextCompany);
    PAirport := NextAirport;
    PCompany := NextCompany;
  until PAirport = F;
  Close(fo);
end;

begin
  Enter;
  Init;
  FindPath;
  Result;
end.
15 16 3 2 1 5
  1  2     1
  2  3     1
  3  4     1 2
  3  9     2
  4  9     1
  5  10    1 3
  6  7     1
  6  11    1
  7  8     1
  7  13    2
  8  9     1
  10 15    3
  11 12    1
  12 13    1
  13 14    1 3
  14 15    1 3
