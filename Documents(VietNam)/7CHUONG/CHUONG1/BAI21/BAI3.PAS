{ Le Van Hung K28 A2 Phan Boi Chau }
 { Bai 3 - De Thi HSGQG Nam 2000-2001}
Program Hoa_Tra_My ;
Uses Crt;
Const
     Fi='bl3.in6';
     Fo='bl3.out';
    Type
    Mang=Array[0..100,0..100]Of Longint;
Var
   Gia_Tri_Min:^Mang;
   S:Array[0..100,0..100]Of Integer;
   M,N,I,J:Integer;
   F,Fou:Text;
   Gia_Tri_Nho_Nhat:Longint;

Procedure Readfile;
 Begin
           New(Gia_Tri_Min);
      Assign(F,Fi);
      Reset(F);
      Readln(F,N,M);
      Fillchar(S,Sizeof(S),0);
      For I:=1 To M Do
       For J:=1 To N Do
        Read(F,S[I,J]);
      Close(F);
 End;

Procedure Init;
 Var I:Integer;
 Begin
      Fillchar(Gia_Tri_Min^,Sizeof(Gia_Tri_Min^),0);
      For I:=1 To N Do
       Gia_Tri_Min^[1,I]:=S[1,I];
 End;

Procedure Quy_Hoach_Dong;
 Var T:Longint;
     K:Integer;
 Begin
      For I:=2 To M Do
       For J:=1 To N Do
        Begin
             Gia_Tri_Min^[I,J]:=Gia_Tri_Min^[I-1,J];
             For K:=J Downto 0 Do
             If Gia_Tri_Min^[I,J]>Gia_Tri_Min^[I-1,K]+S[I,J-K] Then
             Gia_Tri_Min^[I,J]:=Gia_Tri_Min^[I-1,K]+S[I,J-K]
        End;
      Gia_Tri_Nho_Nhat:=Gia_Tri_Min^[M,N];
      writeln(Gia_Tri_Nho_Nhat);
 End;

Procedure Xuat(I:Integer);
 Var J:Integer;
 Begin
      If N>0 Then
      Begin
           J:=N;
           While Gia_Tri_Min^[I,N]<>Gia_Tri_Min^[I-1,N-J]+S[I,J] Do
            Dec(J);
            N:=N-J;
            Xuat(I-1);
            Write(Fou,J,' ');
      End
      Else
      Begin
           Writeln(Fou,Gia_Tri_Nho_Nhat);
           For J:=1 To I Do Write(Fou,0,' ');
      End;
 End;


Procedure Writefile;
 Var Luu,Luu_Tam:Integer;
 Begin
      Assign(Fou,Fo);
      Rewrite(Fou);
      Luu:=M;
      For I:=M-1 Downto 1 Do
       If Gia_Tri_Min^[I,N]=Gia_Tri_Min^[Luu,N] Then Luu:=i;
      Luu_Tam:=Luu;
      Xuat(Luu);
      For I:=Luu_Tam+1 To M Do Write(Fou,0,' ');
      Close(Fou);
       Dispose(Gia_Tri_Min);
 End;

Begin
     Readfile;

     Init;
     Quy_Hoach_Dong;
     Writefile;

End.
{
3 3
20 30 30
4 3 10
1 3 20

2 3
1 3
1 4
5 7


 }
