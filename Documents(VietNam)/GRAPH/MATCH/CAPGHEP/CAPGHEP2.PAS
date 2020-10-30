 { Tim toi uu Tho -- viec }
Program CAPGHEP;
Uses crt;
ConSt
     Name1 = 'Work2.inp';
     Name2 = 'Work2.out';
     MaxTho = 100;
     MaxViec = 100;
Type
    NhiPhan = 0..1;
    MaTranKe = Array [1..MaxTho*2,1..MaxViec] OF NhiPhan;
    Arr1Int = Array [1..MaxTho*2] Of Integer;
    Arr1Boo = Array [1..MaxTho*2] Of Boolean;
Var
   F : Text;
   A : MatranKe;
   n,m : Integer;
   Xet : Arr1Boo;
   Dau,Tho,Viec : Arr1Int;
   TimThay : Boolean;

(*------------------------------------------*)
Procedure Init;
Var
   i,j : Integer;
Begin
     For i:=1 to n do
     For j:=1 to m do Begin A[i,j]:=0; A[i+n,j]:=0; End;
     For i:=1 to n do Begin Tho[i]:=0; Tho[i+n]:=0; End;
     For j:=1 to m do Viec[i]:=0;
End;
(*------------------------------------------*)
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
               If j<>0 then
               Begin
                    A[i,j]:=1;
                    A[i+n,j]:=1;
               End;
          End;
          Readln(F);
     End;
     Close(F);
End;
(*------------------------------------------*)
Procedure khoiTao;
Var
   i,j : Integer;
Begin
     For j:=1 to m do Xet[j]:=False;
     For i:=1 to 2*n do
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
(*------------------------------------------*)
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
(*------------------------------------------*)
Procedure TimDuongTangCapGhep;
Var
   i,j : Integer;
Begin
     TimThay:=false;
     For i:=1 to 2*n do
     If Tho[i]=0 then
     Begin
          For j:=1 to M do
          Begin
               Dau[j]:=0;
               Xet[j]:=False;
          End;
          DFS(i);
          If Timthay then exit;
     End;
End;
(*------------------------------------------*)
Procedure DoiMau;
var
   j : Integer;
Begin
     For j:=1 to m do
     if Xet[j] then
     Begin
          Viec[j]:=Dau[j];
          Tho[Dau[j]]:=j;
     End;
End;
(*------------------------------------------*)
Procedure Main;
Begin
     While timThay Do
     Begin
          TimDuongTangCapGhep;
          If TimThay then DoiMau;
     End;
End;
(*------------------------------------------*)
Procedure InKQ;
Var
   i,j,Soviec : Integer;
Begin
     Assign(F,Name2);Rewrite(F);
     For i:=1 to n do
     Begin
          Soviec:=0;
          If (Tho[i]<>0) or (Tho[i+n]<>0) then Write(F,'Tho ',i,' lam viec ');
          IF Tho[i]<>0 then
          Begin
               Write(F,Tho[i]:3);
               Inc(Soviec);
          End;
          IF Tho[i+n]<>0 then
          Begin
               Write(F,Tho[i+n]:3);
               Inc(Soviec);
          End;
          For j:=1 to m do
          If (Viec[j]=0) and (A[i,j]=1) then
             Begin
                  Write(F,j:3);
                  Viec[j]:=i;
                  Inc(Soviec);
             End;
          Writeln(F);
          If Soviec<2 then
          Begin
               Write(#7);
               Write(F,' Xin loi ! Khong phan cong duoc cho moi tho it nhat 2 viec');
               Close(F);
               Exit;
               Close(F);
          End;
     End;
     Close(F);
End;
(*------------------------------------------*)
Begin
     nhap;
     KhoiTao;
     Main;
     inKq;
End.

 { Text 1}
5 3
1 2
2 3
3
1
1
 { Text 1}
3 3
1
1
1
 { Text 1}
5 12
1 2 4
1 2 3 7
3 4 5 8 9
5 6 11
6 8 9 10 12
 { Text 1}
5 12
1 2 4
1 2 4
1 4 5 8 9
5 6 11
6 8 9 10 12
 { Text 2}
5 6
1 2 3
1 2 3
2 1
4
1
 { Text 3}
6 7
1 2 4
6
1 2 7
3 4 5
5 7
3 6 7
 { Text 4}
6 7
1 2 4
0
1 2 7
3 4 5
5 7
3 6 7
 { Text 5
 }
5 6
1 3 6
2
1 4
5 6
5 6