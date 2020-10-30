{$r-}
PROGRAM Mang_lien_thong_don ;
Const   Max                 = 301 ;
        Fi                  = 'single.in1' ;
        Fo                  = 'single.out' ;

Type    Ke                  = Array [0..3] of Integer ;

Var     A                   : Array [0..max] of ke ;
        N                   : Integer ;

Procedure Nhap ;
  Var F : Text ;
      i ,j : Integer ;
  Begin
    Assign(F ,Fi) ;
    Reset(F) ;
    Fillchar(A ,sizeof(A) ,0) ;
    Readln(F ,N) ;
    For i := 1 to N do
      Begin
        While not seekeOln(F) do
          Begin Read(F ,j) ;
          If j <> 0 then
            Begin
              Inc(a[i][0]) ;a[i][a[i][0]] := j
            End ;
          End ;
        Readln(F) ;
      End ;
    Close(F) ;
  End ;

var d ,seq : Array [0..max] of Integer ;

Function notin(u ,k : Integer) : Boolean ;
  Var i : Integer ;
  Begin
    notin := false ;
    For i := 1 to k do If seq[i] = u then Exit ;
    notin := true ;
  End ;

Procedure Inkq(u ,v : Integer) ;
  Var F : text ;
  Begin
    Assign(F ,Fo) ;
    Rewrite(F) ;
    Writeln(F ,'NO') ;
    Writeln(F ,v,' ',u) ;
    Close(F) ;
    halt ;
  End ;

Procedure Try(i : Integer) ;
  Var u ,j ,v : Integer ;
  Begin
    u := seq[i-1] ;
    For j := 1 to a[u][0] do
      Begin
        v := a[u][j] ;
        If notin(v,i-1) then
          Begin
            If d[v] <> 0 then Inkq(seq[1],v) ;
            d[v] := d[u] + 1 ;
            seq[i] := v ;
            try(i+1) ;
          End ;
      End ;
  End ;

Procedure Intruoc ;
  Var F : text ;
      i : Integer ;
  Begin
    Assign(F ,Fo) ;
    Rewrite(F) ;
    Writeln(F ,'YES') ;
    For i := 2 to N do If d[i] > 0 then Writeln(F ,d[i]-1) else writeln(F,0);
    Close(F) ;
  End ;

Procedure Xuly ;
  Var i : Integer ;
  Begin
    Fillchar(d ,sizeof(d) ,0) ;
    seq[1] := 1 ;d[1] := 1 ;try(2) ;
    intruoc ;
    For i := 2 to N do
      Begin
        Fillchar(d ,sizeof(d) ,0) ;
        d[i] := 1;seq[1] := i;
        try(2) ;
      End ;
  End ;

BEGIN
  Nhap ;
  Xuly ;
END .

6
3
1
2 4
5 6
4
3
6
2
3
4
5
6
1 2

20
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
1

8
2
3
4
1
6
7
8
5

