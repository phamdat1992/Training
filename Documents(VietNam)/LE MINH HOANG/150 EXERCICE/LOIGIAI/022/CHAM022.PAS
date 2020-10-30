program AirLines;
uses crt, visual;
const
  InputFile: String = 'AIRLINES.IN';
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

  res, n, nList, S, F, C, A: Integer;
  PAirport, PCompany: Integer;
  MinD: Word;
  g: Text;
  ch: Char;

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
begin
  res := d[PAirport, PCompany];
end;

procedure Halt;
begin
  {$I-}
  Close(g); if IOResult = 0 then;
  {$I+}
  ReadKey;
  TextMode(C80); Textattr := 7; Clrscr;
  System.Halt;
end;

procedure WriteP(p: Integer);
var
  f: file of Integer;
begin
  Assign(f, 'POINT.PNT'); Rewrite(f);
  Write(f, p);
  Close(f);
end;

function ReadP: Integer;
var
  f: file of Integer;
  P: Integer;
begin
  {$I-}
  Assign(f, 'POINT.PNT'); Reset(f);
  if IOResult <> 0 then
    begin
      WriteP(0);
      Reset(f);
    end;
  {$I+}
  Read(f, p);
  Close(f);
  ReadP := p;
end;

procedure ShowP;
var
  S: String;
begin
  Str(ReadP, S);
  if Length(S) < 2 then S := '0' + S;
  Visual.Color := 30;
  MSG(60, 3, 'Tæng', 'Tæng ®iÓm ®ang lµ ' + S + '/10');
end;

procedure Correct;
begin
  Visual.Color := 47;
  MSG(20, 3, InputFile, '   B¹n cã 1 ®iÓm   ');
  WriteP(ReadP + 1);
  ShowP;
  if ReadP = 10 then
    Logo('§óng hÕt c¸c test', 'Perfect! Perfect!');
  Halt;
end;

procedure Wrong;
begin
  Visual.Color := 78;
  MSG(20, 3, InputFile, '   B¹n cã 0 ®iÓm   '#7);
  ShowP;
  Halt;
end;

procedure AskTest;
var
  S: String[1];
begin
  Caption('Bµi 022: "TuyÕn bay"');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: ' + InputFile + '  '#8#8);
  if (ParamCount <> 0) and (ParamStr(1) <> '') then
    begin
      S := ParamStr(1);
      ch := S[1];
    end
  else  ch := ReadKey;
  Write(ch);
  if ch = '1' then WriteP(0);
  if ch = #13 then
    begin
      MSG(40, 13, '§iÓm', 'Tæng ®iÓm cña b¹n ®ang lµ:  '#8#8);
      Write(ReadP);
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure Test;
var
  hsRes: Integer;
  cc, u1, v1, c1, u2, v2, c2: Integer;
begin
  Caption('ChÊm bµi 022: "TuyÕn bay"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(g, OutputFile); Reset(g);
  readln(g, hsRes);
  Writeln('Chi phÝ cho tuyÕn bay: ');
  Writeln('  + §¸p ¸n  : ', Res);
  Writeln('  + Häc sinh: ', hsRes);
  if hsRes > Res then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  Readln(g, u1, v1, c1);
  if (u1 < 1) or (u1 > n) or (v1 < 1) or (v1 > n)
     or (c1 < 1) or (c1 > 16) then
       begin
         Writeln('Sai khu«n d¹ng d÷ liÖu!');
         Wrong;
       end;
  Writeln('   ', u1, ' -> ', v1, ' (', c1, ')');
  cc := C;
  if not (c1 in Comps[u1, v1]) then
    begin
      Writeln('C­íp m¸y bay: ', u1, ' -> ', v1, ' (', c1, ')');
      Wrong;
    end;
  if u1 <> S then
    begin
      Writeln('Thµnh phè xuÊt ph¸t sai!');
      Wrong;
    end;
  while not SeekEof(g) do
    begin
      Readln(g, u2, v2, c2);
      Writeln('   ', u2, ' -> ', v2, ' (', c2, ')');
      if (u2 < 1) or (u2 > n) or (v2 < 1) or (v2 > n)
         or (c2 < 1) or (c2 > 16) then
           begin
             Writeln('Sai khu«n d¹ng d÷ liÖu!');
             Wrong;
           end;
      if u2 <> v1 then
        begin
          Writeln('§i ®­êng rõng: ', v1, ' -> ', u2);
          Wrong;
        end;
      if not (c2 in Comps[u2, v2]) then
        begin
          Writeln('C­íp m¸y bay: ', u2, ' -> ', v2, ' (', c2, ')');
          Wrong;
        end;
      cc := cc + C;
      if c2 <> c1 then cc := cc + A;
      u1 := u2; v1 := v2; c1 := c2;
    end;
  if v2 <> F then
    begin
      Writeln('Thµnh phè kÕt thóc sai!');
      Wrong;
    end;
  Writeln('Chi phÝ tÝnh theo hµnh tr×nh: ', cc);
  if cc <> hsRes then
    begin
      Writeln('TiÒn hËu bÊt nhÊt!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  FindPath;
  Result;
  Test;
end.
