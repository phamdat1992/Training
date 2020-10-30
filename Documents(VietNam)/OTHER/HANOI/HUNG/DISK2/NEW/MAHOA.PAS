Program Ma_Hoa;
Uses Crt;
Var
  F: Text;
  K: Integer;
  Tam, S, S2, S3: String;
  DI: Array[1..20] Of String[8];
  Bangma: Array[1..100, 1..100] Of Char;
  I, J: Integer;
  Dem: LongInt;

Procedure Readfile;
Begin
  Assign(F, 'bl1.inp');
  Reset(F);
  ReadLn(F, S);
  ReadLn(F, K);
  For I:= 1 To K Do ReadLn(F, DI[I] );
  Close(F);
  Dem:= 0;
End;

Procedure Dienmang_Cot(M, N: Integer);
Var I, J, K: Integer;
Begin
  K:= 0;
  S2:= '';
  For J:= 1 To N Do
    For I:= 1 To M Do
    Begin
      Inc(K);
      Bangma[I, J] := S[K];
    End;

  For I:= 1 To M Do
  Begin
    For J:= 1 To N Do
      S2:= S2+ Bangma[I, J];
  End;
End;

Procedure Giai_Ma;
Var I, J, L, Q: Integer;
Begin
  WriteLn;
  Assign(F, 'bl1.out');
  Rewrite(F);
  For I:= 1 To 100 Do
    For J:= 1 To 100 Do
    Begin
      Dienmang_Cot(I, J);
      For L:= 1 To K Do
      Begin
        Q:= Pos(DI[L], S2);
        If (Q> 0) And (S2[Q- 1] = ' ') And (S2[Q+ Length(DI[L] ) ] = ' ') Then
        Begin
          WriteLn(F, 'So dong: ', I, '  So cot', J);
          WriteLn(F, S2);
          Break;
        End;
      End;
    End;
  Close(F);
End;

Begin
  ClrScr;
  Readfile;
  Giai_Ma;
End.
C Cvoxhinaueg  T Hn Hog Oihna Ia  Am
5
Cong
Hoa
Xa
Hoi
Chu
