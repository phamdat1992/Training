PROGRAM Day_con_cuc_dai;
Uses Crt;
Var  A, B   :Array[1..100] Of  Integer;
     max,j,d,i,n :integer;
BEGIN
Clrscr;
Write('Cho so phan tu day N= ');
Readln(N);
For i:=1 to n do
Begin
Write('A[',i,']= ');
Readln(A[i]);
B[i]:=1;
End;
d:=1;

For i:=2 To n Do
Begin
max:=1;
For j:=1 to i-1 do
if (A[i]>A[j]) And (B[j]+1>=max) Then max:=B[j]+1;
B[i]:=max;
if max>d Then d:=max;
End;
max:=maxint;
Writeln('Day con cuc dai gom ',d,' phan tu ');
For i:=n Downto 1 Do
if (B[i]=d) And (max>-A[i]) Then
Begin
Dec(d);
max:=A[i];
B[i]:=-1;
End;
For i:=1 To n Do
if B[i]=-1 Then Write(A[i], ' ');
Readln;
END.
 

