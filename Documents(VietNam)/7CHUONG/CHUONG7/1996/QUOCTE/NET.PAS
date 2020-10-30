Program NetWork_of_Schools;
Uses crt;
Var A:array[1..100,1..100] of 0..1;
    D,C,M:array[1..100] of Byte;
    n,vg:integer;

Procedure KhoiTri;
  Begin
       Fillchar(A,sizeof(A),0);
       Fillchar(D,sizeof(D),0);
       Fillchar(C,sizeof(C),0);
       Fillchar(M,sizeof(M),0);
  End;

Procedure Dulieu;
  Var f:text;
      i,j:integer;
  Begin
       Assign(f,'Net.inp');
       Reset(f);
       Readln(f,n);
       For i:=1 to n do
           begin
                Read(f,j);
                if j<>0 then
                   begin
                        A[i,j]:=1;
                        Inc(d[i]); Inc(c[j]);
                        While Not SeekEoln(f) do
                              begin
                                   Read(f,j);
                                   A[i,j]:=1; Inc(d[i]); Inc(c[j]);
                              end;
                   end;
                Readln(f);
           end;
       close(f);
  End;

Procedure Run(k:integer);
  Var i:integer;
  Begin
       For i:=1 to n do
           if (A[i,k]=1) or (a[k,i]=1) then
              if M[i]=0 then
                 begin
                      M[i]:=vg;
                      Run(i);
                 end;
  End;

Procedure PhanVung;
  Var i:integer;
  Begin
       vg:=0;
       For i:=1 to n do
           if m[i]=0 then
              begin
                   Inc(vg);
                   m[i]:=vg;
                   Run(i);
              end;
  End;

Function Max(K1,k2:Integer):Integer;
  Begin
       If K1>k2 then Max:=k1 else Max:=k2;
  End;

Procedure ProMain;
  Var i,j,Td,Tc,Cuoi,Dau:integer;
  Begin
       TD:=0; TC:=0;
       For i:=1 to Vg do
           begin
                Dau:=0; Cuoi:=0;
                For j:=1 to n do
                    if m[j]=i then
                       begin
                            If D[j]=0 then Inc(Dau);
                            If C[j]=0 then Inc(Cuoi);
                       end;
                if Dau=0  then Td:=Td+1 else Td:=Td+dau;
                if Cuoi=0 then Tc:=Tc+1 else Tc:=Tc+cuoi;
           end;
      Writeln('Cau A : ',Tc);
      Write('Cau B : ');
      if (Vg=1) then
           Write(Max(cuoi,dau))
      else Write(Max(Tc,td));
  End;

Begin
     Clrscr;
     KhoiTri;
     Dulieu;
     PhanVung;
     ProMain;
     Readln;
End.

11
0
1
2 4
1
4
7
6 9
7 10
11
11
0


5
2 3 4 5
1 3 4 5
1 2 4 5
1 2 3 5
1 2 3 4



