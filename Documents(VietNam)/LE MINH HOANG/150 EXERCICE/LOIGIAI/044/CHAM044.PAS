{$R-,Q-,S-,I-}
{$M 65520 0 655360}
program StrongconnectivityTest;
uses crt, visual;
const
  InputFile: String = 'GRAPH.IN';
  OutputFile = 'GRAPH.OUT';
  maxN = 1000;
  maxM = 5000;
var
  adj: array[1..maxM] of Integer;
  head: array[1..maxN + 1] of Integer;
  Stack, Numbering, Low, NV, List: array[1..maxN] of Integer;
  Free: array[1..maxN] of Boolean;
  Count, n, nComponent, Last, nList: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i, u, v, m: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  FillChar(head, SizeOf(head), 0);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      Inc(head[u]);
    end;
  for u := 2 to n do Head[u] := Head[u - 1] + Head[u];
  Close(f);
  Reset(f);
  Readln(f);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      adj[head[u]] := v;
      Dec(head[u]);
    end;
  Head[n + 1] := m;
end;

procedure Init;
begin
  FillChar(Numbering, SizeOf(Numbering), 0);
  FillChar(Free, SizeOf(Free), True);
  FillChar(nV, SizeOf(nV), 0);
  Last := 0;
  Count := 0;
  nComponent := 0;
end;

procedure Push(V: Integer);
begin
  Inc(Last); Stack[Last] := V;
end;

function Pop: Integer;
begin
  Pop := Stack[Last];
  Dec(Last);
end;

function Min(a, b: Integer): Integer;
begin
  if a < b then Min := a else Min := b;
end;

procedure Visit(u: Integer);
var
  iv, v: Integer;
begin
  Inc(Count);
  Numbering[u] := Count; Low[u] := Count;
  Push(u);
  for iv := Head[u] + 1 to Head[u + 1] do
    begin
      v := adj[iv]; {v la 1 dinh ke u}
      if not Free[v] then Continue; {v da bi loai khoi do thi thi bo qua}
      if Numbering[v] <> 0 then Low[u] := min(Low[u], Numbering[v])
      else
        begin
          Visit(v);
          Low[u] := min(Low[u], Low[v]);
        end
    end;
  if Numbering[u] = Low[u] then
    begin
      Inc(nComponent);
      repeat
        Inc(nList);
        Inc(nV[nComponent]);
        v := Pop;
        List[nList] := v;
        Free[v] := False;
      until v = u;
    end;
end;

procedure Solve;
var
  u: Integer;
begin
  for u := 1 to n do
    if Numbering[u] = 0 then Visit(u);
end;

procedure Result;
var
  c, i: Integer;
begin
  c := 1;
  for i := 1 to n do
    begin
      Numbering[List[i]] := c;
      Dec(nV[c]);
      if nV[c] = 0 then Inc(c);
    end;
end;

procedure Halt;
begin
  {$I-}
  Close(f); if IOResult = 0 then;
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
  Assign(f, 'POINT.PNT'); Reset(f);
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
  Caption('Bµi "C¸c thµnh phÇn liªn th«ng m¹nh"');
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
  i, T, u, v: Integer;
begin
  Caption('ChÊm bµi: "C¸c thµnh phÇn liªn th«ng m¹nh"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Writeln('Sè thµnh phÇn liªn th«ng: ');
  Assign(f, OutputFile); Reset(f);
  Readln(f, T);
  Writeln('  + §¸p ¸n:   ', nComponent);
  Writeln('  + Häc sinh: ', T);
  if T <> nComponent then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  Writeln('Sè thµnh phÇn liªn th«ng ®óng!');
  FillChar(Low, SizeOf(Low), 0);
  for i := 1 to T do
    begin
      while not SeekEoln(f) do
        begin
          Read(f, u);
          Low[u] := i;
        end;
      Readln(f);
    end;
  Close(f);
  Writeln('KiÓm tra c¸c thµnh phÇn liªn th«ng');
  for u := 1 to n do
    for v := u + 1 to n do
      begin
        if (Numbering[u] <> Numbering[v]) and (Low[u] = Low[v]) then
          begin
            Writeln('§Ønh ', u, ' vµ ', v, ' kh«ng thÓ cã ®­êng ®i khø håi');
            Writeln('Nh­ng häc sinh cho chóng thuéc cïng 1 thµnh phÇn liªn th«ng m¹nh');
            Wrong;
          end;
        if (Numbering[u] = Numbering[v]) and (Low[u] <> Low[v]) then
          begin
            Writeln('§Ønh ', u, ' vµ ', v, ' cã ®­êng ®i khø håi');
            Writeln('Nh­ng häc sinh cho chóng thuéc 2 thµnh phÇn liªn th«ng m¹nh kh¸c nhau');
            Wrong;
          end;
      end;
  Writeln('KÕt qu¶ chÝnh x¸c!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Solve;
  Result;
  Test;
end.
