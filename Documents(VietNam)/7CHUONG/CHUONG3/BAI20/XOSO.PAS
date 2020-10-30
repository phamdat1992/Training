Program All_For_You;
Uses Crt;
Const
     Fi='Xoso0.';
     {Lungtung\Hoctap\De3\Bai2.inp';}
     Fo='Xoso.out';
Var
   F:Text;
   A:Array[1..100,1..51]Of Integer;
   M,N,K,i,j:Integer;
   Xoso:Array[0..10]Of Integer;

Procedure Readfile;
 Begin
      Assign(F,Fi);
      Reset(F);
      Readln(F,N,M,K);
      For i:=1 To N Do
       For j:=1 To K+1 Do
        Read(F,A[i,j]);
      Close(F);
 End;

Procedure Init;
 Begin
      Fillchar(Xoso,sizeof(xoso),0);
 End;

Function Kt:Boolean;
 Var I:Integer;
 Begin
      Kt:=False;
      For I:=1 To N Do
       If A[I,K+1]<>0 Then Exit;
      Kt:=True;
 End;

Function Kiemtra(i:Byte):Boolean;
 Begin
      Kiemtra:=False;
      If A[i,K+1]=0 Then Exit;
      Kiemtra:=True;
 End;

Function Xet(i:Byte):Boolean;
 Var T1,T2:Integer;
 Begin
      Xet:=False;
      For T1:=1 To N Do
       For T2:=1 To K Do
        IF (A[T1,T2]=i)And(Not Kiemtra(T1)) Then Exit;
      Xet:=True;
 End;

Procedure Xuat;
 Var t:Integer;
 Begin
      If Kt Then
      Begin
           For t:=1 To K Do
            Write(F,Xoso[t],' ');
            Writeln(f);
      End;
 End;

Procedure Bot(i:Integer);
 Var T1,T2:Integer;
 Begin
      For T1:=1 To N Do
       If A[t1,K+1]<>0 Then
       For T2:=1 To K Do
        If A[t1,T2]=i Then Dec(a[t1,k+1]);
 End;

Procedure Them(i:Integer);
 Var T1,T2:Integer;
 Begin
      For T1:=1 To N DO
       For T2:=1 To K do
        If A[T1,T2]=i then inc(A[T1,K+1]);
 End;

Procedure Try(i:Integer);
 Var j:Byte;
 Begin
      For j:=Xoso[i-1]+1 To M Do
      If Xet(j) Then
      Begin
           Xoso[i]:=j;
           Bot(Xoso[i]);
           If i=K Then Xuat
           Else Try(i+1);
           Them(Xoso[i]);
           Xoso[i]:=0;
      End;
 End;

Procedure Writefile;
 Begin
      Assign(F,Fo);
      Rewrite(F);
      Try(1);
      Close(F);
 End;

Begin
     Readfile;
     Init;
     Writefile;
End.



5 9 4
2 4 6 8 2
5 6 8 9 0
2 4 5 6 2
1 2 3 7 3
3 5 6 9 1
