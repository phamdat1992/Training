{$A+,B-,D+,E-,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
program Chambai058;
uses Crt;
const
  InputFile: string = 'NGOAC.IN';
  OutputFile = 'NGOAC.OUT';
  maxn = 64;
  maxk = 32;
  maxCount = 100;
var
  F, G: array[0..maxn, 0..maxk] of Comp; {Bang phuong an quy hoach dong}
  S: array[1..102] of String;
  ns, n, k: Integer;
  Result: Comp;
  ch: Char;

procedure Enter;
var
  f: Text;
begin
  TextMode(C80);
  TextAttr := 7; Clrscr;
  Writeln('                            Cham bai day ngoac');
  Writeln('                            ßßßßßßßßßßßßßßßßßß');
  Write('Test NGOAC.IN'); ch := Readkey; Writeln(ch);
  Assign(f, InputFile + ch); Reset(f);
  Readln(f, n, k);
  Close(f);
end;

procedure Init;
begin
  FillChar(F, SizeOf(F), 0);
  FillChar(G, SizeOf(G), 0);
  F[0, 0] := 1;
  G[0, 0] := 1;
end;

procedure Optimize;
var
  i, j, t: Integer;
begin
  t := k - 1;
  for i := 1 to n do
    for j := 0 to k do
      begin
        if j > 0 then
          begin
            F[i, j] := F[i - 1, j - 1];
            G[i, j] := G[i - 1, j - 1];
          end;
        if j < k then F[i, j] := F[i, j] + F[i - 1, j + 1];
        if j < t then G[i, j] := G[i, j] + G[i - 1, j + 1];
      end;
end;

procedure Solve;
begin
  Init;
  Optimize;
  Result := F[n, 0] - G[n, 0];
end;

function CheckNumber: Boolean;
var
  Err: Integer;
  Number: Comp;
begin
  Write('Kiem tra so luong...');
  while (Length(S[1]) > 1) and (S[1][1] = '0') do Delete(S[1], 1, 1);
  Val(S[1], Number, Err);
  if Err <> 0 then
    begin
      Writeln('Dong 1 khong la so: ', S[1]);
      CheckNumber := False;
      Exit;
    end;
  if ns >= 1 then Move(S[2], S[1], (ns - 1) * SizeOf(S[1]));
  Dec(ns);
  if Number <> Result then
    begin
      Writeln('Khong dung so luong');
      Writeln('Ket qua dung: ', Result:1:0);
      Writeln('Ket qua hs  : ', Number:1:0);
      CheckNumber := False;
      Exit;
    end;
  Writeln(Result:20:0, ' Correct!');
  CheckNumber := True;
end;

function OK(S: String): Boolean;
var
  i, t, depth: Integer;
begin
  t := 0; depth := 0;
  for i := 1 to Length(S) do
    begin
      if S[i] = '(' then Inc(t)
      else
        if S[i] = ')' then Dec(t)
        else t := -32768;
      if t > depth then depth := t;
      if (t < 0) or (depth > k) then
        begin
          OK := False;
          Exit;
        end;
    end;
  OK := (t = 0) and (Length(S) = n) and (depth = k);
end;

function CheckString: Boolean;
var
  i, j, Count: Integer;
begin
  Write('Kiem tra cac day ...');
  if Result > maxCount then Count := maxCount
  else Count := Trunc(Result);
  if ns <> Count then
    begin
      Writeln('So day ngoac trong file khong dung');
      Writeln('So luong can in    : ', Count);
      Writeln('So luong trong file: ', ns);
      CheckString := False;
      Exit;
    end;
  for i := 1 to ns do
    if not OK(S[i]) then
      begin
        Writeln('Day ngoac thu ', i, ' khong dung');
        Writeln(S[i]);
        CheckString := False;
        Exit;
      end;
  for i := 1 to ns do
    for j := i + 1 to ns do
      if S[i] = S[j] then
        begin
          Writeln('Day ngoac thu ', i, ' va ', j, ' trung nhau');
          CheckString := False;
          Exit;
        end;
  Writeln('':20, ' Correct!');
  CheckString := True;
end;

procedure Test;
var
  fout, Bienban: Text;
  Correct, thua: Boolean;
  p1, p2: Real;
  i: Integer;
begin
  {$I+}
  Assign(fout, OutputFile); Reset(fout);
  ns := 0;
  thua := False;
  while not eof(fout) do
    begin
      Inc(ns);
      Readln(fout, S[ns]);
      if ns <> 1 then
        for i := Length(S[ns]) downto 1 do
          if S[ns][i] = ' ' then
            begin
              Delete(S[ns], i, 1);
              Thua := True;
            end;
    end;
  while (ns > 0) and (S[ns] = '') do Dec(ns);
  Close(fout);
  Erase(fout);
  Correct := CheckNumber;
  if Correct then p1 := 0.5 else p1 := 0;
  TextAttr := 78;
  Writeln('Diem = ', p1:2:1);
  TextAttr := 7;
  Correct := CheckString;
  if Correct then p2 := 0.5 else p2 := 0;
  TextAttr := 78;
  Writeln('Diem = ', p2:2:1);
  TextAttr := 7;
  Writeln;
  Writeln;
  TextAttr := 30;
  Writeln('Diem cho test ', InputFile, ch, ': ', p1 + p2 :5:1);
  Assign(fout, 'BIENBAN.TXT');
  if ch <> '1' then Append(fout)
  else Rewrite(fout);
  Write(fout, 'Diem cho test ', InputFile, ch, ': ', p1 + p2 :5:1);
  if thua then Writeln(fout, '   THUA DAU CACH')
  else Writeln(fout);
  Close(fout);
end;

begin
  Enter;
  Solve;
  Test;
  if Readkey = #0 then;
  TextAttr := 7;
  Writeln;
end.
