Const Fi   ='XOSO.INP';
      Fo   ='XOSO.OUT';
      MaxN =100;
      MaxM =50;
      MaxK =10;
Var Card      :Array[1..MaxN,1..MaxM]of Word;
    Mark_inp  :Array[1..MaxN]of Word;
    Mark      :Array[1..MaxN]of Word;
    Result    :Array[0..MaxK]of Word;
    N,M,K     :Byte;
    i,j       :Byte;
    Time      :Longint;
    Time_f    :Longint absolute 0:$46c;
    inp,out   :Text;

Procedure Readfile;
Var c:Byte;
Begin
  Fillchar(Card,Sizeof(Card),0);
  Assign(inp,Fi);
  Reset(inp);
  Readln(inp,N,M,K);
  For i:=1 to N do
    Begin
      For j:=1 to K do
        Begin
          Read(inp,c);
          Card[i,c]:=1;
        End;
      Readln(inp,Mark_inp[i]);
    End;
  Close(inp);
  Assign(out,Fo);
  Rewrite(out);
End;

Procedure UpDate;
Var j1:Byte;
Begin
  For j1:=1 to N do
    If Mark[j1]<>Mark_inp[j1] Then Exit;
  For j1:=1 to K do
      Write(out,Result[j1],' ');
  Writeln(out);
End;

Function OK(j:Byte):Boolean;
Var i1:Byte;
Begin
  OK:=False;
  For i1:=1 to N do
    If Mark[i1]+Card[i1,j]>Mark_inp[i1] Then Exit;
  OK:=True;
  For i1:=1 to N do
     Mark[i1]:=Mark[i1]+Card[i1,j];
End;

Procedure Lend(j:Byte);
Var i1:Byte;
Begin
  For i1:=1 to N do
    Mark[i1]:=Mark[i1]-Card[i1,j];
End;

Procedure Try(i:Byte);
Var j:Byte;
Begin
  If i>K Then
    Begin
      Update;
      Exit;
    End;
  For j:=Result[i-1]+1 to M-K+i do
    If OK(j) Then
      Begin
        Result[i]:=j;
        Try(i+1);
        Lend(j);
      End;
End;

Procedure Process;
Begin
  Fillchar(Result,Sizeof(Result),0);
  Fillchar(Mark,Sizeof(Mark),0);
  Try(1);
  Close(out);
End;

BEGIN
  Time:=Time_f;
  Readfile;
  Process;
  Writeln('Time run:',(Time_f-Time)/18.21:13:13);
  Readln;
END.