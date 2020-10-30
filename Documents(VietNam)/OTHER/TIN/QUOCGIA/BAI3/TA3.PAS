{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65000,0,655360}
program Dem_so;
const fi='Count.inp';
      fo='Count.ta';
      nmax=16001;
type  data1=array[1..nmax]of byte;
var   n:integer;
      lm,m:integer;
      d:data1;
      f,g:text;
      i,j,k,t:integer;
procedure Mo_file;
begin
     assign(f,fi);
     reset(f);
     readln(f,n);
     assign(g,fo);
     rewrite(g);
end;
procedure init;
begin
     fillchar(d,sizeof(d),0);
     d[n+1]:=2;
     m:=n+1;
     k:=0;
end;
procedure ql(k:byte;i,t:integer);
var tam:byte;
begin
     tam:=2-k;
     for j:=i to i+t-1 do d[j]:=tam;
end;
procedure ktra;
var tam,lj:integer;
begin
     lm:=m;
     m:=0;
     j:=1;
     repeat
           while d[j]=1 do inc(j);
           lj:=j;
           while d[j]=0 do inc(j);
           tam:=j-lj;
           if tam>m then
              begin
              m:=tam;
              if m>lm then exit;
              end;
     until j>n;
end;
procedure xuli;
var lk:byte;
begin
     while not eof(f) do
           begin
           lk:=k;
           read(f,k);
           if k=3 then
              begin
              if lk<>3 then ktra;
              writeln(g,m);
              end
              else
                  begin
                  read(f,i,t);
                  ql(k,i,t);
                  end;
           end;
end;
procedure dong_file;
begin
     close(f);
     close(g);
end;
begin
     mo_file;
     init;
     xuli;
     dong_file;
end.