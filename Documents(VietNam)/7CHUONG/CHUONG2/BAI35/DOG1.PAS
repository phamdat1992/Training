{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 65520,0,655360}

PROGRAM Dog_Travel_Problem;
 Const
  InpName          = 'DOG.INP';
  OutName          = 'DOG.OUT';
  MaxPoints        = 100;
 Type
  Point            = Record
                      x,y : Integer;
                     End;
  Path             = Array [1..MaxPoints] Of Point;
  RLine            = Array [1..MaxPoints] Of Byte;
  RMatrix          = Array [1..MaxPoints,1..MaxPoints] Of Byte;
 Var
  AttachFile       : Text;
  N,M,i,L          : Byte;
  ManPath,DogPath,
  AttractivePoints : Path;
  CanVisit         : RMatrix;
 Procedure ReadFile;
  Begin
   Assign(AttachFile,InpName);Reset(AttachFile);
   Readln(AttachFile,N,M);
   For i := 1 to N do Read(AttachFile,ManPath[i].x,ManPath[i].y);
   Readln(AttachFile);
   For i := 1 to M do Read(AttachFile,AttractivePoints[i].x,AttractivePoints[i].y);
   Dec(N);
   Close(AttachFile);
  End;
 Procedure WriteFile;
  Begin
   Assign(AttachFile,OutName);ReWrite(AttachFile);
   Writeln(AttachFile,L);
   For i := 1 to L do Write(AttachFile,DogPath[i].x,#32,DogPath[i].y,#32);
   Close(AttachFile);
  End;
 Procedure MakeRelation;
  Var
   j : Byte;
  Function Distance(A,B : Point) : Real;
   Begin
    Distance := Sqrt(Sqr(A.x - B.x) + Sqr(A.y - B.y));
   End;
  Begin
   Fillchar(CanVisit,SizeOf(CanVisit),0);
   For i := 1 to N do
    For j := 1 to M do
     If Distance(ManPath[i],AttractivePoints[j]) + Distance(ManPath[i+1],AttractivePoints[j]) <=
        2*Distance(ManPath[i],ManPath[i+1]) Then
      CanVisit[i][j] := 1;
  End;
 Procedure MakeDogPath;
  Var
   Previous,Queue,
   VisitA,VisitB  : RLine;
   Found          : Boolean;
   j,Failed       : Byte;
  Procedure FindFrom(Source : Byte;var Target : Byte);
   Var
    Head,Last,u,v : Byte;
   Begin
    Fillchar(Previous,SizeOf(Previous),0);
    Fillchar(Queue,SizeOf(Queue),0);
    Head := 1;Last := 1;
    Queue[1] := Source;
    Previous[1] := N+M+1;
    Found := False;
    Target := 0;
    Repeat
     u := Queue[Head];
     Inc(Head);
     If u <= N Then
      Begin
       For v := 1 to M do
        If (CanVisit[u][v] <> 0)and(VisitA[u] <> v + N) Then
         Begin
          Inc(Last);
          Queue[Last] := v + N;
          Previous[v + N] := u;
          If VisitB[v] = 0 Then
           Begin
            Found := True;
            Target := v + N;
            Break;
           End;
         End;
      End Else
     If u > N Then
      Begin
       For v := 1 to N do
        If (CanVisit[v][u - N] <> 0)and(VisitB[u - N] = v) Then
         Begin
          Inc(Last);
          Queue[Last] := v;
          Previous[v] := u;
         End;
      End;
    Until (Found)or(Head > Last);
   End;
  Procedure Add(Source,Target : Byte);
   Var
    i,j : Byte;
   Begin
    j := Target;
    Repeat
     If j > N Then
      Begin
       i := Previous[j];
       VisitA[i] := j - N;
       VisitB[j - N] := i;
      End;
     j := i;
    Until j = Source;
   End;
  Begin
   Fillchar(VisitA,SizeOf(VisitA),0);
   Fillchar(VisitB,SizeOf(VisitB),0);
   Repeat
    Failed := 0;
    For i := 1 to N do
     If VisitA[i] = 0 Then
      Begin
       FindFrom(i,j);
       If Found Then
        Begin
         Add(i,j);
         Break;
        End
       Else Inc(Failed);
      End Else Inc(Failed);
   Until Failed = N;
   L := 0;
   For i := 1 to N do
    Begin
     Inc(L);DogPath[L] := ManPath[i];
     If VisitA[i] <> 0 Then
      Begin
       Inc(L);DogPath[L] := AttractivePoints[VisitA[i]];
      End;
    End;
   Inc(L);DogPath[L] := ManPath[N+1];
  End;
BEGIN
 ReadFile;
 MakeRelation;
 MakeDogPath;
 WriteFile;
END.
DOG.INP
4 5
1 4 5 7 5 2 -2 4
-4 -2 3 9 1 2 -1 3 8 -3