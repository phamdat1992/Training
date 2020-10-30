const
 InputFile = 'ROBOT.INP';
 OutputFile = 'ROBOT.OUT';
 max = 101;
var
 A: array[0..max, 0..max] of byte;
 m, n: word;c:char;
 F: array[0..max, 0..max] of byte;
 X, Y: array[0..max] of byte;
 cc, rc: word;
 P: array[0..max, 1..max] of byte;
 T: array[1..max, 1..2] of byte;
procedure Input;
var
 fi: text;
 i, j: word;
begin
 Assign(fi, InputFile);
 Reset(fi);
 FillChar(A, SizeOf(A), 0);
 Readln(fi, m, n);
 rc := 0;
 for i := 1 to m do
  begin
   for j := 1 to n do
    begin
     Read(fi, A[i, j]);
     if A[i, j] = 1 then
      begin
       X[i] := 1;
       Y[j] := 1;
       Inc(rc);
      end;
    end;
   Readln(fi);
  end;
 Close(fi);
end;
procedure tim;
var
 rp, lp: word;
 mm, i, j: word;
 co: boolean;
begin
 FillChar(P, SizeOf(P), 0);
 cc := 0;
 for i := 1 to m do
  begin
   co := false;
   for j := n downto 1 do
    begin
     if A[i, j] = 1 then
      begin
       if co = false then mm := j;
       co := true;
      end;
     if P[i - 1, j] > 0 then
      if co then
       begin
        P[i, mm] := P[i - 1, j];
        co := false;
       end
      else
       begin
        P[i, j] := P[i - 1, j];
       end;
    end;
   if co then
    begin
     Inc(cc);
     P[i, mm] := cc;
     T[cc, 1] := i;
     T[cc, 2] := mm;
    end;
  end;
end;
function Retrace(i: word): string;
var
 pt, x, y: word;
 st: string;
begin
 x := T[i, 1];
 y := T[i, 2];
 pt := P[T[i, 1], T[i, 2]];
 st := '';
 for i := 1 to x - 1 do st := st + 'D';
 for i := 1 to y - 1 do st := st + 'R';
 for i := x + 1 to m do
  begin
   st := st + 'D';
   while P[i, y] <> pt do
    begin
     Inc(y);
     st := st + 'R';
    end;
  end;
 for i := y + 1 to n do
  st := st + 'R';
 Retrace := st;
end;
procedure Output;
var
 i: word;
 fo: text;
begin
 Assign(fo, OutputFile);
 Rewrite(fo);
 Writeln(fo, cc);
 for i := 1 to cc do
  Writeln(fo, Retrace(i));
 Close(fo);
end;
BEGIN
 Input;
 tim;
 Output;
END.