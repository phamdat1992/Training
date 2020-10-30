{$R-,Q-,S-,I-}
program CutVertices_CutEdges;
uses crt, visual;
const
  InputFile: String  = 'GRAPH.IN';
  OutputFile = 'GRAPH.OUT';
  maxN = 1000;
  maxM = 10000;
var
  adj: array[1..2 * maxM] of Integer;
  head: array[1..maxN + 1] of Integer;
  Parent, Numbering, Low1, Low2, nC: array[1..maxN] of Integer;
  CutV: array[1..maxN] of Integer;
  CutE: array[1..maxN, 1..2] of Integer;
  MarkCutE: array[1..maxN] of Boolean;
  MarkCutV: array[1..maxN] of Byte;
  n, m, Count, nCutV, nCutE: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i, u, v: Integer;
begin
  Assign(f, InputFile); Reset(f);
  FillChar(head, SizeOf(head), 0);
  Readln(f, n, m);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      Inc(head[u]); Inc(head[v]);
    end;
  Close(f);
  Reset(f);
  for i := 2 to n do head[i] := head[i - 1] + head[i];
  Readln(f);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      adj[head[u]] := v;
      Dec(head[u]);
      adj[head[v]] := u;
      Dec(head[v]);
    end;
  head[n + 1] := 2 * m;
end;

procedure Init;
begin
  FillChar(Parent, SizeOf(Parent), 0);
  FillChar(Numbering, SizeOf(Numbering), 0);
  nCutV := 0;
  nCutE := 0;
  Count := 0;
end;

function Min(x, y: Integer): Integer;
begin
  if x < y then Min := x else Min := y;
end;

procedure Visit(u: Integer);
var
  iv, v: Integer;
  isCutV: Boolean;
begin
  Inc(Count);
  Numbering[u] := Count; Low1[u] := n + 1; Low2[u] := n + 1;
  isCutV := False;
  nC[u] := 0;
  for iv := head[u] + 1 to head[u + 1] do
    begin
      v := adj[iv];
      if Numbering[v] <> 0 then
        begin
          Low1[u] := Min(Low1[u], Numbering[v]);
          if v <> Parent[u] then Low2[u] := Min(Low2[u], Numbering[v]);
        end
      else
        begin
          Parent[v] := u;
          Inc(nC[u]);
          Visit(v);
          isCutV := isCutV or (Low1[v] >= Numbering[u]);
          if Low2[v] > Numbering[u] then
            begin
              inc(nCutE);
              CutE[nCutE, 1] := u;
              CutE[nCutE, 2] := v;
            end;
          Low2[u] := Min(Low2[u], Low2[v]);
          Low1[u] := Min(Low1[u], Low1[v]);
        end;
    end;
  if isCutV then
    begin
      Inc(nCutV);
      CutV[nCutV] := u;
    end;
end;

procedure Solve;
var
  u: Integer;
begin
  for u := 1 to n do
    if Numbering[u] = 0 then
      begin
        Visit(u);
        if nC[u] = 1 then Dec(nCutV);
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
  Caption('Bµi "Khíp vµ CÇu"');
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

function CheckBridge(u, v: Integer): Integer;
var
  i: Integer;
begin
  for i := 1 to nCutE do
    if (CutE[i, 1] = u) and (CutE[i, 2] = v)
       or (CutE[i, 1] = v) and (CutE[i, 2] = u) then
         begin
           if MarkCutE[i] then
             begin
               CheckBridge := 2;
               Exit;
             end;
           MarkCutE[i] := True;
           CheckBridge := 1;
           Exit;
         end;
  CheckBridge := 0;
end;

procedure Test;
var
  i, tncutV, tncutE, j, u, v: Integer;
begin
  Caption('ChÊm bµi: "Khíp vµ CÇu"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, tnCutV, tnCutE);
  Writeln('Sè khíp: ');
  Writeln('  + §¸p ¸n  : ', nCutV);
  Writeln('  + Häc sinh: ', tnCutV);
  Writeln('Sè cÇu: ');
  Writeln('  + §¸p ¸n  : ', nCutE);
  Writeln('  + Häc sinh: ', tnCutE);
  if (nCutV <> tnCutV) or (nCutE <> tnCutE) then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end
  else Writeln('KÕt qu¶ ®óng!');
  FillChar(MarkCutV, SizeOf(MarkCutV), 0);
  for i := 1 to nCutV do MarkCutV[CutV[i]] := 1;
  Writeln('KiÓm tra c¸c khíp:');
  for i := 1 to nCutV do
    begin
      Readln(f, j);
      if (j < 1) or (j > n) then
        begin
          Writeln('    Sai khu«n d¹ng d÷ liÖu!');
          Wrong;
        end;
      if MarkCutV[j] = 0 then
        begin
          Writeln('    .§Ønh ', j, ' kh«ng ph¶i lµ khíp!');
          Wrong;
        end;
      if MarkCutV[j] = 2 then
        begin
          Writeln('  §Ønh ', j, ' liÖt kª hai lÇn!');
          Wrong;
        end;
      MarkCutV[j] := 2;
    end;
  Writeln('  ChÝnh x¸c!');
  Writeln('KiÓm tra c¸c cÇu:');
  FillChar(MarkCutE, SizeOf(MarkCutE), False);
  for i := 1 to nCutE do
    begin
      Readln(f, u, v);
      if (u < 1) or (u > n) or (v < 1) or (v > n) then
        begin
          Writeln('    Sai khu«n d¹ng d÷ liÖu!');
          Wrong;
        end;
      j := CheckBridge(u, v);
      if j = 0 then
        begin
          Writeln('    C¹nh (', u, ', ', v, ') kh«ng ph¶i lµ cÇu!');
          Wrong;
        end;
      if j = 2 then
        begin
          Writeln('    CÇu (', u, ', ', v, ') liÖt kª hai lÇn!');
          Wrong;
        end;
    end;
  Writeln('  ChÝnh x¸c!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Solve;
  Test;
end.

9
1 2
1 3
2 4
4 5
5 2
3 6
6 7
7 4
7 8
8 9
9 7
