PROGRAM JobProcessing;
CONST
  mn = 1000;
  mm1 = 30;
  mm2 = 30;
  mt = 20;

VAR
  N : Integer;
  M1, M2 : Integer;
  A, B, tA, tB : array [1..mm1] of Integer;
  T : array [1..mn] of Integer;

FUNCTION max( x, y : Integer ) : Integer;
  Begin if x > y then max := x else max := y end;

FUNCTION min( x, y : Integer ) : Integer;
  Begin if x < y then min := x else min := y end;

PROCEDURE QSort( l, r : Integer );
  Var
    ll, rr : Integer;
    z, x : Integer;
  Begin
    ll := l; rr := r; z := T[(l+r) div 2];
    repeat
      while (ll <= rr) and (T[ll] < z) do Inc(ll);
      while (ll <= rr) and (T[rr] > z) do Dec(rr);
      if ll <= rr then
      begin
        x := T[ll]; T[ll] := T[rr]; T[rr] := x;
        Inc(ll); Dec(rr);
      end;
    until ll > rr;
    if l < rr then QSort( l, rr );
    if ll < r then QSort( ll, r );
  End;

PROCEDURE Init;
  Var
    i, j, k : Integer;
  Begin
    k := 0;
    for i := 1 to m1 do if A[i] <> 0 then
    begin
      for j := 1 to A[i] div tA[i] do T[k+j] := j*tA[j];
      Inc( k, A[i] div tA[i] );
    end;
    QSort( 1, n );
  End;


FUNCTION XepDuoc( x : Integer ) : Boolean;
  Var
    ii, i, j : Integer;

  Begin
    XepDuoc := False;

    for i := 1 to m2 do B[i] := 0;

    for ii := 1 to N do
    begin
      j := 0;
      for i := 1 to m2 do
        if max( B[i], T[ii] )+tB[i] <= x then begin j := i; Break end;

      if j = 0 then Exit;

      for i := j+1 to m2 do
        if (max( B[i], T[ii] )+tB[i] <= x) and
           (max( B[i], T[ii] )+tB[i] > max( B[j], T[ii] )+tB[j]) then j := i;

      B[j] := max( B[j], T[ii] )+tB[j];
    end;

    XepDuoc := True;
  End;


FUNCTION Find( p, q : Integer ) : Integer;
  Begin
    if (p = q-1) or (p = q) then Find := q
    else if XepDuoc( (p+q) div 2 ) then Find := Find( p, (p+q) div 2 )
    else Find := Find( (p+q) div 2, q );
  End;


VAR
  f : Text;
  ii, i, j : Integer;
  x : Integer;
  p, q : Integer;


BEGIN
  Assign( f, 'W96_1.INP' );
  Reset(f);
  ReadLn( f, n );
  ReadLn( f, m1 );
  for i := 1 to m1 do Read( f, tA[i] );
  ReadLn(f);
  ReadLn( f, m2 );
  for i := 1 to m2 do Read( f, tB[i] );
  ReadLn(f);
  Close(f);

  for i := 1 to m1 do A[i] := 0;

  for ii := 1 to n do
  begin
    j := 1;
    for i := 2 to m1 do if A[i]+tA[i] < A[j]+tA[j] then j := i;
    Inc( A[j], tA[j] );

    x := A[j];

    j := 1;
    for i := 2 to m2 do if max( B[i], x )+tB[i] < max( B[j], x )+tB[j] then j := i;
    B[j] := max( B[j], x )+tB[j];
  end;

  Assign( f, 'W96_1.OUT' );
  Rewrite(f);

  j := 1;
  for i := 2 to m1 do if A[i] > A[j] then j := i;
  WriteLn( f, A[j] );

  p := A[j];
  j := 1;
  for i := 2 to m2 do if B[i] > B[j] then j := i;
  q := B[j];

  Init;
  WriteLn( f, Find( p, q ) );

  Close(f);
END.