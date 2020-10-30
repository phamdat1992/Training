{$r-,q-}
PROGRAM Xin_chu_ky ;
Const   maxM             = 101 ;
        maxN             = 501 ;
        Fi               = 'sign.in6' ;
        Fo               = 'sign.out' ;

Type    tang             = Array [0..maxN] of Longint ;
        tru              = Array [0..maxN] of Integer ;
        tr               = Array [0..maxM] of ^tru ;

Var     C ,D             : Array [0..maxM] of ^tang ;
        try ,trx         : tr ;
        N ,M             : integer ;

Procedure Nhap ;
  Var F : Text ;
      i ,j : integer ;
  Begin
    Assign(F ,Fi) ;
    Reset(F) ;
    Readln(F ,M ,N) ;
    For i := 1 to M do new(c[i]) ;
    For i := M downto 1 do
      For j := 1 to N do read(F ,c[i]^[j]) ;
    Close(F) ;
  End ;

Procedure Xuly ;
  Var u ,i : Integer ;
  Begin
    new(d[1]) ;new(trx[1]) ;new(try[1]) ;
    Fillchar(trx[1]^ ,sizeof(trx[1]^) ,0) ;
    Fillchar(try[1]^ ,sizeof(try[1]^) ,0) ;
    For i := 1 to N do d[1]^[i] := c[1]^[i] ;
    For u := 2 to M do
      Begin
        new(d[u]) ;new(trx[u]);new(try[u]) ;
        Fillchar(trx[u]^ ,sizeof(trx[u]^) ,0) ;
        Fillchar(try[u]^ ,sizeof(try[u]^) ,0) ;
        For i := 1 to N do
          Begin
            d[u]^[i] := d[u-1]^[i]+c[u]^[i];
            trx[u]^[i] := u-1 ;try[u]^[i] := i;
          End ;
        For i := 1 to N-1 do
          If d[u]^[i]+c[u]^[i+1] < d[u]^[i+1] then
            Begin
              d[u]^[i+1] := d[u]^[i] + c[u]^[i+1];
              trx[u]^[i+1] := u ;try[u]^[i+1] := i;
            End ;
        For i := N downto 2 do
          If d[u]^[i]+c[u]^[i-1] < d[u]^[i-1] then
            Begin
              d[u]^[i-1] := d[u]^[i] + c[u]^[i-1] ;
              trx[u]^[i-1] := u ;try[u]^[i-1] := i;
            End ;
        dispose(c[u-1]) ;
        dispose(d[u-1]) ;
      End ;
  End ;

Procedure Inkq ;
  Var F : Text ;
      t ,u0 ,v0 ,u ,v ,s ,op ,i : LongInt ;
  Begin
    Assign(F ,Fo) ;
    rewrite(F) ;
    s := maxLongint ;u := M ;
    For i := 1 to N do If d[M]^[i] < s then
      Begin  v := i ;s := d[M]^[i] End ;
    op := 0 ;u0 := u;v0 := v ;
    While u <> 0 do
      Begin
        t := trx[u]^[v] ;v := try[u]^[v] ; u := t;
        inc(op)
      End ;
    Writeln(F ,s ,' ',op) ;
    u := u0 ;v := v0 ;
    While u <> 0 do
      Begin
        Writeln(F ,v) ;
        t := trx[u]^[v] ;v := try[u]^[v] ;
        u := t ;
        inc(op)
      End ;
    Close(F) ;
  End ;

BEGIN
  Nhap ;
  Xuly ;
  Inkq ;
END .

3 4
10 10 1 10
2 2 2 10
1 10 10 10

4 5
1  10 10 1 10
1  1  10 1 10
10 1  1  1  1
10 10 10 10 1

1 1
1