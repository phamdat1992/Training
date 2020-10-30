Program   Khoi_Phuc_Ngoac;
Const
     fi = 'brackets.inp';
     fo = 'brackets.out';
     nMax = 10000;
Var
     ifl, ofl : Text;
     n : Integer;
     B : array [1..2 * nMax] of char;

 Procedure   AllPrograms;
 Var
     i, x, M : Integer;
 Begin
     FillChar(B, SizeOf(B), '?');
     Assign(ifl, fi); Reset(ifl);
     Assign(ofl, fo); Rewrite(ofl);
     ReadLn(ifl, n);
     for i := 1 to 2 * n do
       if B[i] = '?' then
         begin
           Read(ifl, x);
           B[i] := '('; B[i + x + 1] := ')';
         end;
     for i := 1 to 2 * n do Write(ofl, B[i]);
     Close(ifl); Close(ofl);
 End;

Begin
     AllPrograms;
End.