{
 Bai thi quoc te 94.4 ~ The Clocks ~
   Chuong trinh duoi day giai quyet bai toan theo ki thuat
   HE PHUONG TRINH DONG DU
 Do phuc tap : hang so
}
PROGRAM Clock;
  Uses
    Time;
  Const
    Name    = 'clock.inp';
    OutName = 'output.txt';
    P : array[0..15] of byte = (0,3,2,1,0,3,2,1,0,3,2,1,0,3,2,1);
  Var
    f         : text;
    x, n, min : array[1..9] of 0..4;
    i, u, v   : byte;
    minimum   : byte;
  Begin
    Minimum := 27;
    Assign(f, name); reset(f);
    For i := 1 to 9 do read(f, x[i]);
    Close(f);
    For n[2] := 0 to 3 do
    For n[4] := 0 to 3 do
    For n[6] := 0 to 3 do
    For n[8] := 0 to 3 do
      Begin
        n[1] := P[ n[2] + n[4] + X[1] ];
        n[3] := P[ n[2] + n[6] + X[3] ];
        n[7] := P[ n[4] + n[8] + X[7] ];
        n[9] := P[ n[6] + n[8] + X[9] ];
        n[5] := P[ n[1] + n[3] + n[7] + N[9] + X[5] ];
        {$B-}
        If
        ( P[ n[1] + n[2] + n[3] + n[5] + x[2] ] = 0 ) and
        ( P[ n[1] + n[4] + n[5] + n[7] + x[4] ] = 0 ) and
        ( P[ n[3] + n[5] + n[6] + n[9] + x[6] ] = 0 ) and
        ( P[ n[5] + n[7] + n[8] + n[9] + x[8] ] = 0 )
        then
          Begin
            if n[1]+n[2]+n[3]+n[4]+n[5]+n[6]+n[7]+n[8]+n[9] < minimum then
              Begin
                minimum := n[1]+n[2]+n[3]+n[4]+n[5]+n[6]+n[7]+n[8]+n[9];
                min := n
              End
          End
      End;
    Assign(f, outname); rewrite(f);
    For u := 1 to 9 do if min[u] <> 0 then
      For v := 1 to min[u] do
        Begin 
          write(u,' ');
          write(f, u, ' ');
        End;
    Close(f);
    Writeln;
    Writeln(' Program''s run time : ',TimeNow);
  End.