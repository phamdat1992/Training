{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

program HH;
const
 InputFName = 'FIBISTR.INP';
 OutputFName = 'FIBISTR.OUT';

var
 F1: array[1..35] of longint;
 F2: array[1..35] of longint;
 F3: array[1..35] of longint;
 S: array[1..13] of string[250];
 fi, fo: text;
 i: longint;

procedure Init;
var
 i: word;
begin
 F1[1] := 1;
 F1[2] := 1;
 for i := 3 to 35 do
  F1[i] := F1[i - 1] + F1[i - 2];

 F2[1] := 1;
 F2[2] := 1;
 for i := 3 to 35 do
  if i mod 2 = 1 then F2[i] := F2[i - 1] + F2[i - 2] + 1
  else F2[i] := F2[i - 1] + F2[i - 2];

 F3[1] := 1;
 F3[2] := 2;
 for i := 3 to 35 do
  F3[i] := F3[i - 1] + F3[i - 2] + 1;

 S[1] := 'A';
 S[2] := 'B';
 for i := 3 to 13 do
  S[i] := S[i - 1] + S[i - 2];
end;

procedure OpenFiles;
begin
 Assign(fi, InputFName);
 Reset(fi);
 Assign(fo, OutputFName);
 Rewrite(fo);
end;

function Find(var st: string; t: byte): byte;
var
 i, j: word;
 p, leng: byte;
begin
 if t > 13 then t := 13;
 leng := Length(st);
 p := 0;
 j := 1;
 while F1[j] < leng do Inc(j);
 for i := j to t do
  begin
   p := Pos(st, S[i]);
   if p <> 0 then
    begin
     Find := i;
     Exit;
    end;
  end;
 Find := 0;
end;

function Analyze(var st: string; t: byte): longint;
var
 p: byte;
 c: longint;
 b1, b2: boolean;
begin
 if st = 'A' then
  begin
   if t = 1 then Analyze := 1
   else
    if t = 2 then Analyze := 0
    else Analyze := F1[t - 2];
   Exit;
  end;

 if st = 'B' then
  begin
   Analyze := F1[t - 1];
   Exit;
  end;

 if Pos('AA', st) <> 0 then
  begin
   Analyze := 0;
   Exit;
  end;

 p := Find(st, t);
 if p = 0 then
  begin
   Analyze := 0;
   Exit;
  end;

 if Pos(st, S[p-2] + S[p-1]) <> 0 then b1 := true
 else b1 := false;

 if Pos(st, S[p - 1] + S[p - 1])  <> 0 then b2 := true
 else b2 := false;

 if b1 and b2 then Analyze := F3[t - p + 1]
 else
  if b1 or b2 then Analyze := F2[t - p + 1]
  else Analyze := F1[t - p + 1];

end;

procedure Process;
var
 t: byte;
 ch: char;
 st: string;
begin
 i := 0;
 while not Eof(fi) do
  begin
   Inc(i);
   Readln(fi, t, ch, st);
   Writeln(fo, Analyze(st, t));
  end;
 Close(fi);
 Close(fo);
end;

BEGIN
 Init;
 OpenFiles;
 Process;
END.
5 BBBBBBBBBBBBBBBBBBBBBB
