program Ngoac;
const
 OutputFile = 'NGOAC.OUT';
 max = 254;
var
 X: string;
 T, C: array[0..max] of Integer;
 n, k: Integer;
 f: Text;
 Count: LongInt;
 Start: LongInt;
 Time: LongInt absolute 0:$46C;

procedure Enter;
begin
 Writeln('n la do dai chan < 254, k la do sau < n/2');
 Write('n, k = '); Readln(n, k);
end;

procedure Init;
begin
 T[0] := 0;
 C[0] := 0;
 X[0] := Chr(n);
 Assign(f, OutputFile); Rewrite(f);
 Count := 0;
end;

procedure Inkq;
begin
 Inc(Count);
 Writeln(f, X);
end;

procedure Try(i: Byte);
begin
 if (T[i - 1] < k) and (T[i - 1] + 1 <= n - i) then {Mo ngoac}
  begin
   X[i] := '(';
   T[i] := T[i - 1] + 1;
   if C[i - 1] < T[i] then C[i] := T[i]
   else C[i] := C[i - 1];
   Try(i + 1);
  end;
 if (T[i - 1] > 0) and
    ((C[i - 1] = k) or (k + k - T[i - 1] + 1 + i <= n))
     then {Dong ngoac}
  begin
   X[i] := ')';
   T[i] := T[i - 1] - 1;
   C[i] := C[i - 1];
   if (i = n) then Inkq
   else Try(i + 1);
  end;
end;

begin
 Enter;
 Start := Time;
 Write('Ghi ket qua vao file ', OutputFile, '...');
 Init;
 Try(1);
 Close(f);
 Writeln('Co ', Count, ' nghiem');
 Writeln('Time = ', (Time - Start) / 18.2:1:2, ' (s)');
 Write('Press <Enter>');
 Readln;
end.
