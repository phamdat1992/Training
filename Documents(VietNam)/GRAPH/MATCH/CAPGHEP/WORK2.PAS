Program CAPGHEP2;
Uses Crt;
Const
     Tfi = 'WORK2.INP';
     Tfo = 'WORK2.OUT';
     Max = 50;
Type
    Mang2Byt = Array [1..Max,1..Max] Of Byte;
    Mang1Byt = Array [1..Max] Of Byte;
    Mang1Boo = Array [1..Max] Of Boolean;
Var
   Fi,Fo : Text;
   A : Mang2Byt;
   Fx,Fy : Mang1Byt;
   n : Byte;
   TimDTDo,CoDt : Boolean;
   S,T,Dau,Tho,Viec : Mang1Byt;
   Xet : Mang1Boo;
   Total : Integer;

(*==========================================================================*)
Procedure Nhap;
Var
   i,j : Byte;
Begin
     Assign(Fi,Tfi);Reset(Fi);
     Read(Fi,n);
     For i:=1 to n do
         Begin
              Readln(Fi);
              For j:=1 to n do Read(Fi,A[i,j]);
         End;
     Close(Fi);
End;
(*==========================================================================*)
Procedure ChuanBi;
Begin
     TimDTDo:=True;
     FillChar(Tho,SizeOf(Tho),0);
     FillChar(Viec,SizeOf(Viec),0);
     FillChar(S,SizeOf(S),0);
     FillChar(T,SizeOf(T),0);
     Total:=0;
End;
(*==========================================================================*)
Procedure KhoiTao;
Var
   i,j : Byte;
Begin
     FillChar(Fx,SizeOf(Fx),0);
     FillChar(Fy,SizeOf(Fy),0);
     For i:=1 to n do
         For j:=1 to n do
             If A[i,j]>Fx[i] then Fx[i]:=A[i,j];
End;
(*==========================================================================*)
Procedure ChuanBiDFS;
Var
   i : Byte;
Begin
     For i:=1 to n do
     Begin
          Dau[i]:=0;
          Xet[i]:=False;
     End;
End;
(*==========================================================================*)
Procedure DFS(v:Byte);
Var
   i : Integer;
Begin
  Begin
     S[v]:=1;
     For i:=1 to n do
          If Not(Xet[i]) and (Fx[v]+Fy[i]=A[v,i]) and (Not(CoDT)) then
          Begin
               T[i]:=1;
               Xet[i]:=True;
               Dau[i]:=v;
               If Viec[i]=0 then
               Begin
                    CoDt:=True;
                    exit;
               End
               Else DFS(Viec[i]);
               If CoDt=False then Xet[i]:=False;
          End;
  End;
End;
(*==========================================================================*)
Procedure TimDuongTangCapGhep;
Var
   i : Byte;
Begin
     TimDTDo:=False;
     For i:=1 to n do
     If Tho[i]=0 then
     Begin
          CoDt:=False;
          TimDTDo:=True;
          ChuanBiDFS;
          DFS(i);
          If CoDt then exit;
     End;
End;
(*==========================================================================*)
Procedure TangCapGhep;
Var
   i : Integer;
Begin
     For i:=1 to n do
     If Xet[i] then
     Begin
          Viec[i]:=Dau[i];
          Tho[Dau[i]]:=i;
     End;
     FillChar(S,SizeOf(S),0);
     FillChar(T,SizeOf(T),0);
End;
(*==========================================================================*)
Procedure SuaNhan;
Var
   i,j,d : Byte; {Min}
Begin
     d:=255;
     For i:=1 to n do
         For j:=1 to n do
             If (S[i]=1) and (T[j]=0) and (d>Fx[i]+Fy[j]-A[i,j]) then
                 d:=Fx[i]+Fy[j]-A[i,j];
     For i:=1 to n do If S[i]=1 then Fx[i]:=Fx[i]-d;
     For i:=1 to n do If T[i]=1 then Fy[i]:=Fy[i]+d;
End;
(*==========================================================================*)
Procedure Xuly;
Begin
     KhoiTao;
     While TimDTDo Do
     Begin
          Repeat
                TimDuongTangCapGhep;
                If CoDT then TangCapGhep
                else SuaNhan;
          Until CoDT;
     End;
End;
(*==========================================================================*)
Procedure TinhTong;
Var
   i : Byte;
Begin
     For i:=1 to n do Total:=Total+Fx[i];
     For i:=1 to n do Total:=Total+Fy[i];
End;
(*==========================================================================*)
Procedure InKQ;
Var
   i : Byte;
Begin
     Assign(Fo,Tfo);Rewrite(Fo);
     TinhTong;
     Writeln(Fo,Total);
     For i:=1 to n do Writeln(Fo,'Tho ',i,' lam viec ',Tho[i]);
     Close(Fo);
End;
(*==========================================================================*)
Begin
     Nhap;
     ChuanBi;
     Xuly;
     InKQ;
End.
    { Test 1 }
4
2 5 1 6
8 7 6 4
6 9 3 5
5 1 2 7