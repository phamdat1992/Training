Program sinh;
uses crt;
Const
     fo='xe.in';
     maxn=100;
Var
   a:array[1..maxn] of 0..maxlongint;
   b:array[1..maxn] of boolean;
   i,j:integer;
   f:text;
Function ok:boolean;
vAR
   I:integer;
Begin
     ok:=false;
     For i:=1 to maxn do
         if b[i]=true then exit;
     ok:=true;
End;

Begin
     Fillchar(b,sizeof(b),True);
     assign(f,fo);
     rewrite(f);
     writeln(f,maxn);
     j:=1;
     while not ok do
     begin
          q:=random(j)+1;
          j:=j+random(10);
          If b[q]=true then
          begin
               b[q]:=false;
               write(f,q,' ');
          end;
     end;
     close(f);
end.