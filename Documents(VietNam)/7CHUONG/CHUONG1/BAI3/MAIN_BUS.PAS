{$q+}{$r+}
PROGRAM Dao_choi_bang_xe_buyt ;
Const   Max                   = 201 ;
        Fi                    = 'bus.in7' ;
        Fo                    = 'bus.out' ;

Var     C ,min ,tr            : Array [0..max] of Longint ;
        b ,L                  : Longint ;

Procedure nhap ;
  Var F : text ;
      i : Longint ;
  Begin
    Assign(F ,Fi) ;
    Reset(F) ;
    Readln(F ,b ,L) ;
    For i := 1 to b do Read(F ,c[i]) ;
    Close(F) ;
  End ;

Function GtLon(u ,v : Longint) : Longint ;
  Begin
    If u > v then gtLon := u else Gtlon := v ;
  end ;

Procedure Xuly ;
  Var i ,j : Longint ;
  Begin
    min[0] := 0 ;
    min[1] := c[1] ;
    Fillchar(tr ,sizeof(tr) ,0) ;
    For i := 2 to L do
      Begin
        min[i] := min[i-1]+c[1] ;
        tr[i] := i-1 ;
        For j := GtLon(i-b,0) to i-2 do IF min[j]+c[i-j] < min[i] then
          Begin
            min[i] := min[j]+c[i-j] ;
            tr[i] := j ;
          End ;
      End ;
  End ;

Procedure Inkq ;
  Var F : Text ;
      u ,sl : Longint ;
  Begin
    Assign(F ,Fo) ;
    Rewrite(F) ;
    u := L ;sl := 0 ;
    While u <> 0 do
      Begin
        Inc(sl) ;u := tr[u] ;
      End ;
    writeln(F ,min[L]) ;
    Writeln(F,sl) ;
    u := L ;
    While u <> 0 do
      Begin
        Write(F ,u-tr[u],' ') ;
        u := tr[u] ;
      End ;
    Close(F) ;
  End ;

BEGIN
  Nhap ;
  Xuly ;
  Inkq ;
END .
10 200
12 3 31 40 49 58 68 79 90 101
