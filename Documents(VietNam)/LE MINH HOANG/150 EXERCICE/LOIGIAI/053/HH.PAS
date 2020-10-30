{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}

program ASDF;
const
 InputFile = 'MAP.INP';
 OutputFile = 'MAP.OUT';
 max = 5001;
 dx: array[1..4] of integer = (-1,  0,  0,  1);
 dy: array[1..4] of integer = ( 0,  1, -1,  0);
 Direction: string[4] = 'NEWS';

type
 Point = record
  x, y: integer;
 end;
 Ar1 = array[1..max, 1..4] of word;

var
 A: array[1..max] of word;
 Pos: array[1..max] of Point;
 Queue: array[1..max] of word;
 DirTrace: array[1..max] of byte;
 IndTrace: array[1..max] of word;
 Deg: ^Ar1;
 n, endp: word;

procedure Init;
var
 i, j, oid: word;
 d: byte;
 ch: char;
 cp: Point;
 fi: text;
 b: boolean;
begin
 Assign(fi, InputFile);
 Reset(fi);
 n := 1;
 oid := 1;
 New(Deg);
 Fillchar(Deg^, SizeOf(Deg^), 0);
 cp.x := 0;
 cp.y := 0;
 while not Eof(fi) do
  begin
   Inc(n);
   Read(fi, ch);
   case ch of
    'N': d := 1;
    'S': d := 4;
    'E': d := 2;
    'W': d := 3;
   end;
   Inc(cp.x, dx[d]);
   Inc(cp.y, dy[d]);
   b := true;
   for j := 1 to n - 1 do
    if (Pos[j].x = cp.x)and(Pos[j].y = cp.y) then
     begin
      Deg^[oid, d] := j;
      Deg^[j, 5 - d] := oid;
      Dec(n);
      b := false;
      oid := j;
      Break;
     end;
   if b then
    begin
     Pos[n] := cp;
     Deg^[oid, d] := n;
     Deg^[n, 5 - d] := oid;
     oid := n;
    end;
  end;
 endp := oid;
 Close(fi);
end;

procedure BFS(start, finish: word);
var
 first, last: word;
 u, v, i, j: word;
begin
 Fillchar(IndTrace, SizeOf(IndTrace), 0);
 IndTrace[start] := n + 1;
 first := 1;
 last := 1;
 Queue[1] := start;
 repeat
  u := Queue[first];
  Inc(first);
  for i := 1 to 4 do
   begin
    v := Deg^[u, i];
    if (v <> 0)and(IndTrace[v] = 0) then
     begin
      IndTrace[v] := u;
      DirTrace[v] := 5 - i;
      if v = finish then Exit;
      Inc(last);
      Queue[last] := v;
     end;
   end;
 until first > last;
end;

procedure Done;
var
 i, j: word;
 fo: text;
begin
 Assign(fo, OutputFile);
 Rewrite(fo);
 i := endp;
 while i <> 1 do
  begin
   Write(fo, Direction[DirTrace[i]]);
   i := IndTrace[i];
  end;
 Close(fo);
end;

BEGIN
 Init;
 BFS(1, endp);
 Done;
END.
EEENNWSEENWSSSWW
EEEENWWSSSSSSENNNNN
EEWWSN
NWNSENSWESNWEESENSSENNNEEEEWWSNSNSSWWEEEEE
EEWWNWNSENSWESNWEESENSSENNNE
