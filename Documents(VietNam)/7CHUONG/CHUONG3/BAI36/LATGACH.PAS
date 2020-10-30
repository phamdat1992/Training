{SR+}
Uses Crt;
Const Fi='Inp.B9';
      Fo='Out.B9';
      MaxN=16;
      Dx:Array[1..8]of -1..1 = (0,-1,-1,-1,0,1,1,1);
      Dy:Array[1..8]of -1..1 = (-1,-1,0,1,1,1,0,-1);
      Tx:Array[1..4]of -1..1 = (0,0,1,-1);
      Ty:Array[1..4]of -1..1 = (-1,1,0,0);
Var f,ft:Text;
    A:Array[1..MaxN,1..MaxN,1..3]Of 0..8;
    B,B1:Array[1..MaxN,1..MaxN] Of 0..3;
    H:Array[1..MaxN,1..MaxN] Of Byte;
    Qx,Qy,S:Array[1..256]Of Byte;
    n,m,i,j,X:Integer;
    Stop:Boolean;
Procedure ReadF;
Begin
 Assign(f,Fi);
 Reset(f);
 Assign(ft,Fo);
 ReWrite(ft);
 Readln(f,n,m);
 For i:=1 to n do
  For j:=1 to m do
   Begin
    Read(f,X);
    A[i,j,3]:=X div 81;
    x:=x mod 81;
    A[i,j,2]:=x div 9;
    A[i,j,1]:=x mod 9;
    If A[i,j,1]+A[i,j,2]+A[i,j,3]>8 Then
     Begin
      Writeln(ft,'0');Close(ft);Halt;
     End;
   End;
 Close(f);
End;
Procedure ReSult;
Var i,j:Integer;
Begin
 Writeln(ft,'1');
 For i:=1 to n do
  Begin
   For j:=1 to m do Write(ft,B[i,j]);
   Writeln(ft);
  End;
 B1:=B;
 Stop:=True;
End;
Procedure Try(i,j:Integer;Var Stop:Boolean);
Var k,t:Integer;
    Ok:Boolean;
Begin
 If Stop Then Exit;
 For k:=1 to 3 do
  Begin
   Ok:=True;
   For t:=1 to 8 do
    If (i+Dx[t]>0)And(i+Dx[t]<=n)And(j+Dy[t]>0)And(j+Dy[t]<=m)And
     (A[i+Dx[t],j+Dy[t],k]=0)Then Begin Ok:=False;Break;End;
   If Ok Then
    Begin
     For t:=1 to 8 do
      If (i+Dx[t]>0)And(i+Dx[t]<=n)And(j+Dy[t]>0)And(j+Dy[t]<=m) Then
                      Dec(A[i+Dx[t],j+Dy[t],k]);
     B[i,j]:=k;
     If (i=n)And(j=m) Then ReSult Else
     If j<m Then Try(i,j+1,Stop) Else Try(i+1,1,Stop);
     B[i,j]:=0;
     For t:=1 to 8 do
      If (i+Dx[t]>0)And(i+Dx[t]<=n)And(j+Dy[t]>0)And(j+Dy[t]<=m) Then
                      Inc(A[i+Dx[t],j+Dy[t],k]);
    End;
  End;
End;
Procedure ProlemB;
Var d,Solt,i,j:Integer;
 Procedure Find(i,j:Integer);
 Var u,v,d,c,k:Integer;
 Begin
  d:=1;c:=1;
  H[i,j]:=Solt;
  S[Solt]:=1;
  Qx[1]:=i;Qy[1]:=j;
  While d<=c Do
   Begin
    u:=Qx[d];v:=Qy[d];Inc(d);
    For k:=1 to 4 do
     If (u+Tx[k]>0)And(u+Tx[k]<=n)And(v+Ty[k]>0)And(v+Ty[k]<=m)And
      (B[u+Tx[k],v+Ty[k]]=B[u,v])And(H[u+Tx[k],v+Ty[k]]=0) Then
       Begin
        H[u+Tx[k],v+Ty[k]]:=Solt;
        Inc(c);Inc(S[Solt]);
        Qx[c]:=u+Tx[k];Qy[c]:=v+Ty[k];
       End;
   End;
 End;
 Procedure QSort(l,r:Integer);
 Var i,j,Tg,Mid:Integer;
 Begin
  i:=l;j:=r;Mid:=S[(l+r) Div 2];
  Repeat
   While S[i]<Mid Do Inc(i);
   While S[j]>Mid Do Dec(j);
   If i<=j Then
    Begin Tg:=S[i];S[i]:=S[j];S[j]:=Tg;
          Tg:=Qx[i];Qx[i]:=Qx[j];Qx[j]:=Tg;
          Inc(i);Dec(j);
    End;
  Until i>=j;
  If i<r Then QSort(i,r);
  If l<j Then QSort(l,j);
 End;
Begin
 Solt:=0;
 FillChar(H,SizeOf(H),0);
 For i:=1 to n do
  For j:=1 to m do
   If H[i,j]=0 Then
    Begin
     Inc(Solt);
     Find(i,j);
    End;
 Writeln(ft,Solt);
 For i:=1 to n do
  Begin
   For j:=1 to m do Write(ft,H[i,j]:4);
   Writeln(ft);
  End;
 d:=0;
 FillChar(Qy,SizeOf(Qy),0);
 For i:=1 to Solt do
  Begin
   Qx[i]:=i;
   If Qy[S[i]]=1 Then Inc(d);
   Qy[S[i]]:=1;
  End;
 QSort(1,Solt);
 Writeln(ft,Solt-d);
 For i:=1 to Solt do Write(ft,Qx[i]:4);
End;
Procedure Solution;
Begin
 ReadF;
 FillChar(B,SizeOf(B),0);
 Stop:=False;
 Try(1,1,Stop);
 If Not Stop Then
  Begin Writeln(ft,'0');Close(ft);Halt;End;
 B:=B1;
 ProlemB;
 Close(ft);
End;
BEGIN
 Clrscr;
 Solution;
END.
