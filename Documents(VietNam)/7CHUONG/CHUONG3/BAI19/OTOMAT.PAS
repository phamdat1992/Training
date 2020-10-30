{ B§i 85 ( Trang 84-85 )  Sªch B§i t¾p PASCAL - T¡m & My }

Uses Crt;
Type    State   = Array [ 1..8 ] of Byte;

Const   Fin     = 'Otomat.Inp';
        Fon     = 'Otomat.Out';

Var     Fi,Fo                  : Text;
        Queue                  : Array [0..255] of Byte;
        Pred                   : Array [0..255] of Integer;
        Tested                 : Array [0..255] of Boolean;
        Act                    : Array [0..255] of Char;
        FirstState,LastState   : Byte;
        Top,Bottom             : Word;
        Found                  : Boolean;
        I                      : Byte;
        Sts,Sta                : State;


{ Procedures and Functions }

Procedure DtoB(Dec: Byte; Var Bits: State);
Var Tmp : State;
    I   : Byte;
Begin
  For I:=8 downto 1 do
  Begin
    Tmp[i]:=Dec mod 2;
    Dec:=Dec div 2;
  End;
  Bits:=Tmp;
End;

Procedure BtoD(Bits: State; Var Dec: Byte);
Var I   : Byte;
    Tmp : Byte;
Begin
  Tmp:=0;
  For I:=1 to 8 do
  Begin
    Tmp:=Tmp * 2;
    Tmp:=Tmp + Bits[i];
  End;
  Dec:=Tmp;
End;

Procedure Initialize;
Var I     : Byte;
    St    : State;
Begin
  Assign(Fi,Fin);
  Reset(Fi);
  Writeln('Start State : ');
  For I:=1 to 8 do
  Begin
    Read(Fi,St[i]);
    Write(St[i]);
  End;
  BtoD(St,FirstState);
  Readln(Fi);
  Writeln;
  Writeln('Last State : ');
  For I:=1 to 8 do
  Begin
    Read(Fi,St[i]);
    Write(St[i]);
  End;
  BtoD(St,LastState);
  Close(Fi);
  Writeln;
  For I:=0 to 255 do
  Begin
    Queue[i]:=0;
    Pred[i]:=-1;
    Tested[i]:=FALSE;
  End;
  Top:=0;
  Bottom:=0;
  Queue[Top]:=FirstState;
  Tested[FirstState]:=TRUE;
  Found:=FALSE;
End;

Procedure BallWithA(St: State; Var NewSt: State);
Var Tmp: State;
Begin
  Tmp:=St;
  If Tmp[1]=0 then
  Begin
    Tmp[1]:=1;
    If Tmp[4]=0 then
      Begin
        Tmp[4]:=1;
        If Tmp[7]=0 then Tmp[7]:=1
                    else Tmp[7]:=0;
      End
      Else
      Begin
        Tmp[4]:=0;
        If Tmp[6]=0 then Tmp[6]:=1
                    else Tmp[6]:=0;
      End;
  End
  Else
  Begin
    Tmp[1]:=0;
    If Tmp[6]=0 then Tmp[6]:=1
                else Tmp[6]:=0;
  End;
  NewSt:=Tmp;
End;

Procedure BallWithB(St: State; Var NewSt: State);
Var Tmp: State;
Begin
  Tmp:=St;
  If Tmp[2]=0 then
  Begin
    Tmp[2]:=1;
    If Tmp[5]=0 then
    Begin
      Tmp[5]:=1;
      If Tmp[8]=0 then Tmp[8]:=1
                  else Tmp[8]:=0;
    End
    Else
    Begin
      Tmp[5]:=0;
      If Tmp[7]=0 then Tmp[7]:=1
                  else Tmp[7]:=0;
    End;
  End
  Else
  Begin
    Tmp[2]:=0;
    If Tmp[4]=0 then
    Begin
      Tmp[4]:=1;
      If Tmp[7]=0 then Tmp[7]:=1
                  else Tmp[7]:=0;
    End
    Else
    Begin
      Tmp[4]:=0;
      If Tmp[6]=0 then Tmp[6]:=1
                  else Tmp[6]:=0;
    End;
  End;
  NewSt:=Tmp;
End;

Procedure BallWithC(St: State; Var NewSt: State);
Var Tmp: State;
Begin
  Tmp:=St;
  If Tmp[3]=1 then
  Begin
    Tmp[3]:=0;
    If Tmp[5]=0 then
      Begin
        Tmp[5]:=1;
        If Tmp[8]=0 then Tmp[8]:=1
                    else Tmp[8]:=0;
      End
      Else
      Begin
        Tmp[5]:=0;
        If Tmp[7]=0 then Tmp[7]:=1
                    else Tmp[7]:=0;
      End;
  End
  Else
  Begin
    Tmp[3]:=1;
    If Tmp[8]=0 then Tmp[8]:=1
                else Tmp[8]:=0;
  End;
  NewSt:=Tmp;
End;

Procedure BFS;
Var TmpBS,TmpBD : State;
    TmpD : Byte;
Begin
  While Top<=Bottom do
  Begin
    DtoB(Queue[Top],TmpBS);

{ Th¨ hßn bi v§o lç A }
    BallWithA(TmpBS,TmpBD);
    BtoD(TmpBD,TmpD);
    If not Tested[TmpD] then
    Begin
      Tested[TmpD]:=TRUE;
      Bottom:=Bottom+1;
      Queue[Bottom]:=TmpD;
      Pred[TmpD]:=Queue[Top];
      Act[TmpD]:='A';
      If TmpD=LastState then
      Begin
        Found:=TRUE;
        Exit;
      End;
    End;
{ Th¨ hßn bi v§o lç B }
    BallWithB(TmpBS,TmpBD);
    BtoD(TmpBD,TmpD);
    If not Tested[TmpD] then
    Begin
      Tested[TmpD]:=TRUE;
      Bottom:=Bottom+1;
      Queue[Bottom]:=TmpD;
      Pred[TmpD]:=Queue[Top];
      Act[TmpD]:='B';
      If TmpD=LastState then
      Begin
        Found:=TRUE;
        Exit;
      End;
    End;
{ Th¨ hßn bi v§o lç C }
    BallWithC(TmpBS,TmpBD);
    BtoD(TmpBD,TmpD);
    If not Tested[TmpD] then
    Begin
      Tested[TmpD]:=TRUE;
      Bottom:=Bottom+1;
      Queue[Bottom]:=TmpD;
      Pred[TmpD]:=Queue[Top];
      Act[TmpD]:='C';
      If TmpD=LastState then
      Begin
        Found:=TRUE;
        Exit;
      End;
    End;
    Top:=Top+1;
  End;
End;

Procedure PrintResult;
Var I: Byte;
Begin
  If (not Found) or (Pred[FirstState]>=0) then Writeln(' N O   S O L U T I O N')
  Else
  Begin
    Writeln('The Shortest Way is :');
    I:=LastState;
    Writeln(LastState:4,' <ÄÄ ',Act[I],' ÄÄÄ');
    While Pred[I]<>FirstState do
    Begin
      Writeln(Pred[I]:4,' <ÄÄ ',Act[I],' ÄÄÄ');
      I:=Pred[I];
    End;
    Writeln(FirstState:6);
  End;
End;

{ Main Program }

Begin
  Clrscr;

  Initialize;
  BFS;
  PrintResult;
{}
{  sts[1]:=1;
  sts[2]:=1;
  sts[3]:=0;
  sts[4]:=0;
  sts[5]:=1;
  sts[6]:=1;
  sts[7]:=1;
  sts[8]:=0;
  BallWithA(Sts,Sta);
  Sts:=Sta;
  BallWithB(Sts,Sta);
  Sts:=Sta;
  BallWithB(Sts,Sta);
  Sts:=Sta;
  BallWithA(Sts,Sta);
  Sts:=Sta;
  BallWithA(Sts,Sta);
  Sts:=Sta;
  BallWithC(Sts,Sta);
  Readln;
  For I:=1 to 8 do Writeln('        G',i,': ',Sta[i]);
  For I:=1 to 8 do Writeln('G',i,': ',Sts[i]);
  sts[1]:=0;
  sts[2]:=1;
  sts[3]:=1;
  sts[4]:=0;
  sts[5]:=0;
  sts[6]:=0;
  sts[7]:=1;
  sts[8]:=1;
  BtoD(sts,i);
  writeln(i);

  {BtoD(Sta,i);
  dtob(i,Sta);
  writeln(i);
  For I:=1 to 8 do Writeln('G',i,': ',Sta[i]);
  Writeln(FirstState,' ',LastState);{}

  readln;
End.