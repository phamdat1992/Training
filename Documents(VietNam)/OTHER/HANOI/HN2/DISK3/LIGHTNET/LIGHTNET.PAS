Program Lightnet;
Uses crt;
Const
	Fi='lightnet.inp';
    Fo='lightnet.out';
    maxn=50;
Var
   i,j,m,n,k:integer;
   luu,a,b:array[1..maxn,1..maxn] of integer;
   f:array[0..maxn,0..maxn] of integer;
   s:string;
   F2:TEXT;
   p:boolean;

Procedure Chuyen(s:string;l:integer);
Var
   i,j:integer;
   so:integer;
   k:integer;
Begin
     For i:=1 to length(s) do s[i]:=upcase(s[i]);

     j:=pos('  ',s);
     While j<>0 do
     begin
          delete(s,j,1);
          j:=pos('  ',s);
     end;

     If s[1]=' ' then delete(s,1,1);

     so:=1;
     k:=0;
     repeat
           Case s[so] of
                'B': begin
                          inc(k);
                          a[l,k]:=1;
                          so:=so+5;
                     end;

                'R': Begin
                          inc(k);
                          a[l,k]:=0;
                          so:=so+4;
                     End;
           end;
     until so>length(s);
End;

Procedure Chuyenb(s:string;l:integer);
Var
   i,j:integer;
   k,so:integer;
Begin
     For i:=1 to length(s) do s[i]:=upcase(s[i]);

     j:=pos('  ',s);
     While j<>0 do
     begin
          delete(s,j,1);
          j:=pos('  ',s);
     end;

     If s[1]=' ' then delete(s,1,1);

     so:=1;
     k:=0;
     repeat
           Case s[so] of
                'B': begin
                          inc(k);
                          b[l,k]:=1;
                          so:=so+5;
                     end;

                'R': Begin
                          inc(k);
                          b[l,k]:=0;
                          so:=so+4;
                     End;
           end;
     until so>length(s);
End;

Procedure nutden(so:integer);
Var
   i,j:integer;
Begin
     For i:=1 to m do
         if a[so,i]=1 then a[so,i]:=0 else a[so,i]:=1;
End;

Procedure nuttrang(l,t:integer);
Var
   i,j:integer;
   tg:integer;
Begin
     For i:=1 to n do
     begin
          tg:=a[i,l];
          a[i,l]:=a[i,t];
          a[i,t]:=tg;
     end;
End;

Function ok:boolean;
Var
   i,j:integer;
Begin
     ok:=false;

     For i:=1 to n do
         for j:=1 to m do
             if a[i,j]<>b[i,j] then exit;

     ok:=true;
ENd;

Function on(i,j:integer):boolean;
Var
   l,t:integer;
Begin
     on:=False;
     For l:=1 to i do
         for t:=1 to j do
             if a[l,t]<>b[l,t] then exit;
     on:=True;
End;

Procedure xuly;
Begin
     luu:=a;
     p:=false;

     If ok then
     begin
          writeln(f2,'YES');
          p:=true;
          exit;
     end;

     for i:=1 to m do
         for j:=1 to m do
         begin
              nuttrang(i,j);

              If ok then
              begin
                   writeln(f2,'YES');
                   p:=true;
                   exit;
              end;

              a:=luu;
         end;

     For i:=1 to n do
     begin
          nutden(i);
          If ok then
          begin
               writeln(f2,'YES');
               p:=true;
               exit;
          end;

          a:=luu;
     end;

     For i:=1 to n do
     begin
          luu:=a;
          nutden(i);
          For j:=1 to m do
          begin
               nuttrang(i,j);
               if ok then
               begin
                    writeln(f2,'YES');
                    Exit;
               end;
          end;
          if not ok then a:=luu;
     end;

     If Not p then
     Begin
          Writeln(f2,'NO');
          Exit;
     End
     else
     Begin
          Writeln(f2,'YES');
          Exit;
     End;
End;


Procedure Init;
Begin
     Assign(f2,fo);
     Rewrite(f2);
End;


Procedure Main;
Var
	f:text;
    kl,i,j:integer;
Begin
	Assign(f,fi);
    Reset(f);
    Readln(f,k);
    kl:=0;
    Repeat
          Inc(kl);

          Readln(f,n,m);

          For i:=1 to n do
          Begin
               readln(f,s);
               chuyen(s,i);
          End;

          For i:=1 to n do
          begin
               readln(f,s);
               Chuyenb(s,i);
          end;

          Xuly;
    Until kl=k;
    Close(f);
End;

Procedure Done;
Begin
     Close(F2);
End;

Procedure sinhtest;
Var
   i,j,m,n:integer;
   f:text;
begin
     Assign(f,fi);
     Rewrite(f);
     n:=2;
     m:=2;
     For i:=1 to n do
     begin
          for j:=1 to m do
              if random(10)>8 then write(f,'RED ') else write(f,'BLUE ');
          Writeln(f);
     end;

     For i:=1 to n do
     begin
          for j:=1 to m do
              if random(10)>8 then write(f,'RED ') else write(f,'BLUE ');
          Writeln(f);
     end;

     Close(f);
end;

BEGIN
     Clrscr;
{
 sinhtest;
 end.
}
     Init;
     Main;
     Done;
END.
3
3 4
RED RED BLUE RED
RED BLUE BLUE RED
BLUE BLUE BLUE BLUE
BLUE RED BLUE RED
RED RED BLUE BLUE
BLUE BLUE BLUE BLUE
2 2
BLUE BLUE
BLUE RED
RED RED
RED RED
2 2
BLUE RED
RED BLUE
BLUE BLUE
RED RED

