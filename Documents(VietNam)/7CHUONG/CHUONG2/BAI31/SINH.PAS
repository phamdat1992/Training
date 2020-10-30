{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
uses crt;
const fi='sn.in9';
      m=100;
      n=100;
      max=maxint;
var   i,j:integer;
      f:text;
begin
   randomize;
   assign(f,fi); rewrite(f);
   writeln(f,m,' ',n);
   for i:=1 to m do
   begin
      for j:=1 to n do
      begin
         if random(10)<4 then write(f,-1,'':4)
          else write(f,random(max),'':5);
      end;
      writeln(f);
   end;
   close(f);
end.