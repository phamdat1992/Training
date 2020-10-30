(* Complete *)
PROGRAM NOI_DIEN;
Uses Crt;
Const
      Hinp = 'Noiday.in5';
       Hout = 'Noiday.out';
      MAXN = 100;
      MAXMAX = 10E30;
{$R+,Q+,B-}

Type
     Item      = Record
                       x, y : Integer;
                 End;
     Base_type = Array [0..MAXN] Of Item;
     Data_type = Array [0..MAXN, 0..MAXN] Of Real;
(* 様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様 *)

Var
    A       : ^Data_type;
    P       : Base_type;
    B       : Array [0..MAXN] Of Real;
    Pro     : Array [0..MAXN, 0..MAXN] Of Byte;
    C       : Array [0..MAXN] Of Byte;
    Cx      : Array [0..MAXN] Of Boolean;
    Mi      : Real;
    Project : Real;
    Gi      : Byte;
    n       : Byte;
    f       : Text;
(* 様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様 *)

Procedure Born;
Var i : Byte;
Begin
     Assign(f, Hinp); Reset(f);
     Readln(f, n);
     For i:=1 To n Do
         Readln(f, P[i].x, P[i].y);
     Close(f);
End;
(* 様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様 *)

Function Khoang_cach(i, j : Byte) : Real;
Begin
     Khoang_cach := Sqrt( Sqr(P[i].x-P[j].x) + Sqr(P[i].y-P[j].y) );
End;
(* 様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様 *)

Procedure Init;
Var i, j : Byte;
Begin
     New(A);
     For i:=0 To n Do
         For j:=0 To n Do
             If i<>j Then A^[i,j] := Khoang_cach(i,j);

     Fillchar(Pro, Sizeof(Pro), 0);
     Fillchar(Cx, Sizeof(Cx), True);
     Cx[0] := False;
     B[0]  := 0;
     C[0]  := 0;

     For i:=1 To n Do
         Begin
              B[i] := A^[i,0];
              C[i] := 0;
         End;

     Project := 0;
End;
(* 様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様 *)

Procedure Modify_data;
Var i : Byte;
Begin
     For i:=0 To n Do
         If Cx[i] Then
            If A^[i,gi] < B[i] Then
               Begin
                    B[i] := A^[i,gi];
                    C[i] := gi;
               End;
End;
(* 様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様 *)

Procedure Process;
Var
    i, j : Byte;
Begin
     Init;
     Repeat
           Mi := MAXMAX;
           For i:=0 To n Do
               If Cx[i] And (B[i] < Mi) Then
                  Begin
                        Mi := B[i];
                        Gi := i;
                  End;

           If Mi=MAXMAX Then Break;

           Cx[Gi] := False;
           Pro[Gi, C[gi]] := 1;
           Pro[C[gi], gi] := 1;
           Project := Project + Mi;

           Modify_data;

     Until False;

     Dispose(A);
End;
(* 様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様 *)

Procedure Die;
Var i, j : Byte;
Begin
     Assign(f, Hout); Rewrite(f);
     Writeln(f,n);
     For i:=0 To n Do
         Begin
              For j:=0 To n Do
			  	If Pro[i,j]=1 Then
					Begin
						Writeln(f,i,' ',j);
                        Pro[j,i] := 0;
                    End;
              Writeln(f);
         End;
     Close(f);
End;
(* 様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様 *)

BEGIN
     Clrscr;
     Born;
     Process;
     Die;
END.