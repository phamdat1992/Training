(* Nguyen Phuong Ngoc 11 Toan NK Tran Phu *)
(* Thuat toan EULER : Tim duong di qua tat ca cac canh *)

Program EULER;
Uses    Crt;
Const
        Tfi                     = 'EULER.INP';
        Tfo                     = 'EULER.OUT';
        Max                     = 50;
Type
        Mang2Byt                = Array [1..Max, 1..Max] Of Byte;
        Mang1Byt                = Array [1..Max] Of Byte;
Var
        Fi, Fo                  : Text;
        A                       : Mang2Byt;
        Circle, Deg, Queue      : Mang1Byt;
        N, Dodai                : Integer;
        ThoaMan                 : Boolean;


(*=================================================*)
Procedure Nhap;
Var
   i, j         : Integer;
Begin
     Assign(Fi, Tfi); Reset(Fi);
      Readln(Fi, N);
      For i := 1 to N do
      Begin
          For j := 1 to N do
          Begin
              Read(Fi, A[i, j]);
              If A[i, j] = 1 then Inc(Deg[i]);
          End;
          Readln(Fi);
      End;
     Close(Fi);
End;
(*=================================================*)
Procedure Init;
Begin
     FillChar(Deg, SizeOf(Deg), 0);
     Dodai := 0;
End;
(*=================================================*)
Procedure KiemTra;
Var
   i, j         : Integer;
Begin
     j := 0;
     For i := 1 to N do
         If (Deg[i] mod 2) = 1 then Inc(j);
     ThoaMan := True;
     If j > 2 then ThoaMan := False;
End;
(*=================================================*)
Procedure Main;
Var
   i, Top       : Integer;
   OK           : Boolean;
Begin
     Dodai := 0;
     Top := 1;
     Queue[1] := 1;
     While Top >= 1 Do
     Begin
          OK := True;
          For i := 1 to N do
              If A[Queue[Top], i] = 1 then
              Begin
                   A[Queue[Top], i] := 0;
                   A[i, Queue[Top]] := 0;
                   Inc(Top);
                   Queue[Top] := i;
                   OK := False;
                   Break;
              End;
          If OK then
          Begin
               Inc(Dodai);
               Circle[Dodai] := Queue[Top];
               Dec(Top);
          End;
     End;
End;
(*=================================================*)
Procedure InKQ;
Var
   i    : Integer;
Begin
     Assign(Fo, Tfo); Rewrite(Fo);
     If ThoaMan then
     Begin
          For i := 1 to Dodai do Write(Fo,Circle[i]:3);
     End

     else       Write(Fo, ' Kh“ng co duong di Euler trong do thi');
     Close(Fo);
End;
(*=================================================*)
Begin
     Init;
     Nhap;
     KiemTra;
     If ThoaMan then Main;
     InKQ;
End.