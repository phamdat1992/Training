{ Le VAn Hung K28 A2 Phan Boi Chau -Nghe An}
{ Bai Wires -Thay Nghia -Hoc Doi Tuyen Nam 2000-2001}
Program Hoa_Tra_My;
Uses Crt;
Const
     Fi='C:\Data\Hung\Hanoi2\Wires\Wires.in9876543210'; {Quyen3\Bai12.inp';}
     Fo='C:\Data\Hung\Quyen3\Bai12.out';
Var
   A,MaxD,Luu:Array[1..1000]Of Integer;
   Ok:Array[1..1000]Of Boolean;
   Luu_Gia_Tri,Gia_Tri_Max,N,i,j:Integer;
   F:Text;
Procedure Readfile;
 Begin
      Assign(f,Fi);
      Reset(f);
      Readln(f,n);
      For i:=1 To n Do
       Read(f,A[i]);
      Close(f);
 End;

Function Vitri(i:Integer):Integer;
 Var j:Integer;
 Begin
      For j:=1 To N Do
       If A[j]=i Then
       Begin
            Vitri:=j;
            Exit;
       End;
 End;

Procedure Init;
 Begin
      Fillchar(MaxD,Sizeof(MaxD),0);
      Luu:=MaxD;
      Fillchar(Ok,Sizeof(Ok),True);
      Gia_Tri_Max:=0;
 End;

Procedure Xuli;
 Var Max:Integer;
 Begin
      For i:=1 To n Do
       Begin
            Max:=0;
            For j:=1 To Vitri(i) Do
             If Max<MaxD[A[j]] Then
             Begin
                  Max:=MaxD[A[j]];
                  Luu[i]:=A[j];
             End;
            MaxD[i]:=Max+1;
       End;
      For i:=1 To n Do
       If Gia_Tri_Max<MaxD[i] Then
       Begin
            Gia_Tri_Max:=MaxD[i];
            Luu_Gia_Tri:=i;
       End;
      Ok[Luu_Gia_Tri]:=False;
      J:=Luu[Luu_Gia_tri];
      While j<>0 Do
       Begin
            Ok[j]:=false;
            i:=j;
            j:=Luu[i];
       End;
 End;

Procedure Writefile;
 Begin
      Assign(f,Fo);
      Rewrite(f);
      Writeln(f,Gia_Tri_Max);
      For i:=1 To n Do
      If Not Ok[i] Then
      Write(f,i,' ');
      Close(f);
 End;

Begin
     Init;
     Readfile;
     Xuli;
     Writefile;
End.

9
2 5 3 8 7 4 6 9 1



