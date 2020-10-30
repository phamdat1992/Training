(* Nguyen Phuong Ngoc 11 Toan - NK Tran Phu *)
(* Tim toi uu tho viec *)
Program WORK;
Uses Crt;
ConSt
     Name1 = 'WORK.INP';
     Name2 = 'WORK.OUT';
     MaxTho = 100;
     MaxViec = 100;
Type
    NhiPhan = 0..1;
    MaTranKe = Array [1..MaxTho,1..MaxViec] OF NhiPhan;
    Arr1Int = Array [1..MaxTho] Of Integer;
    Arr1Boo = Array [1..MaxTho] Of Boolean;
Var
   F : Text;
   A : MatranKe;
   n,m : Integer;
   Xet : Arr1Boo;
   Dau,Tho,Viec : Arr1Int;
   TimThay : Boolean;

(*==========================================================================*)
Procedure Init;
Var
   i,j : Integer;
Begin
     For i:=1 to n do
         For j:=1 to m do A[i,j]:=0;
     For i:=1 to n do Tho[i]:=0;
     For j:=1 to m do Viec[i]:=0;
End;
(*==========================================================================*)
Procedure Nhap;
Var
   i,j : Integer;
Begin
     Assign(F,Name1);Reset(F);
     Readln(F,n,m);
     Init;
     For i:=1 to n do
     Begin
          While Not(EOLN(F)) Do
          Begin
               Read(F,j);
               If j<>0 then A[i,j]:=1;
          End;
          Readln(F);
     End;
     Close(F);
End;
(*==========================================================================*)
Procedure KhoiTao;
Var
   i,j : Integer;
Begin
     For j:=1 to m do Xet[j]:=False;
     For i:=1 to n do
     Begin
          For j:=1 to m do
          If Not(Xet[j]) and (A[i,j]=1) then
          Begin
               Tho[i]:=j;
               Xet[j]:=True;
               Viec[j]:=i;
               Break;
          End;
     End;
     TimThay:=true;
End;
(*==========================================================================*)
Procedure DFS(v:Integer);
Var
   j : Integer;
Begin
     For j:=1 to m do
          If Not(Xet[j]) and (A[v,j]=1) then
          Begin
               Xet[j]:=True;
               Dau[j]:=v;
               If Viec[j]=0 then
               Begin
                    TimThay:=True;
                    Viec[j]:=v;
                    exit;
               End
               Else DFS(Viec[j]);
               If TimThay=False then Xet[j]:=False;
          End;
End;
(*==========================================================================*)
Procedure ChuanBiDFS;
Var
   j : Byte;
Begin
     For j:=1 to M do
     Begin
          Dau[j]:=0;
          Xet[j]:=False;
     End;
End;
(*==========================================================================*)
Procedure TimDuongTangCapGhep;
Var
   i : Integer;
Begin
     TimThay:=false;
     For i:=1 to n do
     If Tho[i]=0 then
     Begin
          ChuanBiDFS;
          DFS(i);
          If Timthay then exit;
     End;
End;
(*==========================================================================*)
Procedure DoiMau;
Var
   j : Integer;
Begin
     For j:=1 to m do
     If Xet[j] then
     Begin
          Viec[j]:=Dau[j];
          Tho[Dau[j]]:=j;
     End;
End;
(*==========================================================================*)
Procedure Main;
Begin
     While timThay Do
     Begin
          TimDuongTangCapGhep;
          If TimThay then DoiMau;
     End;
End;
(*==========================================================================*)
Procedure InKQ;
Var
   i,j : Integer;
Begin
     Assign(F,Name2);Rewrite(F);
     For j:=1 to n do
     If Tho[j]<>0 then Writeln(F,j,' lam viec ',Tho[j]);
     Close(F);
End;
(*==========================================================================*)
Begin
     Nhap;
     KhoiTao;
     Main;
     InKQ;
End.

 { Text 1}
5 3
1 2
2 3
3
1
1
 { Text 2}
3 3
1
1
1
 { Text 3}
5 12
1 2 4
1 2 3 7
3 4 5 8 9
5 6 11
6 8 9 10 12
 { Text 4}
5 12
1 2 4
1 2 4
1 4 5 8 9
5 6 11
6 8 9 10 12
 { Text 5}
5 6
1 2 3
1 2 3
2 1
4
1
 { Text 6}
6 7
1 2 4
6
1 2 7
3 4 5
5 7
3 6 7
 { Text 7}
6 7
1 2 4
0
1 2 7
3 4 5
5 7
3 6 7
 { Text 8}
5 6
1 3 6
2
1 4
5 6
5 6