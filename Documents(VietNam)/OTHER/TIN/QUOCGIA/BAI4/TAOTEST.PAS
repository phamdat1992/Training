{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program tao_test_bai_4;
 const
      fi                =               'shoes.in';
      nmax              =               100;
 var
      f                 :               text;
      ch                :               char;
      m, n, i           :               integer;
 begin
      write('Test: ');readln(ch);
      write('M:= ');readln(m);
      write('N:= ');readln(n);
      assign(f,fi+ch);
      rewrite(f);
      writeln(f,m,' ',n);
      for i:=1 to m do
          write(f,random(1000)+1,' ');
      writeln(f);
      for i:=1 to n do
          write(f,random(1000)+1,' ');
      close(f);
 end.