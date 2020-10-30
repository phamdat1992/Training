(*
  Author     : Le Van Chuong
  Class      : 11A2, PTTH Phan Boi Chau, TP Vinh, Nghe An
  Start at   : 27/09/2000
  Finished at: 29/09/2000
  Input      : File OTHELLO.INP
  Output     : File OTHELLO.OUT
*)
Program Othello;
Const
  Fi         =  'othello.inp';
  Fo         =  'othello.out';
  Size       =  8;
  Max        =  1000;
  X          : Array [1..8] Of Integer = (- 1, - 1, - 1, 0, 1, 1, 1, 0);
  Y          : Array [1..8] Of Integer = (- 1, 0, 1, 1, 1, 0, - 1, - 1);
Var
  F      : Text;
  A      : Array [- Size* 2..Size* 2, - Size* 2..Size* 2] Of Char;
  Nuocdi : Array [- Size* 2..Size* 2, - Size* 2..Size* 2] Of Boolean;
  Lenh   : Array [1..Max] Of String [5];
  N      : Integer;
  Quan   : Char;

Procedure Init;
Var
  I, J: Integer;
Begin
  Assign (F, Fi);
  Reset (F);
  FillChar (A, SizeOf (A), 1);
  For I:= 1 To Size Do
  Begin
    For J:= 1 To Size Do Read (F, A [I, J] );
    ReadLn (F);
  End;
  ReadLn (F, Quan);
  I:= 0;
  While Not EoF (F) Do
  Begin
    Inc (I);
    ReadLn (F, Lenh [I] );
  End;
  N:= I;
End;

Procedure Xet (I, J: Integer);
Var
  B, K: Integer;
Begin
  Case Quan Of
    'B': If A [I, J] = 'B' Then
         Begin
           B:= 1;
           Repeat
             K:= 1;
             While A [I+ (K* X [B] ), J+ (K* Y [B] ) ] = 'W' Do Inc (K);
             If K<> 1 Then
               If A [I+ (K* X [B] ), J+ (K* Y [B] ) ] = '-' Then
                 Nuocdi [I+ (K* X [B] ), J+ (K* Y [B] ) ] := True;
             Inc (B);
           Until B> 8;
         End;
    'W': If A [I, J] = 'W' Then
         Begin
           B:= 1;
           Repeat
             K:= 1;
             While A [I+ (K* X [B] ), J+ (K* Y [B] ) ] = 'B' Do Inc (K);
             If K<> 1 Then
               If A [I+ (K* X [B] ), J+ (K* Y [B] ) ] = '-' Then
                 Nuocdi [I+ (K* X [B] ), J+ (K* Y [B] ) ] := True;
             Inc (B);
           Until B> 8;
         End;
  End;
End;

Procedure Lietke;
Var
  I, J: Integer;
  P: Boolean;
Begin
  P:= False;
  FillChar (Nuocdi, SizeOf (Nuocdi), False);
  For I:= 1 To Size Do
    For J:= 1 To Size Do Xet (I, J);
  For I:= 1 To Size Do
    For J:= 1 To Size Do
      If Nuocdi [I, J] Then Begin P:= True; Write (F, '(', I, ',', J, ')  '); End;
  If Not P Then Write (F, 'No legal move.');
  WriteLn (F);
End;

Procedure Lantu (I, J: Integer);
Var
  M, B, K: Integer;
Begin
  If A [I, J] = '-' Then
    Case Quan Of
      'W': Begin
             A [I, J] := 'W';
             B:= 0;
             Repeat
               K:= 1;
               Inc (B);
               While A [I+ K* X [B], J+ K* Y [B] ] = 'B' Do Inc (K);
               If (K<> 1) And (A [I+ K* X [B], J+ K* Y [B] ] = 'W') Then
               Begin
                 For M:= 1 To K Do A [I+ (M* X [B] ), J+ (M* Y [B] ) ] := 'W';
                 Lantu (I+ (K* X [B] ), J+ (K* Y [B] ) );
                 Quan:= 'B';
               End;
             Until B= 8;
           End;
      'B': Begin
             A [I, J] := 'B';
             B:= 0;
             Repeat
               K:= 1;
               Inc (B);
               While A [I+ (K* X [B] ), J+ (K* Y [B] ) ] = 'W' Do Inc (K);
               If (K<> 1) And (A [I+ (K* X [B] ), J+ (K* Y [B] ) ] = 'B') Then
               Begin
                 For M:= 1 To K Do A [I+ (M* X [B] ), J+ (M* Y [B] ) ] := 'B';
                 Lantu (I+ (K* X [B] ), J+ (K* Y [B] ) );
                 Quan:= 'W';
               End;
             Until B= 8;
           End;
    End;
End;

Procedure Thuchien (Lenh: String);
Var
  I, J, Xx, Yy: Integer;
  U, V, M: Integer;
Begin
  Xx:= 0; Yy:= 0;
  Val (Lenh [2], U, M);
  Val (Lenh [3], V, M);
  FillChar (Nuocdi, SizeOf (Nuocdi), False);
  For I:= 1 To Size Do
    For J:= 1 To Size Do Xet (I, J);
  If Not Nuocdi [U, V] Then
    Case Quan Of
      'W': Quan:= 'B';
      'B': Quan:= 'W';
    End;
  Lantu (U, V);
  For I:= 1 To Size Do
    For J:= 1 To Size Do
      Case A [I, J] Of
        'W': Inc (Xx);
        'B': Inc (Yy);
      End;
  WriteLn (F, 'Black - ', Yy, ' White - ', Xx);
End;

Procedure Viet;
Var
  I, J: Integer;
Begin
  For I:= 1 To Size Do
  Begin
    For J:= 1 To Size Do Write (F, A [I, J] );
    WriteLn (F);
  End;
End;

Procedure Main;
Var I: Integer;
Begin
  Assign (F, Fo);
  Rewrite (F);
  For I:= 1 To N Do
    Case Lenh [I] [1] Of
      'L': Lietke;
      'M': Thuchien (Lenh [I] );
      'Q': Viet;
    End;
  Close (F);
End;

Begin
  Init;
  Main;
End.

--------
--------
--------
---WB---
---BW---
--------
--------
--------
W
L
M35
L
Q
