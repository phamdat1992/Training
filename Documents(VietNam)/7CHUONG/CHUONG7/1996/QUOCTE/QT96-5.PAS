{$R-,S-,Q-,I-,E-,N+}
Program Prefix;
Const
    FData='INOUT\DATA.TXT';
    FInput='INOUT\INPUT-A.TXT';
    FOutput='INOUT\OUTPUT.TXT';
Var
    l:Array[1..30]of Byte;
    s:Array[1..30]of String[20];
    a:Array[1..40]of Char;
    b:Array[1..41]of Byte;
    l1,k,m,p,h,n,i,j:LongInt;
    s1:String;
    f:Text;
Procedure Input;
Begin
    l1:=MemL[0:$46C];
    Assign(f,FInput);
    Reset(f);
    Readln(f,n);
    For i:=1 to n do Begin
        Readln(f,l[i]);
        Readln(f,s[i]);
    End;
    Assign(f,FData);
    Reset(f);
End;
Procedure Process;
Procedure Read20;
Begin
    i:=0;
    FillChar(a,SizeOf(a),0);
    While (i<20)and(Not(EOF(f))) do Begin
        Inc(i);
        Readln(f,a[i+20]);
    End;
End;
Procedure Read20m;
Begin
    Move(a[21],a[1],20);
    FillChar(a[21],20,0);
    i:=0;
    While (i<20)and(Not(EOF(f))) do Begin
        Inc(i);
        Readln(f,a[i+20]);
    End;
End;
Procedure Find1;
Begin
    FillChar(b,SizeOf(b),0);
    b[21]:=1;
    Repeat
        h:=0;
        For i:=21 to 40 do If b[i]=1 Then
            For j:=1 to n do If (l[j]+i<=41)and(b[l[j]+i]=0) Then Begin
                Move(a[i],s1[1],l[j]);
                s1[0]:=Chr(l[j]);
                If s1=s[j] Then Begin
                    h:=1;
                    b[l[j]+i]:=1;
                End;
            End;
    Until h=0;
End;
Procedure Find2;
Begin
End;
Begin
    Read20;
    Find1;
    For i:=1 to 41 do If b[i]=1 Then j:=i-1;
    p:=0;
    If Not EOF(f) Then Repeat
        Inc(p,20);
        Read20m;
        Move(b[21],b[1],21);
        FillChar(b[21],21,0);
        m:=0;
        Repeat
            k:=0;
            For i:=1 to 40 do If b[i]=1 Then
                For j:=1 to n do If (l[j]+i<=41)and(b[l[j]+i]=0) Then Begin
                    Move(a[i],s1[1],l[j]);
                    s1[0]:=Chr(l[j]);
                    If s1=s[j] Then Begin
                        k:=1;
                        b[l[j]+i]:=1;
                        m:=1;
                    End;
                End;
        Until k=0;
    Until (m=0)or(EOF(f));
    For i:=1 to 41 do If b[i]=1 Then j:=i-1;
    Writeln(p+j-20);
End;
Procedure Output;
Begin
    Assign(f,FOutput);
    ReWrite(f);
    Writeln(f,p+j-20);
    Close(f);
    Writeln('Time used:',(MemL[0:$46C]-l1)/18.2:0:2);
End;
Begin
    Input;
    Process;
    Output;
End.