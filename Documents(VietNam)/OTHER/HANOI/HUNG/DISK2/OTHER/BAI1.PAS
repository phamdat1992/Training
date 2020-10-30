
Uses Crt;
Const Fi='bai1.inp';
      MaxMN=100;
      Dx:Array[1..4]of Shortint=(0,1,0,-1);
      Dy:Array[1..4]of Shortint=(1,0,-1,0);
Var A,B:Array[0..MaxMN+1,0..MaxMN+1]of Word;
    LC,NC:Array[1..MaxMN]of Byte;
    Dem:Array[1..MaxMN*MaxMN Div 2]of Word;
    N,i,j:Byte;
    so:Word;
    f:Text;

Procedure Readfile;
Begin
  Fillchar(A,Sizeof(A),0);
  Assign(f,Fi);
  Reset(f);
  Readln(f,N);
  For i:=1 to N do
    For j:=1 to N do Read(f,A[i,j]);
  Close(f);
End;

Procedure Try(i,j:Byte);
Begin
  B[i,j]:=So;
  Inc(Dem[So]);
  If (A[i+Dx[1],j+Dy[1]]=1)And(B[i+Dx[1],j+Dy[1]]=0)
      Then Try(i+Dx[1],j+Dy[1]);
  If (A[i+Dx[2],j+Dy[2]]=1)And(B[i+Dx[2],j+Dy[2]]=0)
      Then Try(i+Dx[2],j+Dy[2]);
  If (A[i+Dx[3],j+Dy[3]]=1)And(B[i+Dx[3],j+Dy[3]]=0)
      Then Try(i+Dx[3],j+Dy[3]);
  If (A[i+Dx[4],j+Dy[4]]=1)And(B[i+Dx[4],j+Dy[4]]=0)
      Then Try(i+Dx[4],j+Dy[4]);
End;

Procedure Process;
Begin
  Fillchar(B,Sizeof(B),0);
  so:=0;
  Fillchar(Dem,Sizeof(dem),0);
  For i:=1 to N do
    For j:=1 to N do
      If (A[i,j]=1)And(B[i,j]=0) Then
        Begin
          inc(so);
          Try(i,j);
        End;
End;

Procedure Process2;
Var Min,j1:Byte;
Begin
   Fillchar(NC,Sizeof(NC),0);
   Fillchar(A,Sizeof(A),0);
   For i:=1 to N do
     Begin
       LC:=NC;
       For j:=1 to N do
        If B[i,j]<>0 Then
          Begin
            Nc[j]:=1;
            If (B[i,j]=B[i-1,j]) Then NC[j]:=LC[j]+1;
            Min:=NC[j];
            A[i,j]:=NC[j];
            j1:=j-1;
            While B[i,j1]=B[i,j] Do
              Begin
                If Min>NC[j1] Then Min:=NC[j1];
                If A[i,j]<Min*(j-j1+1) Then A[i,j]:=Min*(j-j1+1);
                Dec(j1);
              End;
          End;
     End;
End;

Procedure Result;
Var Max,i1,j1:Byte;
Begin
  For i:=1 to N do
    Begin
      For j:=1 to N do Write(B[i,j]:3);
      Writeln;
    End;
  If So=0 Then Begin Writeln('Khong co tap  nao cao');Exit;End;
  Max:=1;
  For i:=1 to So Do
    If Dem[Max]<Dem[i] Then Max:=i;
  Writeln('Tap co nhieu o nhat la ',max);
  i1:=1;j1:=1;
  For i:=1 to N do
    For j:=1 to N do
      If A[i1,j1]<A[i,j] Then
        Begin
          i1:=i;
          j1:=j;
        End;
   Writeln('Tap co hinh chu nhat lon nhat la:',B[i1,j1]);
End;

BEGIN
  Clrscr;
  Readfile;
  Process;
  Process2;
  Result;
  Readln;
END.
