{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}

program ASDF;         {Advanced Optimize Method}
const
 InputFile = 'TL.IN8';
 OutputFile = 'TL.OUT';
 max = 21;
 dx: array[1..4] of integer = ( 0,  1,  0, -1);
 dy: array[1..4] of integer = ( 1,  0, -1,  0);

type
 Cell = record
  x, y: byte;
 end;

var
 A: array[0..max, 0..max] of byte;
 F: array[0..max, 0..max, 0..max] of word;
 Trace: array[0..max, 1..max, 1..max] of byte;
 d: array[1..max, 1..max] of word;
 State: array[0..max, 0..max] of ShortInt;
 CSet: array[0..max, 1..400] of Cell;
 Way: array[1..400] of Cell;
 m, n: word;
 count: word;

procedure Input;
var
 i, j: longint;
 fi: text;
 ch, Fav: char;
begin
 Fillchar(A, SizeOf(A), 0);
 Assign(fi, InputFile);
 Reset(fi);
 Readln(fi, m, n);
 Readln(fi, Fav);
 count := 0;
 for i := 1 to m do
  begin
   for j := 1 to n do
    begin
     Read(fi, ch);
     if ch = Fav then
      begin
       A[i, j] := 1;
       Inc(count);
      end;
    end;
   Readln(fi);
  end;
 Close(fi);
end;

procedure FindF(var u, v: integer);
var
 i, j: longint;
begin
 for i := 1 to m do
  for j := 1 to n do
   if A[i, j] = 1 then
    begin
     u := i;
     v := j;
     Exit;
    end;
end;

procedure Output(k, i, j: byte);
var
 fo: text;
 nt, c, t: longint;
 tp: Cell;
 u, v: integer;
 len: word;
begin
 Len := F[k, i, j];
 Assign(fo, OutputFile);
 Rewrite(fo);
 if count < n then
  begin
   Writeln('NO SOLUTION');
   Close(fo);
   Exit;
  end;
 c := 0;
 Writeln(fo, k);
 while true do
  begin
   Inc(c);
   Way[c].x := i;
   Way[c].y := j;
   if j = 1 then Break;
   t := Trace[k, i, j];
   if t > 4 then
    begin
     Dec(k);
     t := t - 4;
    end;
   i := i - dx[t];
   j := j - dy[t];
  end;
 for i := 1 to c div 2 do
  begin
   tp := Way[i];
   Way[i] := Way[c - i + 1];
   Way[c - i + 1] := tp;
  end;
 for i := 1 to c do
  if A[Way[i].x, Way[i].y] = 1 then A[Way[i].x, Way[i].y] := 0
  else A[Way[i].x, Way[i].y] := 2;
 for i := 1 to c do
  if A[Way[i].x, Way[i].y] = 2 then
   begin
    FindF(u, v);
    Writeln(fo, Way[i].x, ' ', Way[i].y, ' ', u, ' ', v);
    A[Way[i].x, Way[i].y] := 0;
    A[u, v] := 0;
   end;
 Writeln(fo, len);
 for i := 1 to c do
  Writeln(fo, Way[i].x, ' ', Way[i].y);
 Close(fo);
end;

procedure CommonInit;
var
 i, j, c, k: byte;
begin
 Fillchar(State, SizeOf(State), 20);
 Fillchar(CSet, SizeOf(CSet), 0);
 for i := 1 to m + 1 do
  for j := 1 to n + 1 do
   for k := 0 to n do
    F[k, i, j] := MaxInt;
 for i := 0 to m + 1 do
  begin
   A[i, 0] := 5;
   A[i, n + 1] := 5;
  end;
 for j := 0 to n + 1 do
  begin
   A[0, j] := 5;
   A[m + 1, j] := 5;
  end;
 c := 0;
 for i := 1 to m do
  if A[i, 1] = 1 then
   begin
    Inc(c);
    CSet[0, c].x := i;
    CSet[0, c].y := 1;
    F[0, i, 1] := 1;
    State[i, 1] := 0;
   end;
 for i := 0 to m + 1 do
  begin
   State[i, 0] := 30;
   State[i, n + 1] := 30;
  end;
 for j := 0 to n + 1 do
  begin
   State[0, j] := 30;
   State[m + 1, j] := 30;
  end;
end;

function Refine(cp: byte): byte;
var
 Queue: array[1..400] of Cell;
 first, last, min, ct, i, j: word;
 u, v: Cell;
 fp, m2: byte;
begin
 fp := 0;
 min := MaxInt;
 ct := 1;
 while CSet[cp, ct].x <> 0 do Inc(ct);
 Dec(ct);
 j := 0;
 repeat
  Inc(j);
  first := 1;
  last := 1;
  Queue[1] := CSet[cp, j];
  repeat
   u := Queue[first];
   Inc(first);
   if (u.y = n) then
    if F[cp, u.x, u.y] < min then
     begin
      min := F[cp, u.x, u.y];
      fp := u.x;
     end;
   for i := 1 to 4 do
    begin
     v.x := u.x + dx[i];
     v.y := u.y + dy[i];
     if (A[v.x, v.y] = 1)and(F[cp, v.x, v.y] > F[cp, u.x, u.y] + 1)and(F[cp, u.x, u.y] < count) then
      begin
       F[cp, v.x, v.y] := F[cp, u.x, u.y] + 1;
       Trace[cp, v.x, v.y] := i;
       if State[v.x, v.y] <> cp then
        begin
         State[v.x, v.y] := cp;
         Inc(ct);
         CSet[cp, ct] := v;
        end;
       Inc(last);
       Queue[last] := v;
      end;
    end;
  until first > last;
 until j = ct;
 Refine := fp;
end;

procedure UpdateCell(cp: byte);
var
 i, j, c, c2: word;
 u, v: Cell;
 t: byte;
begin
 t := cp + 1;
 c := 0;
 c2 := count - 1;
 for i := 1 to m do
  for j := 1 to n do
   F[t, i, j] := F[cp, i, j];
 i := 1;
 while CSet[cp, i].x <> 0 do
  begin
   u := CSet[cp, i];
   for j := 1 to 4 do
    begin
     v.x := u.x + dx[j];
     v.y := u.y + dy[j];
     if (F[t, v.x, v.y] > F[cp, u.x, u.y] + 1)and
        (A[v.x, v.y] = 0)and(F[cp, u.x, u.y] < count){and(A[v.x, v.y] <> 5)} then
      begin
       Trace[t, v.x, v.y] := j + 4;
       F[t, v.x, v.y] := F[cp, u.x, u.y] + 1;
       if State[v.x, v.y] <> t then
        begin
         State[v.x, v.y] := cp + 1;
         Inc(c);
         CSet[t, c] := v;
        end;
      end;
    end;
   Inc(i);
  end;
end;

procedure OptimizeBase;
var
 k: byte;
 j, i: word;
begin
 k := Refine(0);
 if k <> 0 then
  begin
   Output(0, k, m);
   Halt;
  end;
 UpdateCell(0);
 j := 1;
 while CSet[1, j].x <> 0 do Inc(j);
 for i := 1 to m do
  if (State[i, 1] <> 1)and(A[i, 1] <> 1) then
   begin
    CSet[1, j].x := i;
    CSet[1, j].y := 1;
    Inc(j);
   end;
 for i := 1 to j - 1 do
  if CSet[1, i].y = 1 then
   begin
    F[1, CSet[1, i].x, 1] := 1;
    Trace[1, CSet[1, i].x, 1] := 7;
   end;
end;

procedure Optimize;
var
 i, j, k: byte;
begin
 i := 1;
 OptimizeBase;
 repeat
  k := Refine(i);
  if k <> 0 then Break;
{  for j := 1 to m do State[j, i] := 30;}
  UpdateCell(i);
  Inc(i);
 until false;
 Output(i, k, n);
end;

var
 t1, t2 : longint;

BEGIN
 t1 := Meml[0:$46C];
 Input;
 if count < m then Output(0, 0, 0);
 CommonInit;
 Optimize;
 t2 := Meml[0:$46C];
 Writeln('Time : ', (t2 - t1)/18.23:0:2);
END.
