{$R+}
Program robot;
Uses crt;
Const
     F_in='robot.dat';
Var
   f:text;
   dd:string;
   huong:char;
   i,j,k,l:integer;
   u,v,n,m:integer;
   hx,hy,x1,y1:integer;
   b : array[0..200,0..200] of boolean;
   ll,out,error:boolean;
Procedure readf;
Begin
     assign(f,f_in);
     reset(f);
     readln(f,n,m);
     readln(f,u,v);
     readln(f,dd);
     close(f);
     x1:=u;
     y1:=v;
     hx:=x1;
     hy:=y1;
End;

Procedure init;
Begin
     Clrscr;
     readf;
     Fillchar(b,sizeof(b),False);
     error:=false;
     huong:='b';
End;

Procedure Main;
Begin
     out:=false;
     ll:=false;
     u:=u-1;
     v:=y1;
     huong:='b';
     For i:=2 to length(dd) do
     Begin
         case dd[i] of
              'T': begin
                        if (v<=0) or (u<=0) or (v>=m+1) or (v>=n+1) then begin out:=true;break;end;
                        case huong of
                        'b': begin
                                  hx:=u;
                                  hy:=v;
                                  huong:='t';
                                  v:=v-1;
                                  if (v<=0) or (u<=0) or (v>=m+1) or (v>=n+1) then begin out:=true;break;end;
                                  if b[u,v]=true then begin ll:=true;break;end
                                  else
                                  b[u,v]:=true;
                             end;
                        'n': begin
                                  hx:=u;
                                  hy:=v;
                                  huong:='d';
                                  v:=v+1;
                                  if (v<=0) or (u<=0) or (v>=m+1) or (v>=n+1) then begin out:=true;break;end;
                                  if b[u,v]=true then begin ll:=true;break;end
                                  else
                                  b[u,v]:=true;
                             end;
                        't': begin
                                  hx:=u;
                                  hy:=v;
                                  huong:='n';
                                  u:=u+1;
                                  if (v<=0) or (u<=0) or (v>=m+1) or (v>=n+1) then begin out:=true;break;end;
                                  if b[u,v]=true then begin ll:=true;break;end
                                  else
                                  b[u,v]:=true;
                             end;
                        'd': begin
                                  hx:=u;
                                  hy:=v;
                                  huong:='b';
                                  u:=u-1;
                                  if (v<=0) or (u<=0) or (v>=m+1) or (v>=n+1) then begin out:=true;break;end;
                                  if b[u,v]=true then begin ll:=true;break;end
                                  else
                                  b[u,v]:=true;
                             end;
                        end; {case};
                   end;


              'P': begin
                        if (v<=0) or (u<=0) or (v>=m+1) or (v>=n+1) then begin out:=true;break;end;
                        case huong of
                        'b': begin
                                  hx:=u;
                                  hy:=v;
                                  huong:='d';
                                  v:=v+1;
                                  if (v<=0) or (u<=0) or (v>=m+1) or (v>=n+1) then begin out:=true;break;end;
                                  if b[u,v]=true then begin ll:=true;break;end
                                  else
                                  b[u,v]:=true;
                             end;
                        'n': begin
                                  hx:=u;
                                  hy:=v;
                                  huong:='t';
                                  v:=v-1;
                                  if (v<=0) or (u<=0) or (v>=m+1) or (v>=n+1) then begin out:=true;break;end;
                                  if b[u,v]=true then begin ll:=true;break;end
                                  else
                                  b[u,v]:=true;
                             end;
                        't': begin
                                  hx:=u;
                                  hy:=v;
                                  huong:='b';
                                  u:=u-1;
                                  if (v<=0) or (u<=0) or (v>=m+1) or (v>=n+1) then begin out:=true;break;end;
                                  if b[u,v]=true then begin ll:=true;break;end
                                  else
                                  b[u,v]:=true;
                             end;
                        'd': begin
                                  hx:=u;
                                  hy:=v;
                                  huong:='n';
                                  u:=u+1;
                                  if (v<=0) or (u<=0) or (v>=m+1) or (v>=n+1) then begin out:=true;break;end;
                                  if b[u,v]=true then begin ll:=true;break;end
                                  else
                                  b[u,v]:=true;
                             end;
                        end; {case};
                   end;

        End; {case}
     End;
End;

Procedure Done;
Begin
     if out=true then
      begin
           Writeln('Bi out ra : ',u:3,v:3);
           Writeln('o truoc la: ',hx:3,hy:3);
      end;
     if ll=true then
      begin
           Writeln('Bi ll ra : ',u:3,v:3);
           Writeln('o truoc la: ',hx:3,hy:3);
      end;

     If (not ll) and (not out) then
        begin
             writeln('Ket thuc duong di khong bi out hoac lap lai');
             writeln('Ket thuc o o ',u:3,v:3);
        end;
End;

BEGIN
     INIT;
     MAIN;
     DONE;
END.

4 4
2 3
BTTPTTPTTPPP
