{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program Number;
const
  fi = 'number.inp';
  fo = 'number.out';
  max = 101;
var
  t: array[0..1, 0..max] of string[max * 2];
  Trace: array[0..max, 0..max] of Byte;
  a, b, c: string;
  m, n: Byte;
  f: Text;

procedure ReadFile;
begin
  Assign(f, fi); Reset(f);
  ReadLn(f, a);
  Read(f, b);
  Close(f);
  while (a <> '') and (a[1] = '0') do Delete(a, 1, 1);
  while (b <> '') and (b[1] = '0') do Delete(b, 1, 1);
  m := Length(a);
  n := Length(b);
end;

function Lower(s1, s2: string): Boolean;
begin
  if Length(s1) < Length(s2) then Lower := True
  else
    if Length(s1) > Length(s2) then Lower := False
    else Lower := s1 < s2;
end;

procedure Optimize;
var
  i, j, f, l: Byte;
begin
  FillChar(t, SizeOf(t), 0);
  f := 1;
  l := 0;
  for j := 1 to n do
  begin
    t[f, j] := Copy(b, 1, j); { p[0, j] := j }
    Trace[0, j] := 2;
  end;
  for i := 1 to m do
  begin
    t[l, 0] := Copy(a, 1, i); { p[i, 0] := i }
    Trace[i, 0] := 1;
    for j := 1 to n do
      if a[i] = b[j] then
      begin
        t[l, j] := t[f, j - 1] + a[i];
        Trace[i, j] := 3;
      end
      else
        if Lower(t[f, j] + a[i], t[l, j - 1] + b[j]) then
        begin
          t[l, j] := t[f, j] + a[i];
          Trace[i, j] := 1;
        end
        else
        begin
          t[l, j] := t[l, j - 1] + b[j];
          Trace[i, j] := 2;
        end;
    f := l;
    l := 1 - f;
  end;
end;

procedure Retrace;
var
  i, j: Byte;
begin
  c := '';
  i := m;
  j := n;
  while (i > 0) or (j > 0) do
  begin
    if Trace[i, j] = 3 then
    begin
      c := a[i] + c;
      Dec(i); Dec(j);
    end
    else
      if Trace[i, j] = 1 then
      begin
        c := a[i] + c;
        Dec(i);
      end
      else
      begin
        c := b[j] + c;
        Dec(j);
      end;
  end;
end;

procedure WriteFile;
begin
  Assign(f, fo); Rewrite(f);
  Write(f, c);
  Close(f);
end;

begin
  ReadFile;
  Optimize;
  Retrace;
  WriteFile;
end.