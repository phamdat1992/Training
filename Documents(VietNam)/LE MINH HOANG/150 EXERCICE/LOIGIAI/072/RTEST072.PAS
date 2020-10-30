program RandomTest;
const
  InputFile  = 'PHONE.IN';
  maxL = 50;
  narray: array[2..10] of Integer = (20, 30, 40, 50, 60, 70, 80, 90, 100);
  marray: array[2..10] of Word = (100, 1000, 2000, 3000, 5000, 10000, 32768, 40000, 50000);
  carray: array[2..10] of Char = '234567890';
var
  T, S: String;
  ch: Char;
  i, j: LongInt;
  L: array['a'..'z'] of Integer;
  fr, fw: Text;
  n, m: LongInt;
  cs: Integer;

function RandomS: String;
var
  S: String;
  l, i: Integer;
begin
  l := Random(maxL) + 1;
  S := '';
  for i := 1 to l do S := S + Chr(97 + Random(26));
  RandomS := S;
end;

begin
  Randomize;
  for cs := 2 to 10 do
    begin
      Writeln(InputFile + carray[cs]);
      {------ Tao anh xa cac so-------}
      S := '';
      for ch := 'a' to 'z' do S := S + ch;
      for i := 0 to 9 do
        begin
          j := Random(Length(S)) + 1;
          L[S[j]] := i;
          Delete(S, j, 1);
        end;
      for i := 1 to Length(S) do L[S[i]] := Random(10);
      Assign(fw, '1.$$$'); Rewrite(fw);
      for i := 0 to 9 do
        begin
          for ch := 'a' to 'z' do
            if L[ch] = i then Write(fw, ch);
          Writeln(fw);
        end;
      Close(fw);
      Assign(Fw, '2.$$$'); Rewrite(fw);
      n := narray[cs]; m := marray[cs];
      T := '';
      for i := 1 to m do
        begin
          S := RandomS;
          Writeln(fw, S);
          if (Length(S) < n div 3) and (Length(T + S) <= n) and (Random(10) = 1) then T := T + S;
        end;
      Close(fw);
      if T = '' then T := S;
      Assign(fw, InputFile + carray[cs]); Rewrite(fw);
      Assign(fr, '1.$$$'); Reset(fr);
      for i := 0 to 9 do
        begin
          Readln(fr, S);
          Writeln(fw, S);
        end;
      for i := 1 to Length(T) do Write(fw, L[T[i]]);
      Writeln(fw);
      Close(fr);
      Assign(fr, '2.$$$'); Reset(fr);
      while not SeekEof(fr) do
        begin
          Readln(fr, S);
          Writeln(Fw, S);
        end;
      Close(fr);
      Write(fw, '#');
      Close(fw);
  end;
end.
