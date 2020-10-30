(* Nguyen Phuong Ngoc 12 Toan NK Tran Phu *)
(* On tap cap ghep - 28/7/2K*)

{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

Program Cap_Ghep; {Tho - Viec}
Uses    Crt;
Const
        Tfi                             = 'work.inp';
        Tfo                             = 'work.out';
        Max                             = 170;
Type
        Mang1Long                       = Array [1..Max] Of LongInt;
        Mang1Int                        = Array [1..Max] Of Integer;
        Mang2Int                        = Array [1..Max, 1..Max] Of Integer;
Var
        Fi, Fo                          : Text;
        A                               : Mang2Int;
        Tho, Viec, S, T                 : Mang1Int;
        Fx, Fy                          : Mang1Long;
        N, Fin, ii, jj                  : Integer;
        Total                           : LongInt;
        Free, Found                     : Boolean;
              { SysTicks }
        Tnow                            : LongInt Absolute $40 : $6C;
        Tbegin                          : LongInt;

(*=================================================*)
Procedure MakTes;
Var
   i, j, k    : Integer;
Begin
     Randomize;
     N := Max;
     Assign(Fo, Tfi); Rewrite(Fo);
     Writeln(Fo, N);
     Writeln(' N = ', N);
     For i := 1 to N do
     Begin
          For j := 1 to N do
          Begin
               k := Random(Maxint);
               k := k - MaxInt div 2;
               Write(Fo, k, ' ');
          End;
          Writeln(Fo);
     End;
     Close(Fo);
End;
(*=================================================*)
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
(*=================================================*)
Procedure Init;
Var
   i, j    : Integer;
Begin
     FillChar(Tho, SizeOf(Tho), 0);
     FillChar(Viec, SizeOf(Viec), 0);
     FillChar(Fy, SizeOf(Fy), 0);
     For i := 1 to N do Fx[i] := -MaxInt;
     For i := 1 to N do
         For j := 1 to N do
             If Fx[i] < A[i, j] then Fx[i] := A[i, j];
End;
(*=================================================*)
Procedure InitGet;
Var
   i, j    : Integer;
Begin
     For i := 1 to N do
         For j := 1 to N do
             If (Fx[i] + Fy[j] = A[i, j]) and (Viec[j] = 0) then
             Begin
                  Tho[i] := j;
                  Viec[j] := i;
                  Break;
             End;
End;
(*=================================================*)
Procedure Init_Find;
Begin
     FillChar(S, SizeOf(S), 0);
     FillChar(T, SizeOf(T), 0);
     Free := False;
     Found := False;
End;
(*=================================================*)
Procedure DFS(v : Integer);
Var
   j    : Integer;
Begin
     S[v] := 1;
     For j := 1 to N do
         If (T[j] = 0) and (Fx[v] + Fy[j] = A[v, j]) and (Not Found) then
         Begin
              T[j] := v;
              If Viec[j] = 0 then
              Begin
                   Found := True;
                   Fin := j;
                   Exit;
              End;
              DFS(Viec[j]);
         End;
End;
(*=================================================*)
Procedure Find_Get;
Var
   i    : Integer;
Begin
     Init_Find;
     For i := 1 to N do
         If Tho[i] = 0 then
         Begin
              Free := True;
              DFS(i);
              Exit;
         End;
End;
(*=================================================*)
Procedure Inc_Get;
Var
   tr    : Integer;
Begin
     While Fin <> 0 Do
     Begin
          tr := Tho[T[Fin]];

          Tho[T[Fin]] := Fin;
          Viec[Fin] := T[Fin];

          Fin := tr;
     End;
End;
(*=================================================*)
Function T_Min(x, y : LongInt) : LongInt;
Begin
     If x > y then T_Min := y else T_Min := x;
End;
(*=================================================*)
Procedure Change_F;
Var
   i, j       : Integer;
   d          : LongInt;
Begin
     d := MaxLongInt;
     For ii := 1 to N do
         If S[ii] <> 0 then
            For jj := 1 to N do
                If T[jj] = 0 then
                   d := T_Min(d, Fx[ii] + Fy[jj] - A[ii, jj]);
     For i := 1 to N do
         If S[i] <> 0 then Fx[i] := Fx[i] - d;
     For j := 1 to N do
         If T[j] <> 0 then Fy[j] := Fy[j] + d;
End;
(*=================================================*)
Procedure Main;
Begin
     InitGet;
     While TRUE Do
     Begin
          Find_Get;
          If Not Free then Exit;
          If Found then Inc_Get else Change_F;
     End;
End;
(*=================================================*)
Procedure TinhTotal;
Var
   i    : Integer;
Begin
     Total := 0;
     For i := 1 to N do Total := Total + A[i, Tho[i]];
End;
(*=================================================*)
Procedure InKQ;
Var
   i    : Integer;
Begin
     TinhTotal;
     Assign(Fo, Tfo); Rewrite(Fo);
     Writeln(Fo, Total);
     For i := 1 to N do Writeln(Fo, Tho[i]);
     Close(Fo);
End;
(*=================================================*)
Procedure Check;
Var
   i, j    : Integer;
   Tong    : LongInt;
   Procedure dung;
   Begin
        Writeln('dung');
        Halt(1);
   End;
   Procedure sai;
   Begin
        Writeln('sai', #7);
        Readln;
        Halt(1);
   End;
Begin
     Assign(Fi, Tfo); Reset(Fi);
     Readln(Fi, Tong);
     For i := 1 to N do
     Begin
          Read(Fi, j);
          Tong := Tong - A[i, j];
     End;
     Close(Fi);
     If Tong = 0 then dung;
     sai;
End;
(*=================================================*)

Begin
     MakTes;
     ClrScr; Tbegin := Tnow;
     Nhap;
     Init;
     Main;
     InKQ;
     Writeln(' Clock = ', Tnow - Tbegin);
     Writeln(' Time  = ', (Tnow - Tbegin) /18.23 :0:2);
     Check;
End.