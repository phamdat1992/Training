PROGRAM Bo_tri_phong_hop ;
Const   Max              = 10002 ;
        Fi               = 'activity.inp' ;
        Fo               = 'activity.out' ;

Type    Arr              = Array [0..max] of Integer ;

Var     S ,T ,cs         : Arr ;
        gt ,tr           : ^Arr ;
        N ,m             : Integer ;

Procedure Nhap ;
  Var F : text ;
      i : Integer ;
  Begin
    Assign(F ,Fi) ;
    Reset(F) ;
    Readln(F ,N) ;
    For i := 1 to N do Readln(F ,s[i] ,t[i]) ;
    For i := 1 to N do cs[i] := i ;
    Close(F) ;
  End ;

Procedure quicksort(l ,r : Integer) ;
  Var i, j ,t1 ,v : Integer ;
  Begin
    i := l ;j := r ;v := s[(i+j) div 2] ;
    Repeat
      while s[i] < v do Inc(i) ;
      while s[j] > v do Dec(j) ;
      If i <= j then
        Begin
          t1 := s[i] ;s[i] := s[j] ;s[j] := t1 ;
          t1 := t[i] ;t[i] := t[j] ;t[j] := t1 ;
          t1 := cs[i] ;cs[i] := cs[j] ;cs[j] := t1 ;
          Inc(i) ;Dec(j) ;
        End ;
    until i > j ;
    If l < j then Quicksort(l,j) ;
    If i < r then Quicksort(i,r) ;
  End ;

Procedure Xuly ;
  Var u ,i : Integer ;
  Begin
    Quicksort(1,N) ;
    New(gt) ;New(tr) ;
    Fillchar(gt^ ,sizeof(gt^) ,0) ;
    Fillchar(tr^ ,sizeof(tr^) ,0) ;
    t[0] := 0;
    gt^[1] := 1 ;m := 1 ;
    For u := 2 to N do
      Begin
        gt^[u]:= 1 ;tr^[u] := 0 ;
        i := u-1 ;
        While t[i] > s[u] do dec(i) ;
        If gt^[i] + 1 > gt^[u] then Begin
                                      gt^[u] := gt^[i] + 1 ;
                                      if gt^[u] > gt^[m] then m := u ;
                                      tr^[u] := i;
                                    End ;
      End ;
  End ;

Procedure Inkq ;
  Var i ,j ,k : Integer ;
      F       : text ;
  Begin
    Assign(F ,Fo) ;
    Rewrite(F) ;
    i := m ;
    k := 0 ;
    Repeat
      inc(k) ;
      i := tr^[i] ;
    Until i = 0 ;
    i := m ;
    Writeln(F ,k) ;
    Repeat
      Writeln(F ,cs[i]) ;
      i := tr^[i] ;
    Until i = 0 ;
    Close(F) ;
  End ;

BEGIN
  Nhap ;
  Xuly ;
  Inkq ;
END .
5
1 3
2 4
1 6
3 5
7 9