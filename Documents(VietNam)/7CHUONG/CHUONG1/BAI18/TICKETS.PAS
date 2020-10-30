{ Le Van Hung K28 A2 Phan Boi Chau}
{ Problem : Mua Ve tau Hoa}

Program Hoa_Tra_My ;
Const
     Fi = 'C:\Data\Hung\Hanoi0\Rticket\RTICKET.IN4';
     Fo = 'C:\Data\Hung\Tap1\Bai102.Out';
Type
  Kieu = array[1..10000] of LongInt;

Var
  A,B: ^Kieu;
  i1, i2, i3,l1, l2, l3,c1, c2, c3,i, j, n,x1, x2,t: LongInt;
  f1,f2 : Text;

Procedure Init;
Begin
    assign(f1,Fi );
    reset(f1);
    new(A);
    new(B);
    FillChar(B^, SizeOf(B^), 0);
    assign(f2, Fo);
    rewrite(f2);
End;

Procedure ReadFile;
Begin
    readln(f1, l1, l2, l3, c1, c2, c3);
    readln(f1, n);
    readln(f1, x1, x2);
    if (x1<x2) then
    begin
        i:=x1;
        j:=x2;
    end
    else
    begin
        i:=x2;
        j:=x1;
    end;
    x1 := i;
    x2 := j;
    A^[1] := 0;
    for i:=2 to n do
    begin
         readln(f1,t);
         a^[i]:=t;
    end;

End;

Procedure Xuli;
Begin
    i1 := x1;
    i2 := x1;
    i3 := x1;
    for i:=x1+1 to x2 do
    begin
        while (A^[i]-A^[i1])>l1 do inc(i1);
        while (A^[i]-A^[i2])>l2 do inc(i2);
        while (A^[i]-A^[i3])>l3 do inc(i3);
        B^[i] := B^[i3] + c3;
        if (i<>i2) then
            if (B^[i2]+c2)<B^[i] then   B^[i] := B^[i2] + c2;
        if (i<>i1) then
            if (B^[i1]+c1)<B^[i] then   B^[i] := B^[i1] + c1;
    end;

End;

Procedure WriteFile;
Begin
    writeln(f2, B^[x2]);
End;

Procedure Done;
Begin
    close(f1);
    close(f2);
    dispose(a);
    dispose(b);

End;

BEGIN
     Init;
     ReadFile;
     Xuli;
     WriteFile;
     Done;
END.
