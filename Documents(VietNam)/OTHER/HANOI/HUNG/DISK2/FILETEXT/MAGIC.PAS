
Program Magic_IOI96;
Uses Crt;
Const Fi='Magic.inp';
      Fo='Man_hinh.out';
      MaxMagic=40320 div 2;
      MaxQ=32000;
type Data=record
          Ch :Char;
          Last:Word;
       End;
    Magic_Init=array[1..MaxMagic] of Data;
      Magic   =array[1..8]of Byte;
Var   Box    :array[0..1]of ^Magic_Init;
      GT     :array[0..8]of Word;
       Q     :array[1..MaxQ] of Word;
       Way   :array[1..400]of Char;
    Finished :Word;
      A,B    :Magic;
      i,j    :Word;
    Number   :Word;
     Time_f  :Longint absolute 0:$46C;
     Time_s  :Longint;

Procedure Readfile;
Var F:Text;
Begin
  Writeln('INPUT');
  Assign(F,Fi);
  {$I-}
  Reset(F);
  {$I+}
  If IOresult<>0 then
    Begin
      Writeln('Find not found');
      Readln;
      Halt;
    End;
  For i:=1 to 8 do
    Begin
      Read(f,A[i]);
      Write(A[i],' ');
    End;
  Writeln;
  Close(F);
End;

Procedure Init;
Begin
  For i:=0 to 1 do
    Begin
      New(Box[i]);
      For j:=1 to MaxMagic do
        Begin
          Box[i]^[j].Ch:='S';
          Box[i]^[j].Last:=0;
        End;
    End;
  Box[0]^[1].Ch:='F';   {Trang thai dau tien khong can phai bien doi}
  GT[0]:=1;
  For i:=1 to 9 do GT[i]:=GT[i-1]*i; {Tinh giai thua}
End;

     {Buoc bien doi A}
Procedure Change_A;
Var Middle:Byte;
Begin
  For i:=1 to 4 do
    Begin
      Middle:=A[i];
      A[i]:=A[9-i];
      A[9-i]:=Middle;
    End;
End;

     {Buoc bien doi B}
Procedure Change_B;
Var Middle:Byte;
Begin
  Middle:=A[4];
  For i:=4 downto 2 do A[i]:=A[i-1];
  A[1]:=Middle;Middle:=A[5];
  For i:=  5 to 7 do A[i]:=A[i+1];
  A[8]:=Middle;
End;

     {Buoc bien doi C}
Procedure Change_C;
Var Middle:Byte;
Begin
  Middle:=A[2];
  A[2]:=A[7];
  A[7]:=A[6];
  A[6]:=A[3];
  A[3]:=Middle;
End;

      {Tinh gia tri thu tu tu dien cua trang thai}
Function Pos(A:Magic):Word;
Var P:Word;
    k:Byte;
Begin
  P:=1;
  For i:=1 to 7 do
    Begin
      k:=0;
      For j:=i+1 to 8 do
        If A[j]<A[i] then k:=k+1;
      P:=P+k*GT[8-i];
    End;
  Pos:=P;
End;

     {Doi tu thu tu tu dien sang trang thai}
Procedure Change(P:Word;Var A:Magic);
Var  D  :Word;
    Flag:array[1..8]of Boolean;
Begin
  D:=P-1;
  Fillchar(Flag,Sizeof(Flag),True);
  For i:=1 to 8 do
    Begin
      A[i]:=D div GT[8-i]+1;
      D:=D mod GT[8-i];
      For j:=1 to 8 do
        Begin
          If Flag[j] then A[i]:=A[i]-1;
          If A[i]=0 then break;
        End;
      A[i]:=j;Flag[j]:=False;

    End;
End;

Procedure Process;
Var  Front,Rel :Word;
        P      :Word; {Thu tu tu dien cua trang thai truoc khi bien doi}
     P_Next    :word; {Thu tu tu dien cua trang thai sau khi bein doi}
Begin
  Finished:=Pos(A);
  If Finished=1 then Exit;
  Front:=1;Rel:=2;Q[1]:=1;
  Q[1]:=1;
  While Front<>Rel do
    Begin
      P:=Q[Front];Front:=Front+1;
      {Het hang doi phai quay vong}
      If Front=MaxQ+1 then Front:=1;
      Change(P,A);B:=A;

      {Thu buoc bien doi A}
      A:=B;Change_A;P_Next:=Pos(A);
      i:=(P_Next-1)Div MaxMagic;
      j:=(P_Next-1)Mod MaxMagic+1;
      If Box[i]^[j].Ch='S' then
        Begin
          Box[i]^[j].Ch:='A';
          Box[i]^[j].Last:=P;
          Q[Rel]:=P_Next;
          Rel:=Rel+1;
          {Het hang doi phai quay vong}
          If Rel=MaxQ+1 then Rel:=1;
          If P_Next=Finished then Exit;
        End;

      {Thu buoc bien doi B}
      A:=B;Change_B;P_Next:=Pos(A);
      i:=(P_Next-1) Div MaxMagic;
      j:=(P_Next-1) Mod MaxMagic+1;
      If Box[i]^[j].Ch='S' then
        Begin
          Box[i]^[j].Ch:='B';
          Box[i]^[j].Last:=P;
          Q[Rel]:=P_Next;
          Rel:=Rel+1;
          {Het hang doi phai quay vong}
          If Rel=MaxQ+1 then Rel:=1;
          If P_Next=Finished then Exit;
        End;

      {Thu buoc bien doi C}
      A:=B;Change_C;P_Next:=Pos(A);
      i:=(P_Next-1) Div MaxMagic;
      j:=(P_Next-1) Mod MaxMagic+1;
      If Box[i]^[j].Ch='S' then
        Begin
          Box[i]^[j].Ch:='C';
          Box[i]^[j].Last:=P;
          Q[Rel]:=P_Next;
          Rel:=Rel+1;
          {Het hang doi phai quay vong}
          If Rel=MaxQ+1 then Rel:=1;
          If P_Next=Finished then Exit;
        End;
    End;
End;

Procedure Result;
Var {Ghi nhan lai cac buoc bien doi}
    P:Word;
Begin
  Writeln('OUTPUT');
  Number:=0;P:=Finished;
  i:=(P-1) Div MaxMagic;
  j:=(P-1) Mod maxMagic+1;
  While Box[i]^[j].Ch<>'F' do
    Begin
      Number:=Number+1;
      Way[Number]:=Box[i]^[j].Ch;
      P:=Box[i]^[j].Last;
      i:=(P-1) Div MaxMagic;
      j:=(P-1) Mod MaxMagic+1;
    End;
  Writeln(Number);
  For i:=Number downto 1 do Write(Way[i],' ');
  Writeln;
End;

Procedure KiemTra;
Var i,j,Start:Word;
Begin
  Start:=1;
  For i:=Number Downto 1 Do
    Begin
      Change(Start,A);
      For j:=1 to 4 Do Write(A[j],' ');
      Writeln;
      For j:=8 Downto 5 Do Write(A[j],' ');
      Writeln;
      Writeln(Way[i]);Readln;
      Case Way[i] Of
        'A':Change_A;
        'B':Change_B;
        'C':Change_C;
        End;
      Start:=Pos(A);
    End;
  For j:=1 to 4 Do Write(A[j],' ');
      Writeln;
      For j:=8 Downto 5 Do Write(A[j],' ');
      Writeln;
End;


Procedure Finish;
Begin
  Writeln('Program finished');
  Writeln('Time run:',(Time_f-Time_s)/18.21:15:13,' s');
  Readln;
End;

BEGIN
  Time_s:=Time_f;
  Clrscr;
  Readfile;
  Init;
  Process;
  Result;
  Finish;
 END.






