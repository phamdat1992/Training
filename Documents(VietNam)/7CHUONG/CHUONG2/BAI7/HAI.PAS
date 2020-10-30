PROGRAM NOI_DAY;
Uses Crt;
Const Fi = 'NoiDay.in3';
       Fo = 'NoiDay.out';

Var D       : Array[0..100, 0..100] of Real;
    X, Y    : Array[0..100] of Real;
    Set_Top : Set of Byte;
    Chi_Phi : Real;
    N       : Byte;
    F, G    : Text;

Procedure Mo_File;
Begin

     Assign(F, Fi); Reset(F);
     Assign(G, Fo); Rewrite(G);

End;

Procedure Dong_File;
Begin

     Close(F); Close(G);

End;

Procedure Doc_Du_Lieu;
Var i : Byte;
Begin

     Readln(F, N);
     For i := 1 To N Do Readln(F, X[i], Y[i]);

End;

Procedure Tinh_Khoang_Cach(i, j : Byte);
Begin

     D[i, j] := Sqrt(Sqr(X[i] - X[j]) + Sqr(Y[i] - Y[j]));
     D[j, i] := D[i, j];

End;

Procedure Chuan_Bi;
Var i, j : Byte;
Begin

     X[0] := 0;
     Y[0] := 0;
     Set_Top  := [0];
     For i := 0 To N Do
         For j := 0 To N Do
             if i = j Then D[i, j] := Maxint
             Else Tinh_Khoang_Cach(i, j);
     Chi_Phi := 0;

End;

Procedure Find_Min(Var Top, Chi_So : Byte);
Var Min  : Real;
    j, i : Byte;
Begin

     Min := Maxint;
     For i := 0 To N Do
         if i in Set_Top Then
            For j := 0 To N Do
                if Not (j in Set_Top) And (D[i, j] < Min) Then
                Begin
                     Top    := j;
                     Chi_So := i;
                     Min    := D[i, j];
                End;

End;

Procedure Prim;
Var Dem         : integer;
    Chi_So, Top : Byte;
Begin

     Dem := 1;
     Repeat
           Find_Min(Top, Chi_So);
           Set_Top := Set_Top + [Top];
           Chi_Phi := Chi_Phi + D[Top, Chi_So];
           D[Top, Chi_So] := 0;
           D[Chi_So, Top] := 0;
           inc(Dem);
     Until Dem = N + 1;

End;

Procedure Ghi_Ket_Qua;
Var i, j : Byte;
Begin

     Writeln(G, n);
     For i := 0 To N Do
     Begin
          For j := 0 To N Do
              if D[i, j] = 0 Then
			  	Begin
					Writeln(G, i,' ',j);
                    D[j,i] := 1;
				End;
     End;

End;


BEGIN

     Clrscr;
     Mo_File;
     Doc_Du_Lieu;
     Chuan_Bi;
     Prim;
     Ghi_Ket_Qua;
     Dong_File;

END.