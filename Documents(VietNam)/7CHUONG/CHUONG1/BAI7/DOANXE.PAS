PROGRAM Chia_nhom_doan_xe ;
Const   Fi                = 'doanxe.inp' ;
        Fo                = 'doanxe.out' ;
        max               = 1001 ;

VAR     w ,v              : Array [0..max] of Longint ;
        tr                : Array [0..max] of integer ;
        min               : Array [0..max] of real ;
        N , P ,L          : Longint ;

Procedure Nhap;
  Var F : Text ;
      i : Integer ;
  Begin
    Assign(F ,Fi) ;
    reset(F) ;
    Readln(F ,N ,P ,L) ;
    For i := 1 to N do Readln(F ,w[i] ,v[i]) ;
    Close(F) ;
  End ;

Function Dt(u : Integer) : Integer ;
  Var s ,i : Integer ;
  Begin
    s := w[u] ;i := u ;
    while (s <= P) and (i > 0) do
      Begin
        Dec(i) ;
        Inc(s ,w[i]) ;
      End ;
    dt := i + 1 ;
  end ;

Function Minv(a,b : Integer) : Longint ;
  Var i ,t : Longint ;
  Begin
    t := a ;
    For i := a+1 to b do If v[i] < v[t] then t := i ;
    minv := v[t] ;
  end ;

Procedure Xuly ;
  Var i ,j ,k ,op : Integer ;
      t : real ;
  Begin
    Fillchar(tr ,sizeof(tr) ,0) ;
    min[0] := 0 ;min[1] := L/v[1] ;
    For i := 2 to N do
      Begin
        min[i] := 100000 ;
        k := dt(i) ;
        For j := i downto k do
          Begin
            t := L/minv(j,i);
            If min[i] > min[j-1] + t then
              Begin tr[i] := j ;min[i] := t + min[j-1] End ;
          End ;
      End ;
  End ;

Var kq : Array [1..max] of Integer ;

Procedure Inkq ;
  var u ,v : Integer ;
      F  : text ;
  Begin
    u := N;
    v := 0;
    While u > 0 do
      Begin
        inc(v) ;
        kq[v] := u ;
        u := tr[u]-1 ;
      End ;
    Assign(F ,Fo) ;
    Rewrite(F) ;
    Writeln(F ,min[N]:5:2) ;
    For u := v downto 1 do Write(F ,kq[u],' ') ;
    Close(F) ;
  End ;

BEGIN
  Nhap ;
  Xuly ;
  inkq ;
END .

10 100 100
40 25
50 20
50 20
70 10
12 50
09 70
49 30
38 25
27 50
19 70