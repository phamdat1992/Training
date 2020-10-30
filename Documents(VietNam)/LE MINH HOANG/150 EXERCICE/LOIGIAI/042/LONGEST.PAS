{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
program Maximal_Binary_String;
const
 InputFile  = 'BSTR.INP';
 OutputFile = 'BSTR.OUT';
 max = 200;
type
 TStr = String[max];
var
 A, B: TStr;
 m, n: Byte;
 Trace: array[0..max, 0..max] of Byte;

procedure Enter;
var
 fr: Text;
begin
 Assign(fr, InputFile); Reset(fr);
 Readln(fr, A);
 Readln(fr, B);
 Close(fr);
end;

procedure Init;
begin
 m := Length(A); n := Length(B);
end;

function TraceFrom(x, y: Byte): TStr;
var
 S: TStr;
begin
 S := '';
 while (x <> 0) and (y <> 0) do
  begin
   if A[x] = B[y] then S := A[x] + S;
   case Trace[x, y] of
    1: begin
        Dec(x); Dec(y);
       end;
    2: Dec(x);
    3: Dec(y);
   end;
  end;
 TraceFrom := S;
end;

function Above(S1, S2: TStr): Boolean;
begin
 while Length(S1) < Length(S2) do S1 := '0' + S1;
 while Length(S2) < Length(S1) do S2 := '0' + S2;
 Above := S1 > S2;
end;

function GetMax(i, j: Byte): Byte;
var
 S: array[1..3] of TStr;
 k, t: Byte;
begin
 S[1] := TraceFrom(i - 1, j - 1);
 S[2] := TraceFrom(i - 1, j);
 S[3] := TraceFrom(i, j - 1);
 k := 1;
 for t := 2 to 3 do
  if Above(S[t], S[k]) then k := t;
 GetMax := k;
end;

procedure Optimize;
var
 i, j: Byte;
begin
 for i := 1 to m do
  for j := 1 to n do
   if A[i] = B[j] then Trace[i, j] := 1
   else Trace[i, j] := GetMax(i, j);
end;

procedure PrintResult;
var
 f: Text;
begin
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, TraceFrom(m, n));
 Close(f);
end;

begin
 Enter;
 Init;
 Optimize;
 PrintResult;
end.
00000000101000101010
1000000000000010101

110011001100
001100110011
