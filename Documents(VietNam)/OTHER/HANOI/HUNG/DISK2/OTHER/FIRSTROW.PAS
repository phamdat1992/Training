Program Firstrow;
Uses crt;
Const
     fi='firstrow.inp';
     Fo='firstrow.out';
     Maxn=255;
Var
   a:array[1..maxn] of byte;

   i,j:integer;
   s:string;
   f1,f2:text;

Procedure Init;
Begin
     Assign(f2,fo);
     Rewrite(f2);

     Assign(f1,fi);
     Reset(f1);
End;

Procedure Main;
Begin
     Fillchar(a,sizeof(a),0);

     While not eof(f1) do
     Begin
          readln(f1,s);
          If s='#' then break;

          For i:=1 to length(s) do
              a[i]:=a[i] xor ord(s[i]);
     End;
End;

Procedure Done;
Begin
     For i:=1 to maxn do
         if a[i]<>0 then
          write(f2,chr(a[i]));

     Close(f1);
     Close(f2);
End;

BEGIN
     Clrscr;
     Init;
     Main;
     Done;
END.
123 123
456
123 123
#
