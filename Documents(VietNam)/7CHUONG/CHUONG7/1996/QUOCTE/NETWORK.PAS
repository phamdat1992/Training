PROGRAM NetworkOfSchools;
CONST
  mn = 100;

VAR
  f : Text;
  n : Integer;
  A : array [1..mn,1..mn] of Byte;
  giu : array [1..mn] of Boolean;

FUNCTION SoDen( i : Integer ) : Integer;
  Var
    j, S : Integer;
  Begin
    S := 0;
    for j := 1 to n do if (i <> j) and giu[j] and (A[j,i] = 1) then Inc(S);
    SoDen := S;
  End;

FUNCTION SoDi( i : Integer ) : Integer;
  Var
    j, S : Integer;
  Begin
    S := 0;
    for j := 1 to n do if (i <> j) and giu[j] and (A[i,j] = 1) then Inc(S);
    SoDi := S;
  End;

PROCEDURE Khu;
  Var
    i, j, k : Integer;
  Begin
    for i := 1 to n do if giu[i] and (SoDen(i) > 0) and (SoDi(i) > 0) then
    begin
      giu[i] := False;
      for j := 1 to n do for k := 1 to n do
        if (A[j,i] = 1) and (A[i,k] = 1) then A[j,k] := 1;
    end;
  End;

FUNCTION SoDinhDen : Integer;
  Var
    i, S : Integer;
  Begin
    S := 0;
    for i := 1 to n do if giu[i] and (SoDi(i) = 0) then Inc(S);
    SoDinhDen := S;
  End;

FUNCTION SoDinhDi : Integer;
  Var
    i, S : Integer;
  Begin
    S := 0;
    for i := 1 to n do if giu[i] and (SoDen(i) = 0) then Inc(S);
    SoDinhDi := S;
  End;


VAR
  i, j : Integer;
  ok : Boolean;

BEGIN
  Assign( f, 'W96_2.INP' );
  Reset(f);
  ReadLn( f, n );
  for i := 1 to n do for j := 1 to n do A[i,j] := 0;
  for i := 1 to n do giu[i] := True;
  for i := 1 to n do
  begin
    Read( f, j );
    while j <> 0 do
    begin
      A[i,j] := 1;
      Read( f, j );
    end;
    ReadLn(f);
  end;
  Close(f);

  Assign( f, 'W96_2.OUT' );
  Rewrite(f);
  Khu;
  i := SoDinhDen;
  j := SoDinhDi;
  WriteLn( f, j );
  if i > j then WriteLn( f, i ) else WriteLn( f, j );
  Close(f);

  Assign( f, 'W96_2.OU2' );
  Rewrite(f);
  for i := 1 to n do if giu[i] then A[i,i] := 1;

  repeat
    ok := True;
    for i := 1 to n do if giu[i] and (SoDi(i) = 0) then
    begin
      for j := 1 to n do if giu[j] and (SoDen(j) = 0) and (A[j,i] = 0) then
      begin
        ok := False;
        A[i,j] := 1;
        WriteLn( f, i:4, j:4 );
        Khu;
        Break
      end;
      if not ok then Break;
    end;
  until ok;

  repeat
    ok := True;
    for i := 1 to n do if giu[i] and (SoDi(i) = 0) then
    begin
      for j := 1 to n do if (i <> j) and giu[j] and (SoDen(j) = 0) then
      begin
        ok := False;
        A[i,j] := 1;
        WriteLn( f, i:4, j:4 );
        Khu;
        Break
      end;
      if not ok then Break
    end;
  until ok;

  Close(f);
END.