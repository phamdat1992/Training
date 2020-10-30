{$R-,S-,Q-,D-}
program Escape;
uses crt, visual;
const
  InputFile: String  = 'ESCAPE.IN';
  OutputFile = 'ESCAPE.OUT';
  max = 100;
  dx: array[1..4] of Integer = (1, 0, 0, -1);
  dy: array[1..4] of Integer = (0, 1, -1, 0);
type
  TCell = record
    x, y: Integer;
  end;
  TQueue = array[1..(max + 2) * (max + 2)] of TCell;
var
  Map: array[0..max + 1, 0..max + 1] of Byte;
  Queue: TQueue;
  First, Last, Sx, Sy, m, n: Integer;
  res: String;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i, j: Integer;
  c: Char;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  FillChar(Map, SizeOf(Map), 5); {Chi can <> 0 ma thoi}
  for i := 1 to m do
    begin
      for j := 1 to n do
        begin
          Read(f, c);
          case c of
            'E': begin
                   Sx := i; Sy := j;
                   Map[i, j] := 0;
                 end;
            '.': Map[i, j] := 0;
            else Map[i, j] := 5;
          end;
        end;
      Readln(f);
    end;
  Close(f);
end;

procedure Push(r, c: Integer);
begin
  Inc(Last);
  with Queue[Last] do
    begin
      x := r; y := c;
    end;
end;

procedure Pop(var r, c: Integer);
begin
  with Queue[First] do
    begin
      r := x; c := y;
    end;
  Inc(First);
end;

procedure Init;
var
  i, j: Integer;

  procedure PushandMark(r, c: Integer);
  begin
    if Map[r, c] = 0 then
      begin
        Push(r, c);
        Map[r, c] := 6;
      end;
  end;

begin
  Last := 0;
  for i := 1 to m do {bien trai + bien phai}
    begin
      PushandMark(i, 1);
      PushandMark(i, n);
    end;
  for j := 2 to n - 1 do {bien tren + bien duoi}
    begin
      PushandMark(1, j);
      PushandMark(m, j);
    end;
  First := 1;
end;

procedure BreadthFirstSearch;
var
  x, y, newx, newy, d: Integer;
begin
  while First <= Last do
    begin
      Pop(x, y);
      for d := 1 to 4 do  {Xet 4 o lan can}
        begin
          newx := x + dx[d]; newy := y + dy[d];
          if Map[newx, newy] = 0 then
            begin
              Map[newx, newy] := d; {Ghi vet huong di}
              if (Newx = Sx) and (Newy = Sy) then Exit;
              Push(newx, newy);
            end;
        end;
    end;
end;

procedure Result;
var
  d: Integer;
begin
  if Map[Sx, Sy] = 0 then res := 'NO'
  else res := 'YES';
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
  Caption('Bµi "§­êng tho¸t mª cung"');
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

function Adj(x1, y1, x2, y2: Integer): Boolean;
var
  d: Integer;
begin
  for d := 1 to 4 do
    if (x2 = x1 + dx[d]) and (y2 = y1 + dy[d]) then
      begin
        adj := True;
        Exit;
      end;
  Adj := False;
end;

procedure Test;
var
  T: String;
  x, y: Integer;
begin
  Caption('ChÊm bµi: "§­êng tho¸t mª cung"');
  Enter;
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, Outputfile); Reset(f);
  Readln(f, T);
  Writeln('Dßng 1: ');
  Writeln('  + §¸p ¸n  : ''', Res, '''');
  Writeln('  + Häc sinh: ''', T, '''');
  if Res <> T then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  if Res = 'NO' then
    begin
      Writeln('KÕt qu¶ ®óng!');
      Correct;
    end;
  Readln(f, x, y);
  Writeln(x:10, ' ', y);
  if (x <> Sx) or (y <> Sy) then
    begin
      Writeln('¤ xuÊt ph¸t sai!');
      Wrong;
    end;
  while not SeekEof(f) do
    begin
      Readln(f, x, y);
      Writeln(x:10, ' ', y);
      if (x < 1) or (x > m) or (y < 1) or (y > n) then
        begin
          Writeln('Sai khu«n d¹ng d÷ liÖu!');
          Wrong;
        end;
      if not Adj(Sx, Sy, x, y) then
        begin
          Writeln('§­êng ®i (', Sx, ', ', Sy, ') - (', x, ', ', y, ') ',
                         'kh«ng kÒ c¹nh');
          Wrong;
        end;
      if Map[x, y] <> 0 then
        begin
          Writeln('¤ (', x, ', ', y, ') lµ « cÊm!');
          Wrong;
        end;
      Sx := x; Sy := y;
    end;
  if (x <> 1) and (x <> m) and (y <> 1) and (y <> n) then
    begin
      Writeln('Kh«ng ®i ®­îc ra biªn!');
      Wrong;
    end;
  Close(f);
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  BreadthFirstSearch;
  Result;
  Test;
end.

10 10
XXXXXXXXXX
XXXXXXXXXX
XX.....XXX
XX.XXX.XXX
XX.EXX...X
XXXXXX.X.X
.......X.X
XXXXXXXX.X
.........X
XXXXXXXXXX
