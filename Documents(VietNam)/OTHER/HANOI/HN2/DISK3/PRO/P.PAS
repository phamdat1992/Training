Program Pro;
Uses crt;
Const
     Fi='pro.src';
     Fo='pro.tag';
     maxn=100;
Type
    mang = array[1..maxn] of integer;
Var
   Stackwhile,stackif:mang;
   cuoiwhile,cuoiif:integer;

   i,j,m,n:integer;
   cuoi:integer;
   time:longint absolute 00:$46c;
   timesaved : longint;
   f1,f2:text;
   s:string;
   lenhif:integer;
   lenhwhile:integer;
   lenhbegin:integer;
   lif:integer;

Procedure xulywhile(tam:string);forward;
Procedure xulyif(tam:string);forward;

Procedure init;
begin
     Assign(f1,fi);
     reset(f1);
     Assign(f2,fo);
     Rewrite(f2);
     lenhif:=0;
     lenhwhile:=0;
     lenhbegin:=0;

     cuoiwhile:=1;
     cuoiif:=1;
end;

Function luocbo(tam:string):string;
Var
   i,j:integer;
   s:string;
Begin
     For i:=1 to length(tam) do tam[i]:=upcase(tam[i]);
     s:=tam;

     Repeat
           j:=pos('  ',s);
           Delete(s,j,1);
     Until j=0;

     If s[1]=' ' then delete(s,1,1);

     luocbo:=s;
End;

Procedure xulybeginIF(lenh:integer);
var
   s:string;
Begin
{     Write(f2,'IF',lenh,': ');}

     While s<>'END' do
     Begin
          readln(f1,s);
          s:=luocbo(s);

          j:=pos(';',s);
          If j<>0 then delete(s,j,1);

          j:=pos('WHILE',s);
          If j<>0 then xulywhile(s)
          else
          begin
               j:=pos('IF',s);
               If j<>0 then xulyif(s)
               Else
               Begin
                    j:=pos('END',s);
                    IF j<>0 then exit;
                    Writeln(f2,'# ',s);
               End;
          end;
     End;
End;

Procedure xulybeginIFELSE(lenh:integer);
var
   s:string;
Begin
     Writeln(f2,'LI',stackif[cuoiif],': ');
     dec(cuoiif);

     While s<>'END' do
     Begin
          readln(f1,s);
          s:=luocbo(s);

          j:=pos(';',s);
          If j<>0 then delete(s,j,1);

          j:=pos('WHILE',s);
          If j<>0 then
               xulywhile(s)
          else
          begin
               j:=pos('IF',s);
               If j<>0 then xulyif(s)
               Else
               Begin
                    j:=pos('END',s);
                    IF j<>0 then exit
                    else Writeln(f2,'# ',s);
               End;
          end;
     End;
End;


Procedure xulyif(tam:string);
Var
   s,bt:string;
   i,j:integer;
Begin
     writeln(tam);
     j:=4;
     s:=tam;

     while s[j]<>' ' do inc(j);

     If j<>4 then j:=j-1;

     bt:=copy(s,4,j-4+1);

     inc(lenhif);

     inc(cuoiif);
     stackif[cuoiif]:=lenhif;


     Writeln(f2,'? ',bt,' LI',lenhif);

     Readln(f1,s);
     s:=luocbo(s);

     If s='BEGIN' then xulybeginif(lenhif) else
     begin
          j:=pos('WHILE',s);
          If j<>0 then
               xulywhile(s)
          else
          begin
               j:=pos('IF',s);
               If j<>0 then xulyif(s)
               Else
               writeln(f2,'# ',s);
          end;
     end;

     Readln(f1,s);
     s:=luocbo(s);

     If pos('ELSE',s)<>0 then
     begin
          Readln(f1,s);
          s:=luocbo(s);
          If pos('BEGIN',s)<>0 then xulybeginifelse(lenhif)
          else
              if pos('IF',s)<>0 then
              begin
                   if cuoiif>1 then
                   begin
                        Writeln(f2,'LI',stackif[cuoiif],': ');
                        dec(cuoiif);
                        xulyif(s)
                   end;
              end
              else
                  if pos('WHILE',s)<>0 then xulywhile(s)
                  else
                  begin
                        writeln(f2,'LI',stackif[cuoiif],': ',s);
                        dec(cuoiif);
                  end;
     end
     else
     begin
          If pos('BEGIN',s)<>0 then xulybeginifelse(lenhif)
             else
          begin
             writeln(f2,'LI',stackif[cuoiif],': ');
             dec(cuoiif);
          end;

          If (pos('WHILE',s)<>0) then xulywhile(s)
          else
             if (pos('IF',s)<>0) then xulyif(s)
     end;
end;

Procedure xulybeginwhile(lenh:integer);
var
   s:string;
Begin
{     Write(f2,'HW',lenh,': ');}

     While s<>'END' do
     Begin
          readln(f1,s);
          s:=luocbo(s);

          j:=pos(';',s);
          If j<>0 then delete(s,j,1);

          j:=pos('WHILE',s);
          If j<>0 then xulywhile(s)
          else
          begin
               j:=pos('IF',s);
               If j<>0 then xulyif(s)
               Else
               Begin
                    j:=pos('END',s);
                    IF j<>0 then
                    Begin
                         Writeln(f2,'> HW',lenhwhile);
                         exit;
                    End
                    else Writeln(f2,'# ',s);
               End;
          end;
     End;
End;


Procedure xulywhile(tam:string);
Var
   s,bt:string;
   i,j:integer;
Begin
     writeln(tam);
     j:=7;
     s:=tam;

     while s[j]<>' ' do inc(j);

     If j<>7 then j:=j-1;

     bt:=copy(s,7,j-7+1);

     inc(lenhwhile);

     inc(cuoiwhile);
     stackwhile[cuoiwhile]:=lenhwhile;


     Writeln(f2,'HW',lenhwhile,': ? ',bt,' WH',lenhwhile);

	 Readln(f1,s);
     s:=luocbo(s);

     If s='BEGIN' then
     begin
          xulybeginwhile(lenhwhile)
     end
     else
     Begin
{     End
     else
     Begin}

{     Writeln(f2,'WH',lenhwhile,': ');

          Readln(f1,s);
          s:=luocbo(s);}

          If pos('IF',s)<>0 then
          begin
               xulyif(s);
               exit;
          end;

          If pos('WHILE',s)<>0 then
          begin
               xulywhile(s);
               exit;
          end;
          If pos('END',s)=0 then
          begin
               writeln(f2,'# ',s);
{              writeln(f2,'# ',s);}
               Writeln(f2,'> HW',lenhwhile);

               Writeln(f2,'WH',stackwhile[cuoiwhile],': ');
               dec(cuoiwhile);
          end;
     end;
End;

Function xuly(tam:string):boolean;
Var
   i,j,m,n:integer;
   s:string;
   Lenh:string;
Begin
     xuly:=False;
     For i:=1 to length(tam) do tam[i]:=upcase(tam[i]);
     s:=tam;

     Repeat
           j:=pos('  ',s);
           Delete(s,j,1);
     Until j=0;

     j:=1;
     while s[j]=' ' do inc(j);
     If j<>1 then j:=j-1;
     If s[1]=' ' then Delete(s,1,j);
     Lenh:='';

     j:=1;
     While s[j]<>' ' do inc(j);
     If j<>1 then j:=j-1;

     lenh:=copy(s,1,j);

{     Writeln(lenh);}
     tam:=s;

     if lenh='WHILE' then
     Begin
          xuly:=true;
          xulywhile(tam);
     End;

     if lenh='IF' then
     Begin
          Xuly:=True;
          xulyif(tam);
     End;

     Xuly:=false;
End;

Procedure Main;
Var
   s:string;
Begin
     While not eof(f1) do
     begin
          Readln(f1,s);
          s:=luocbo(s);
          if (not Xuly(s)) and (pos('END',s)=0)
             and(pos('WHILE',s)=0)
             and(pos('IF',s)=0)
             and(pos('BEGIN',s)=0) then
             begin
             j:=pos(';',s);
             delete(s,j,1);
			 writeln(f2,'# ', s);
             end;
     end;
End;

Procedure Done;
Begin
     while cuoiif>1 do
     begin
          writeln(f2,'LI',stackif[cuoiif],':');
          dec(cuoiif);
     end;

     while cuoiwhile>1 do
     begin
          writeln(f2,'WH',stackwhile[cuoiwhile],':');
          dec(cuoiwhile);
     end;

     close(f1);
     close(f2);
End;

BEGIN
     Clrscr;
     Timesaved:=time;
     Init;
     Main;
     Done;
     Writeln;
     Writeln('Time run: ',(time-timesaved)/18.21:10:7);
END.

BEGIn
     while s do
     l
end

BEGIN
     while s do
     begin
          a;
          bz;
          if r then
          x;
          else
          y;
     end
     p;
     q;
END

Begin
     if r then
     l
     while m do
     begin
          bz;
          y;
     end
     if o then
     k
     else
     m
     oi
     ou
end