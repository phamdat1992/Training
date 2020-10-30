{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65384,0,655360}
PROGRAM NOI_DIEN;
USES CRT;
CONST
     DATINP     = 'NOIDAY.IN5';
     DATOUT      = 'NOIDAY.OUT';
     MAXN       = 101;
Var
   f            :text;
   n            :longint;
   min          :real;
   gi           :longint;
   chiphi       :real;
   cx           :array[0..MAXN] of boolean;
   front        :array[0..MAXN] of byte;
   a,b,d        :array[0..MAXN] of real;
   K            :array[0..MAXN,0..MAXN] of real;

Procedure Start;
Var
   i:longint;
Begin
     Assign(f,DATINP);reset(f);
     Readln(f,n);
     A[0]:=0;
     B[0]:=0;
     For i:=1 to n do
      Read(f,a[i],b[i]);
     Close(f)
End;

{+-------------------------------------------------------------------------+}

Function KhoangCach(i,j:longint):real;
Begin
     KhoangCach := sqrt(sqr(a[i]-a[j])+sqr(b[i]-b[j]))
End;

Procedure XayDungMaTranKe;
Var
   i,j:longint;
Begin
     For i:=0 to n do
      For j:=0 to n do
       K[i,j]:=KhoangCach(i,j)
End;

{+-------------------------------------------------------------------------+}

Procedure KhoiTao;
Var
   i,j:longint;
Begin
     ChiPhi:=0;
     For i:=1 to n do d[i]:=K[i,0];
     For i:=1 to n do cx[i]:=true;
     For i:=0 to n do front[i]:=0
End;

{+-------------------------------------------------------------------------+}

Procedure TimdinhCoDmin;
Var
   i:longint;
Begin
     Min:=maxlongint;
     For i:=1 to n do
      If cx[i] and (min>d[i]) then
       Begin
            Min:=d[i];
            Gi:=i
       End
End;

Procedure DanhDau;
Begin
     Cx[gi]:=false;
     ChiPhi:=ChiPhi+min
End;

Procedure GanLaiNhan;
Var
   i:longint;
Begin
     For i:=1 to n do
      If cx[i] and (d[i]>K[i,gi]) then
       Begin
            D[i]:=K[i,gi];
            Front[i]:=gi
       End
End;

Procedure TimCayKhung;
Var
   i:longint;
Begin
     For i:=1 to n do
      Begin
           TimdinhCoDmin;
           DanhDau;
           GanLaiNhan
      End
End;

{+-------------------------------------------------------------------------+}

Procedure WorkingOut;
Begin
     XayDungMaTranKe;
     KhoiTao;
     TimCayKhung
End;

{+-------------------------------------------------------------------------+}

Procedure Finish;
Var
   i,j:longint;
   c:array[0..MAXN,0..MAXN] of byte;
{+}
   Procedure TaoMangC;
   Var
      i,tg:longint;
   Begin
        Fillchar(c, sizeof (c), 0);
        For i:=0 to n do
         Begin
              Tg:=i;
              While front[tg]<>tg do
               Begin
                    C[tg,front[tg]]:=1;
                    C[front[tg],tg]:=1;
                    Tg:=front[tg]
               End
         End
   End;
{+}
Begin
     TaoMangC;
     Assign(f,DATOUT);Rewrite(f);
     Writeln(f,n);
     For i:=0 to n do
      Begin
           For j:=0 to n do
            If c[i,j]<>0 then
             Begin
                  Writeln(f,i,' ',j);
                  C[i,j]:=0;
                  C[j,i]:=0
             End
      End;
     Close(f)
End;

BEGIN
     Start;
     WorkingOut;
     Finish
END.