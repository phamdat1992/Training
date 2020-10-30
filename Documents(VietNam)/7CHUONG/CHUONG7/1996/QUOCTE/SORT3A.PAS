Program Sorting_a_three_valued_sequence;
Uses crt;
Var A,C:array[1..1000] of 1..3;
    B:array[1..3] of Integer;
    n,dem:integer;
    Kt:boolean;
    out:text;

Procedure KhoiTri;
  Begin
       Fillchar(b,sizeof(b),0);
       Fillchar(a,sizeof(a),0);
       Dem:=0;
       kt:=false;
       Assign(out,'Sort.out');
       rewrite(out);
  End;

Procedure Dulieu;
  Var f:text;
      i:integer;
  Begin
       Assign(f,'Sort\Input-a.txt');
       Reset(f);
       Readln(f,n);
       For i:=1 to n do
           begin
                readln(f,a[i]);
                write(A[i]:3);
                Inc(B[a[i]]);
           end;
       writeln;
       C:=A;
       B[2]:=b[1]+b[2];
       B[3]:=b[2]+b[3];
       Close(f);
  End;

Procedure TraoTri(k1,k2:integer);
  var p:integer;
  Begin
       P:=A[k1];
       A[k1]:=A[k2];
       A[k2]:=p;
       Inc(dem);
       if kt then Writeln(out,k1:5,k2:5);
  End;

Procedure Tim(k,h,Gt:integer);
  Var i:integer;
  Begin
       For i:=b[h]+1 to b[h+1] do
           if A[i]=Gt then
              begin
                   TraoTri(k,i);
                   exit;
              end;
  End;

Procedure Buoc1;
  Var i:integer;
  Begin
       For i:=1 to b[1] do
           if a[i]=2 then Tim(i,1,1)
           else
               if a[i]=3 then Tim(i,2,1);
       For i:=b[1]+1 to b[2] do
           if a[i]=3 then Tim(i,2,2);
  End;

Procedure Buoc2;
  Var i:integer;
  Begin
       For i:=1 to b[1] do
           if a[i]>1 then
              begin
                   Tim(i,1,1);
                   if a[i]>1 then Tim(i,2,1);
              end;
       For i:=b[1]+1 to b[2] do
           if a[i]=3 then Tim(i,2,2);
  End;

Procedure ProMain;
  Begin
       Buoc1;
       Buoc2;
       Kt:=true;
       A:=C;
       writeln(dem);
       writeln(out,dem);
       Buoc1;
       Buoc2;
       Close(out);
  End;

Begin
     Clrscr;
     KhoiTri;
     Dulieu;
     ProMain;
     Readln;
End.

2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
2 1 3 1 2 1 3 2 3 1 2 3 1 2 3 2 1 2 3 1 2 3 1 2 3 1 2
