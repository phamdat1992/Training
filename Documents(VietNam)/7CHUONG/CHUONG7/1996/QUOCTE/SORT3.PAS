PROGRAM SortA3ValuedSequence;
CONST
  mn = 1000;
VAR
  f : Text;
  n, i : Integer;
  X : array [1..mn] of Integer;

TYPE
  SoLuong = record
    A, B, C : Integer;
  end;

PROCEDURE Dem( a, b : Integer; var sl : SoLuong );
  Var
    i : Integer;
  Begin
    sl.A := 0;
    sl.B := 0;
    sl.C := 0;
    for i := a to b do case X[i] of
      1: Inc(sl.A);
      2: Inc(sl.B);
      3: Inc(sl.C);
    end;
  End;

FUNCTION min( a, b : Integer ) : Integer;
  Begin if a < b then min := a else min := b End;

VAR
  sl1, sl2, sl3, sl : SoLuong;
  b, c : Integer;

PROCEDURE Exchange( p, q : Integer );
  Var t : Integer;
  Begin
    WriteLn( f, p:4, q:4 );
    t := X[p]; X[p] := X[q]; X[q] := t;
  End;

PROCEDURE Doi( a1, b1, a2, b2, tp1, tp2 : Integer );
  Var
    i, j : Integer;
  Begin
    j := a2;
    for i := a1 to b1 do if X[i] = tp2 then
    begin
      while (j <= b2) and (X[j] <> tp1) do Inc(j);
      if j > b2 then Break;
      Exchange( i, j );
    end;
  End;

PROCEDURE Ep1;
  Var
    i, j : Integer;
  Begin
    j := b+1;
    for i := 1 to b do if X[i] <> 1 then
    begin
      while (j <= n) and (X[j] <> 1) do Inc(j);
      Exchange(i,j);
    end;
  End;

BEGIN
  Assign( f, 'W96_4.INP' );
  Reset(f);
  ReadLn( f, n );
  for i := 1 to n do ReadLn( f, X[i] );
  Close(f);

  Dem( 1, n, sl );
  b := sl.A;
  c := sl.A+sl.B;
  Dem( 1, b, sl1 );
  Dem( b+1, c, sl2 );
  Dem( c+1, n, sl3 );

  Assign( f, 'W96_4.OUT' );
  Rewrite(f);

  WriteLn( f, min(sl2.A,sl1.B)+
              min(sl1.C,sl3.A)+
              min(sl2.C,sl3.B)+
              2*abs(sl2.A-sl1.B) );

  Doi( 1, b, b+1, c, 1, 2 );
  Doi( 1, b, c+1, n, 1, 3 );
  Doi( b+1, c, c+1, n, 2, 3 );
  Ep1;
  Doi( b+1, c, c+1, n, 2, 3 );

  Close(f);
END.