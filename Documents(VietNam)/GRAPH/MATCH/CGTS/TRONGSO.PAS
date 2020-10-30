        { Cap ghep co trong so }

Program CapGhepTrongSo;
Uses Crt;
Const
     Name1 = 'Trongso.inp';
     Name2 = 'Trongso.out';
     Max = 10;
Type
    Arr2Int = Array [1..Max,1..Max] Of Integer;
    Arr1Int = Array [1..Max] Of Integer;
    Arr1Boo = Array [1..Max] Of Boolean;
Var
   F : Text;
   C : Arr2Int;
   S_,T_,Fx,Fy,Tho,Viec : Arr1Int;
   n : Integer;
   TimThay : Boolean;

(*-------------------------------------------------*)
Procedure Init;
Var
   i : Byte;
Begin
     For i:=1 to n do
     Begin
          S_[i]:=0;
          T_[i]:=0;
          Tho[i]:=0;
          Viec[i]:=0;
     End;
End;
(*-------------------------------------------------*)
Procedure Nhap;
Var
   i,j : Integer;
Begin
     Assign(F,Name1);
     Read(n);
     For i:=1 to n do
     Begin
          Readln(F);
          For j:=1 to n do Read(F,C[i,j]);
     End;
     Close(F);
     Init;
End;
(*-------------------------------------------------*)
Procedure KhoiTao;
Var
   i,j : Byte;
Begin
     For i:=1 to n do
     Begin
          Fy[i]:=0;
          Fx[i]:=0;
     End;
     For i:=1 to n do
     For j:=1 to n do
         If C[i,j]>Fx[i] then Fx[i]:=C[i,j];
     TimThay:=True;
End;
(*-------------------------------------------------*)
Function Min:Integer;
Var
   S:Integer;
   i,j : Byte;
Begin
     S:=MaxInt;
     For i:=1 to n do
         For j:=1 to n do
             If (S_[i]<>0) and (T_[j]=0) then
             If S>(Fx[i]+Fy[j]-C[i,j]) then S:=(Fx[i]+Fy[j]-C[i,j]);
     Min:=S;
End;
(*-------------------------------------------------*)
Function TimDinhTuDo:Boolean;
Var
   i : Byte;
Begin
     TimDinhTuDo:=False;
     For i:=1 to n do
         If Viec[i]=0 then timDinhTuDo:=True;
End;
(*-------------------------------------------------*)
Procedure DFS(v:Integer);
Var
   i : Integer;
Begin
     For i:=1 to n do
          If Not(Xet[i]) and (A[v,i]=1) then
          Begin
               Xet[i]:=True;
               Dau[i]:=v;
               If Viec[i]=0 then
               Begin
                    TimThay:=True;
                    Viec[i]:=v;
                    exit;
               End
               Else DFS(Viec[i]);
               If TimThay=False then Xet[i]:=False;
          End;
End;
(*-------------------------------------------------*)
Procedure TimDuongTangCapGhep;
Var
   i,j : Integer;
Begin
     TimThay:=false;
     For i:=1 to n do
     If Tho[i]=0 then
     Begin
          For j:=1 to n do
          Begin
          End;
          DFS(i);
          If Timthay then exit;
     End;
End;
(*-------------------------------------------------*)
Procedure DoiMau;
Var
   i : Integer;
Begin
     For i:=1 to n do
     If Xet[j] then
     Begin
          Viec[j]:=Dau[j];
          Tho[Dau[j]]:=j;
     End;
Begin

End;
(*-------------------------------------------------*)
Procedure SuaNhan;
Var
   i,j : Byte;
Begin
     For i:=1 to n do
     Begin
          If S_[i]<>0 then Dec(Fx[i]);
          If T_[j]<>0 then Inc(Fy[i]);
End;
(*-------------------------------------------------*)
Procedure Main;
Begin
     While TimDinhTuDo Do
     Begin
          TimDuongTangCapGhep;
          If TimThay then DoiMau
          else SuaNhan;
     End;
End;
(*-------------------------------------------------*)
Procedure InKQ;
Begin

End;
(*-------------------------------------------------*)
Begin
     Nhap;
     KhoiTao;
     Main;
     InKQ;
End.