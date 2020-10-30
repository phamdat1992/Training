{$M 65000,0,655360}
Const
  Kt=8;     { KÝch th­íc b¶ng }
  M   =40320; { =Kt! }
  fi='input-8.txt';
  fo='output.txt';
Type
  Bd =Array[1..Kt] Of 1..Kt;
  Ht=Array[1..Kt] Of 1..Kt;
Const
  Thuan  :Array['A'..'C'] Of Bd=((8,7,6,5,4,3,2,1), { C¸c biÕn ®æi c¬ b¶n }
                                 (4,1,2,3,6,7,8,5),
                                 (1,7,2,4,5,3,6,8));
  Nguoc:Array['A'..'C'] Of Bd=((8,7,6,5,4,3,2,1), { Ng­îc cña c¸c biÕn ®æi}
                                 (2,3,4,1,8,5,6,7),
                                 (1,3,6,4,5,7,2,8));
  Htd :Ht=(1,2,3,4,5,6,7,8);                { H×nh tr¹ng b¾t ®Çu }
Var
  T    :Ht;                                  { H×nh tr¹ng ®Ých }
  s:String;           { D·y c¸c biÕn ®æi chuyÓn h×nh tr¹ng ®Çu thµnh ®Ých}
  Gt :Array[0..Kt] Of Longint;       { C¸c gi¸ trÞ tõ 0! den 8! }
  Last :Array[0..M] Of Char;
               { Last[Rank(T)] lµ ký tù cuèi cïng cña d·y c¸c biÕn ®æi }
          { chuyÓn h×nh tr¹ng ®Çu vÒ h×nh tr¹ng ®Ých T }
                      {NÕu Last[Rank(T)]=' ' thi T kh«ng ®­îc sinh ra }
Procedure ReadInput;
  Var InFile:Text;
    i:Word;
  Begin
    Assign(InFile,fi); Reset(Infile);
    For i:=1 To Kt Do Read(Infile,T[i]);
    Close(Infile);
  End { ReadInput };
Procedure Tinhgt;
  Var i:Word;
  Begin
    Gt[1]:=1;Gt[0]:=1;
    For i:=2 To Kt Do
      Gt[i]:=i*Gt[i-1];
  End;
Function Rank( P:Ht): Word;
  Var Res,l,i,j:Word;
  Begin
    Res:=0;
    For i:=1 To Kt Do Begin
      l:=0;              { l la so cac phan tu cua P o cac vi tri tu }
                         { 1..i-1 nho hon P[i]                }
      For j:=1 To i-1 Do
        If P[j]<P[i] Then Inc(l);
      { Gi÷ cè ®Þnh i-1 phÇn tö ®Çu tiªn cña P th× co(P[i]-1-l) }
      { sè nhá h¬n P[i] t¹i vÞ trÝ i trong c¸c ho¸n vÞ  }
      { Sè c¸c ho¸n vÞ Q mµ i-1 phÇn tö ®Çu tiªn gièng nh­ cña P    }
      { nh­ng ®øng tr­íc P theo thø tù tõ ®iÓn b»ng (P[i]-1-l)*Gt[Kt-i].            }
      Res:=Res+(P[i]-1-l)*Gt[Kt-i];
    End { For };
    Rank:=Res;
  End { Rank };
Procedure Apply( T:Ht; X:Char; Var R:Ht);
{ R nhËn ®­îc b»ng c¸ch ¸p dông biÕn ®æi X ®èi víi h×nh tr¹ng T}
  Var i:Word;
  Begin
    For i:=1 To Kt Do R[i]:=T[Thuan[X][i]];
  End { Apply };
Procedure Apply_1( T:Ht; X:Char; Var R:Ht);
{ R nhËn ®­îc b»ng c¸ch ¸p dông biÕn ®æi ng­îc cña BiÕn
®æi X ®èi víi h×nh tr¹ng T}
  Var i:Word;
  Begin
    For i:=1 To Kt Do R[i]:=T[Nguoc[X][i]];
  End {Apply_1};
Function bang( R,T:Ht): Boolean;
{ ®óng nÕu R=T }
  Var i:Word;
  Begin
    bang:=true;
    for i:=1 to kt do if R[i]<>T[i] then begin bang:=false;exit;end;
  End { bang };
Procedure sinh;
{ Sinh d·y c¸c biÕn ®æi chuyÓn h×nh tr¹ng b¾t ®Çu thµnh h×nh tr¹ng    }
{ ®Ých T. Last[Rank(T)] lµ phÇn tö cuèi cïng cña d·y}
  Const
    Qs=7000;  { Kich thuoc danh sach }
  Var
    Queue:Array[0..Qs-1] Of Ht;
    NotFound:Boolean;
    Head,Tail,i,rankQ:Word;
    R,S: Ht;
    X: Char;
Begin { sinh }
    For i:=0 To M Do Last[i]:=' '; { Khoi tao }
    Last[0]:='.';                  { 0=Rank(Htd) }
    Head:=0; Tail:=1;
    Queue[0]:=Htd;
    NotFound:=True;
    While NotFound Do
          Begin
          R:=Queue[Head];
          Inc(Head); If Head=Qs Then Head:=0;
          For X:='A' To 'C' Do
              Begin
              Apply(R, X, S);
              RankQ:=Rank(S);
              If Last[RankQ]=' ' Then
                 Begin
                 Last[RankQ]:=X;
                 If bang(T,S) Then
                    Begin
                    NotFound:= False;
                    Break;
                    End;
                 Queue[Tail]:=s;
                 Inc(Tail); If Tail=Qs Then Tail:=0;
                 end;
              End;
          End;
End { sinh };
Procedure tim;
{ X©y dùng d·y c¸c phÐp biÕn ®æi }
  Var
    RankQ:Word; X:Char;
    P,Q  : Ht;
  Begin
    Q:=T;
    RankQ:=Rank(Q);
    S:='';
    While RankQ <> 0 Do Begin { while Q<>Htd                  }
      X:=Last[RankQ];
      S:=X+S;
      Apply_1(Q,X,P);
      Q:=P;
      RankQ:=Rank(Q);
    End { While };
  End { tim };
Procedure WriteOut;
  Var OutFile:Text;
    L,i:Word;
  Begin
    Assign(OutFile,fo); Rewrite(OutFile);
    L:=Length(s);
    WriteLn(OutFile,L);
    For i:=1 To L Do  WriteLn(OutFile,s[i]);
    Close(OutFile);
  End { WriteOut };
BEGIN { Program }
  ReadInput;
  Tinhgt;
  sinh;
  tim;
  WriteOut;
END.
