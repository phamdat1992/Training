program Note;
const
 InputFile  = 'NOTE.INP';
 OutputFile = 'NOTE.OUT';
 max = 2000;
type
 Str20 = String[20];
 CharSet = set of Char;
var
 A: array['a'..'z', 'a'..'z'] of Boolean;
 Deg: array['a'..'z'] of Byte;
 ChSet: CharSet;
 n: Integer;
 result : String;

procedure Init;
begin
 FillChar(A, SizeOf(A), False);
 ChSet := [];
 FillChar(Deg, SizeOf(Deg), 0);
end;

procedure AddOrder(S1, S2: Str20);
var
 i, l: Byte;
begin
 if Length(S1) > Length(S2) then l := Length(S2) else l := Length(S1);
 i := 1;
 while (i <= l) and (S1[i] = S2[i]) do Inc(i);
 if (i <= l) and not A[S1[i], S2[i]] then
  begin
   A[S1[i], S2[i]] := True;
   Inc(Deg[S2[i]]);
  end;
end;

procedure AddCharSet(S: Str20);
var
 i: Byte;
begin
 for i := 1 to Length(S) do ChSet := ChSet + [S[i]];
end;

procedure Enter;
var
 f: Text;
 i: Integer;
 S, T: String;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n);
 Readln(f, S);
 AddCharSet(S);
 for i := 2 to n do
  begin
   Readln(f, T);
   AddOrder(S, T);
   S := T;
   AddCharSet(S);
  end;
 Close(f);
end;

procedure Solve;
var
 ch, i, j: Char;
begin
 result := '';
 repeat
  for i := 'a' to 'z' do
   if (i in ChSet) and (Deg[i] = 0) then
    begin
     result := result + i;
     for j := 'a' to 'z' do
      if A[i, j] then Dec(Deg[j]);
     ChSet := ChSet - [i];
    end;
 until ChSet = [];
end;

procedure WriteResult;
var
 f: Text;
begin
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, result);
 Close(f);
end;

begin
 Init;
 Enter;
 Solve;
 WriteResult;
end.
10
svxngqqnsnvqv
snngg
qsqsqvgsqq
qqns
qnvq
nsxnxnvsqsvvs
nqg
nn
xsgvsgggqvsqqsxgv
xxgxxggsvnxsnxsnqq
