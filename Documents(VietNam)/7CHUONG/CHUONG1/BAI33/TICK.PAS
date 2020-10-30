{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}
(*  Le Van Hung K28 A2 Phan Boi Chau *)
Program Hoa_Tra_My ;
uses crt;
const
     fi='tick.in0';
     fo='tick.out';
var
   r,t:array[1..2000]of integer;
   maxd:array[0..2000]of longint;
   luu:array[1..2000]of boolean;
   n,i,j,k,k1:integer;
   ok:boolean;
procedure readfile;
var f:text;
begin
     assign(f,fi);
     reset(f);
     readln(f,n);
     for i:=1 to n do
     read(f,t[i]);
     readln(f);
     for i:=1 to n -1 do
     read(f,r[i]);
     close(f);
end;
procedure init ;
begin
     fillchar(maxd,sizeof(maxd),0);
     maxd[1]:=t[1];
     for i:=2 to n do
     begin
          if maxd[i-1]+t[i]<maxd[i-2]+r[i-1] then
          begin
               maxd[i]:=maxd[i-1]+t[i];
          end
          else
          begin
               maxd[i]:=maxd[i-2]+r[i-1];
          end;
     end;
end;
procedure writefile;
var f:text;
begin
     assign(f,fo);
     rewrite(f);
     writeln(f,maxd[n]);
     i:=n;
     fillchar(luu,sizeof(luu),true);
     while i<>0 do
     begin
          if (maxd[i]=maxd[i-2]+r[i-1]) then
          begin
               luu[i]:=false;
               i:=i-2;
          end
          else
              i:=i-1;
     end;
     for i:=1 to n do
     if not luu[i] then
     write(f,i,' ');
     close(f);
end;

begin
     readfile;
     init;
     writefile;
end.

5
2 5 7 8 4
4 9 10 10


18
2 4
