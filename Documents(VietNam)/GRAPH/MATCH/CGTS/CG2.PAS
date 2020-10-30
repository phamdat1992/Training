(* Nguyen Phuong Ngoc 11 Toan NK Tran Phu *)
(* Cap ghep co trong so *)

Program CAPGHEP2;
Uses    Crt;
Const
        Tfi                     = 'WORK2.INP';
        Tfo                     = 'WORK2.OU2';
        Max                     = 50;
Type
        Mang2Int                = Array [1..Max, 1..Max] Of Integer;
        Mang1Int                = Array [1..Max] Of Integer;
Var
        Fi, Fo                          : Text;
        A                               : Mang2Int;
        Tho, Viec, Fx, Fy, Dau, S, T    : Mang1Int;
        N, Total                        : Integer;
        TuDo, CoDT                      : Boolean;

(*============================================*)
Procedure Nhap;
Var
   i, j         : Integer;
Begin
     Assign(Fi, Tfi); Reset(Fi);
      Readln(Fi, N);
      For i := 1 to N do
      Begin
          For j := 1 to N do Read(Fi, A[i, j]);
          Readln(Fi);
      End;
     Close(Fi);
End;
(*============================================*)
Procedure Init;
Var
   i, j         : Integer;
Begin
     FillChar(Tho, SizeOf(Tho), 0);
     FillChar(Viec, SizeOf(Viec), 0);

     FillChar(S, SizeOf(S), 0);
     FillChar(T, SizeOf(T), 0);

     FillChar(Fy, SizeOf(Fy), 0);
     FillChar(Fx, SizeOf(Fx), 0);
     For i := 1 to N do
         For j := 1 to N do
         If A[i, j] > Fx[i] then Fx[i] := A[i, j];

     TuDo := True;
End;
(*============================================*)
Procedure InitDFS;
Begin
     FillChar(Dau, SizeOF(Dau), 0);
End;
(*============================================*)
Procedure DFS(v : Byte);
Var
   j    : Integer;
Begin
     S[v] := 1;
     For j := 1 to N do
         If Not(CoDT) and (Dau[j] = 0) and (Fx[v] + Fy[j] = A[v, j]) then
         Begin
              T[j] := 1;
              Dau[j] := v;
              If Viec[j] = 0 then
              Begin
                   CoDt := True;
                   Exit;
              End;

              DFS(Viec[j]);
              If Not(CoDt) then Dau[j] := 0;
         End;
End;
(*============================================*)
Procedure TimDuongTang;
Var
   i            : Integer;
Begin
     TuDo := False;
     CoDT := False;
     For i := 1 to N do
         If Tho[i] = 0 then
         Begin
              TuDo := True;
              InitDFS;
              DFS(i);
              If CoDT then Exit;
         End;
End;
(*============================================*)
Procedure InitTCG;
Begin
     FillChar(S, SizeOf(S), 0);
     FillChar(T, SizeOf(T), 0);
End;
(*============================================*)
Procedure TangCapGhep;
Var
   j            : Integer;
Begin
     InitTCG;
     For j := 1 to N do
         If Dau[j] <> 0 then
         Begin
              Viec[j] := Dau[j];
              Tho[Dau[j]] := j;
         End;
End;
(*============================================*)
Function T_Min(x, y : Integer) : Integer;
Begin
     If x > y then T_Min := y
     else T_Min := x;
End;
(*============================================*)
Procedure SuaNhan;
Var
   i, j, d      : Integer;
Begin
     d := MaxInt;
     For i := 1 to N do
         If S[i] = 1 then
            For j := 1 to N do
                If (T[j] = 0) then d := T_Min(d, Fx[i] + Fy[j] - A[i, j]);

     For i := 1 to N do
         If S[i] = 1 then Fx[i] := Fx[i] - d;
     For j := 1 to N do
         If T[j] = 1 then Fy[j] := Fy[j] + d;

End;
(*============================================*)
Procedure Main;
Begin
     While TuDo Do
     Begin
          Repeat
                TimDuongTang;
                If Not TuDo then Exit;
                If CoDT then TangCapGhep
                      else SuaNhan;
          Until CoDT;
     End;
End;
(*============================================*)
Procedure TinhTong;
Var
   i         : Integer;
Begin
     Total := 0;
     For i := 1 to N do Total := Total + A[i, Tho[i]];
End;
(*============================================*)
Procedure InKQ;
Var
   i    : Integer;
Begin
     Assign(Fo, Tfo); Rewrite(Fo);
      TinhTong;
      Writeln(Fo, Total);
      For i := 1 to N do Writeln(Fo, i, ' lam viec ', Tho[i]);
     Close(Fo);
End;
(*============================================*)
Begin
     Nhap;
     Init;
     Main;
     InKQ;
End.