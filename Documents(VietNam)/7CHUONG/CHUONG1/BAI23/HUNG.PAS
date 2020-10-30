{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
PROGRAM BAY_TRANH;
USES CRT;
CONST
     DATINP     = 'TRANH.I0';
     DATOUT     = 'TRANH.hu2';
     MAXN       = 50;
     MAXM       = 100;
Var
   f:text;
   n,m          :longint;
   k1           :longint;
   reco         :longint;
   c            :array[1..MAXN] of longint;
   a,b,b1       :array[1..MAXN,1..MAXM] of byte;
   w,w1         :array[0..MAXN,0..MAXM+1] of longint;
Procedure Start;
Var
   i,j:longint;
Begin
     Assign(f,DATINP);reset(f);
     Readln(f,n,m);
     For i:=1 to n do read(f,c[i]);
     For i:=1 to n do
      For j:=1 to m do read(f,a[i,j]);
     Close(f)
End;

{+-------------------------------------------------------------------------+}

Procedure BoMotTranh(k:longint);
Var
   j,i:longint;
Begin
     For j:=1 to m do
      Begin
           For i:=1 to k-1 do
            b[i,j]:=a[i,j];
           For i:=k+1 to n do
            b[i-1,j]:=a[i,j]
      End
End;

{+-------------------------------------------------------------------------+}

Procedure KhoiTao;
Var
   i,j:longint;
Begin
     For i:=1 to n-1 do
      Begin
           w[i,i-1]:=0;
           w[i-1,i-1]:=0
      End
End;

Procedure XuliTrenB;
Var
   i,j:longint;
Begin
     KhoiTao;
     For i:=1 to n-1 do
      For j:=i to m do
       Begin
            W[i,j]:=w[i-1,j-1]+b[i,j];
            If w[i,j]<w[i,j-1] then
             W[i,j]:=w[i,j-1]
       End
End;

Procedure CapNhat(k:longint);
Begin
     If reco<c[k]+w[n-1,m] then
      Begin
           Reco:=c[k]+w[n-1,m];
           K1:=k;
           W1:=w;
           B1:=b
      End
End;

{+-------------------------------------------------------------------------+}

Procedure WorkingOut;
Var
   i:longint;
Begin
     Reco:=0;
     For i:=1 to n do
      Begin
           BoMotTranh(i);
           XuliTrenB;
           CapNhat(i)
      End
End;

{+-------------------------------------------------------------------------+}

Procedure LanDuongDi;
Var
   i,j,d:longint;
   kq:array[1..MAXM] of longint;
Begin
     I:=n-1;
     J:=m;
     D:=0;
     While (i>0) and (j>0) do
      Begin
           If w1[i,j]=w1[i-1,j-1]+b1[i,j] then
            Begin
                 Inc(d);
                 Kq[d]:=j;
                 Dec(i);
                 Dec(j)
            End
             Else
              Begin
                   Dec(j);
              End
      End;
     Writeln(f,k1);
     For i:=d downto 1 do write(f,kq[i],' ')
End;

Procedure Finish;
Begin
     Assign(f,DATOUT);rewrite(f);
     Writeln(f,Reco);
     LanDuongDi;
     Close(f);
End;

BEGIN
     Clrscr;
     Start;
     WorkingOut;
     Finish
END.