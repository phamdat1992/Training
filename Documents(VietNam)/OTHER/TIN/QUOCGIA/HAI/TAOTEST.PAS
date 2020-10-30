{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
var
    f                   :               text;
    d, i                :               longint;
begin
     assign(f,'count.inp');
     rewrite(f);
     writeln(f,'16000');
     write('Dong: ');
     readln(d);
     for i:=1 to d do
         writeln(f,'3');
end.