{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
program Money;
const
 InputFile  = 'MONEY.INP';
 OutputFile = 'MONEY.OUT';
 max = 100;
var
 a: array[1..max, 1..max] of Real;
 d: array[1..max] of Real;
 Trace: array[1..max] of Byte;
 Found: Byte;
 n: Byte;

procedure Enter;
var
 f: Text;
 i, j: Integer;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n);
 for i := 1 to n do
  begin
   for j := 1 to n do
    begin
     Read(f, a[i, j]);
     a[i, j] := Ln(a[i, j]);
    end;
   Readln(f);
  end;
 Close(f);
end;

function TraceFrom(d: Byte; CheckV: Byte): Boolean;
begin
 repeat
  if d = CheckV then
   begin
    TraceFrom := True;
    Exit;
   end;
  d := Trace[d];
 until d = 0;
 TraceFrom := False;
end;

procedure Ford_Bellman;
var
 i, j, k: Integer;
 Stop: Boolean;
begin
 for i := 1 to n do
  begin
   d[i] := 0; Trace[i] := 0;
  end;
 for k := 1 to n do
  begin
   Stop := True;
   for i := 1 to n do
    for j := 1 to n do
     if (d[j] < d[i] + a[i, j]) then
      begin
       Stop := False;
       Trace[j] := i;
       d[j] := d[i] + a[i, j];
       if TraceFrom(i, j) then
        begin
         Found := j;
         Exit;
        end;
      end;
   if Stop then Break;
  end;
 Found := 0;
end;

procedure Result;
var
 f: Text;
 i: Byte;
 S: array[1..max] of Byte;
 ns: Byte;
 M: Real;
begin
 Assign(f, OutputFile); Rewrite(f);
 if Found <> 0 then
  begin
   Writeln(f, 'YES');
   ns := 0;
   i := Found;
   repeat
    Inc(ns); s[ns] := i;
    i := Trace[i];
   until i = Found;
   Inc(ns); s[ns] := Found;
   M := 0;
   for i := ns downto 2 do M := M + a[s[i], s[i - 1]];
   Writeln(f, Found, ' ', Exp(M) - 1:1:6);
   for i := ns downto 2 do Write(f, s[i], ' ');
  end
 else
  Writeln(f, 'NO');
 Close(f);
end;

begin
 Enter;
 Ford_Bellman;
 Result;
end.

3
1 0.7 9.1
1.2 1 9.5
0.15 0.1 1
