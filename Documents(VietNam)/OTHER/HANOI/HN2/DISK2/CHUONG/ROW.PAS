Const
     fi='FIRSTROW.IN987654321';
     Fo='FIRSTROW.OUT';
Var
   a        :       Array [1..255] of byte;
   s        :       String;
   f        :       Text;
   i,j,m,n  :       Integer;
BEGIN
     Fillchar(a,sizeof(a),0);
     Assign(f,fi);
     Reset(f);
     m:=0;
     readln(f,s);
     For i:=1 to length(s) do a[i]:=a[i] xor  ord(s[i]);

     While not eof(f) do
     begin
          readln(f,s);
          if s='#' then break;
          For i:=1 to length(s) do a[i]:=a[i] xor  ord(s[i]);
     end;

     writeln;
     s:='';

     for i:=1 to 255 do
         if a[i]<>0 then s:=s+chr(a[i]);
     Close(f);

     Assign(f,fo);
     Rewrite(f);
     writeln(f,s);
     close(f);

END.

a
a
b
c
c
#