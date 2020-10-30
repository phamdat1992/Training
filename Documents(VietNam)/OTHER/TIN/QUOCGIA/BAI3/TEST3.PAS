{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
var
    f                   :               text;
    d, i                :               longint;
    ch                  :               char;
    p                   :               integer;
begin
     write('Test: ');
     readln(ch);
     assign(f,'count.in'+ch);
     rewrite(f);
     writeln(f,'16000');
     write('Dong: ');
     readln(d);
     for i:=1 to d do
         if (i mod 100)=0 then
            writeln(f,'3')
         else
             begin
                  p:=random(16000)+1;
                  writeln(f,random(2)+1,' ',p,' ',random(16000-p));
             end;
     close(f);
end.