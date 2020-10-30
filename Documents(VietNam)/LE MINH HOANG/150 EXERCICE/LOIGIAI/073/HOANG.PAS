{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program DSAP;
const
 InputFile = 'NUMBER.INP';
 OutputFile = 'NUMBER.OUT';
 max = 200;
type
 Str200 = string[201];
 StrArr = array[0..max] of Str200;
 ByteArr = array[0..max, 0..max] of byte;
var
 sn1, sn2: Str200;
 F: array[0..max, 0..max] of byte;
 Trace: ^ByteArr;
 cur, last: word;
 S: array[1..2] of ^StrArr;

procedure Input;
var
 fi: text;
 i: word;
begin
 Assign(fi, InputFile);
 Reset(fi);
 Readln(fi, sn1);
 Readln(fi, sn2);
 Close(fi);
end;

function ReTrace(i, j: word): Str200;
var
 st: Str200;
 t: word;
begin
 st := '';
 repeat
  t := Trace^[i, j];
  case t of
   1: begin
       Dec(j);
      end;
   2: begin
       Dec(i);
      end;
   3: begin
       st := sn1[i] + st;
       Dec(i);
       Dec(j);
      end;
   0: Break;
  end;
 until i * j = 0;
 Retrace := st;
end;

procedure Swap(var a, b: word);
var
 c: word;
begin
 c := a;
 a := b;
 b := c;
end;

procedure Init;
var
 i: word;
begin
 New(S[1]);
 New(S[2]);
 New(Trace);
 FillChar(S[1]^, SizeOf(S[1]^), 0);
 FillChar(S[2]^, SizeOf(S[2]^), 0);
 FillChar(F, SizeOf(F), 0);
 while sn1[1] = '0' do Delete(sn1, 1, 1);
 while sn2[1] = '0' do Delete(sn2, 1, 1);
end;

procedure Optimize2;
var
 i, j: word;
begin
 cur := 1;
 last := 2;
 for i := 1 to length(sn1) do
  begin
   for j := 1 to length(sn2) do
    if sn1[i] = sn2[j] then
     begin
      F[i, j] := F[i - 1, j - 1] + 1;
      Trace^[i, j] := 3;
      S[cur]^[j] := S[last]^[j - 1] + sn1[i];
     end
    else
     begin
      if F[i, j - 1] > F[i - 1, j] then
       begin
        F[i, j] := F[i, j - 1];
        S[cur]^[j] := S[cur]^[j - 1];
        Trace^[i, j] := 1;
       end
      else
       if F[i - 1, j] > F[i, j - 1] then
        begin
         F[i, j] := F[i - 1, j];
         S[cur]^[j] := S[last]^[j];
         Trace^[i, j] := 2;
        end
       else
        begin {=}
         if S[last]^[j] > S[cur]^[j - 1] then
          begin
           F[i, j] := F[i - 1, j];
           S[cur]^[j] := S[last]^[j];
           Trace^[i, j] := 2;
          end
         else
          begin
           F[i, j] := F[i, j - 1];
           S[cur]^[j] := S[cur]^[j - 1];
           Trace^[i, j] := 1;
          end;
        end;
     end;
   Swap(cur, last);
  end;
end;

function SuperTrace: Str200;
var
 i, j, li, lj: word;
 maxlen: word;
 ts: String;
begin
 if S[last]^[length(sn2)][1] <> '0' then
  begin
   SuperTrace := S[last]^[length(sn2)];
   Exit;
  end;
 maxlen := 0;
 for i := 1 to length(sn1) do
  for j := 1 to length(sn2) do
   begin
    ts := ReTrace(i, j);
    if (ts[1] <> '0')and(F[i, j] > maxlen) then
     begin
      maxlen := F[i, j];
      li := i;
      lj := j;
     end;
   end;
 SuperTrace := ReTrace(li, lj);
end;

procedure Output;
var
 fo: text;
begin
 Assign(fo, OutputFile);
 Rewrite(fo);
 Writeln(fo, SuperTrace);
 Close(fo);
end;

BEGIN
 Input;
 Init;
 Optimize2;
 Output;
END.