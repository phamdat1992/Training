program Max_Flow_by_Ford_Fulkerson;
uses crt, visual;
const
  InputFile: string = 'MAXFLOW.IN';
  OutputFile = 'MAXFLOW.OUT';
  max = 100;
  maxC = 10000;
var
  c, f: array[1..max, 1..max] of Integer;
  Trace: array[1..max] of Integer;
  Delta: array[1..max] of Integer;
  n: Integer;
  res: Integer;
  fo: Text;
  ch: Char;

procedure Enter;
var
  m, i, u, v: Integer;
  fi: Text;
begin
  Assign(fi, InputFile); Reset(fi);
  FillChar(c, SizeOf(c), 0);
  ReadLn(fi, n, m);
  for i := 1 to m do
    ReadLn(fi, u, v, c[u, v]);
  Close(fi);
end;

function Min(X, Y: Integer): Integer;
begin
  if X < Y then Min := X else Min := Y;
end;

function FindPath: Boolean;
var
  u, v: Integer;
  Queue: array[1..max] of Integer;
  First, Last: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  First := 1; Last := 1; Queue[1] := 1;
  Trace[1] := n + 1;
  Delta[1] := maxC;
  repeat
    u := Queue[First]; Inc(First);		
    for v := 1 to n do
      if Trace[v] = 0 then 					
        begin
          if f[u, v] < c[u, v] then 	
            begin
              Trace[v] := u; 				
              Delta[v] := min(Delta[u], c[u, v] - f[u, v]);
            end
          else
            if f[v, u] > 0 then 			
              begin
                Trace[v] := -u;			
                Delta[v] := min(Delta[u], f[v, u]);
              end;
          if Trace[v] <> 0 then 			
            begin
              if v = n then
                begin
                  FindPath := True; Exit;
                end;
              Inc(Last); Queue[Last] := v;
            end;
        end;
  until First > Last;
  FindPath := False;
end;

procedure IncFlow;
var
  IncValue, u, v: Integer;
begin
  IncValue := Delta[n];
  v := n;
  repeat
    u := Trace[v];
    if u > 0 then f[u, v] := f[u, v] + IncValue
    else
      begin
        u := -u;
        f[v, u] := f[v, u] - IncValue;
      end;
    v := u;
  until v = 1;
end;

procedure PrintResult;
var
  u, v, m: Integer;
begin
  m := 0;
  for v := 1 to n do m := m + f[1, v];
  res := m;
end;

procedure Halt;
begin
  {$I-}
  Close(fo); if IOResult = 0 then;
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
  Caption('Bµi 149: "Luång cùc ®¹i trªn m¹ng"');
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
  HSW, W1: LongInt;
  v, x, y, w: Integer;
  InF, OutF: array[1..max] of Integer;
begin
  Caption('ChÊm bµi 149: "Luång cùc ®¹i trªn m¹ng"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(fo, OutputFile); Reset(fo);
  Readln(fo,  HSW);
  Writeln('Gi¸ trÞ luång: ');
  Writeln('  + §¸p ¸n    : ', res);
  Writeln('  + Häc sinh  : ', HSW);
  if HSW < res then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  FillChar(Inf, SizeOf(Inf), 0);
  FillChar(OutF, SizeOf(OutF), 0);
  while not SeekEof(fo) do
    begin
      Readln(fo, x, y, w);
      if w > c[x, y] then
        begin
          Writeln('Cung (', x, ', ', y, '): ');
          Writeln('  + Kh¶ n¨ng th«ng qua: ', c[x, y]);
          Writeln('  + Luång ®­îc g¸n    : ', w);
          Writeln('Overflow');
          Wrong;
        end;
      InF[y] := InF[y] + w;
      OutF[x] := OutF[x] + w;
    end;
  for v := 2 to n - 1 do
    if InF[v] <> OutF[v] then
      begin
        Writeln('§Ønh ', v, ': ');
        Writeln('  + Luång vµo:  ', InF[v]);
        Writeln('  + Luång ra:   ', OutF[v]);
        Wrong;
      end;
  W1 := OutF[1];
  Writeln('Gi¸ trÞ luång tÝnh trªn thùc tÕ: ', W1);
  if W1 <> HSW then
    begin
      Writeln('TiÒn hËu bÊt nhÊt: ');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
  Correct;
end;

begin
  AskTest;
  Enter;
  FillChar(f, SizeOf(f), 0);
  while FindPath do IncFlow;
  PrintResult;
  Test;
end.
6 8
1 2 5
1 3 5
2 4 6
2 5 3
3 4 3
3 5 1
4 6 6
5 6 6