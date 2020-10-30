{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}
uses crt;
const
     fi1='ngang.inp';
     fi2='doc.inp';
     fo='dem.out';
var a:array[1..180,1..179]of 0..1;
    b:array[1..179,1..180]of 0..1;
    n,i,j,t,dem:longint;
    time:longint;
    timesave:longint absolute 0:$46c;
procedure readfile;
var f:text;

begin
     time:=timesave;
     clrscr;
     assign(f,fi1);
     reset(f);
     n:=0;
     fillchar(a,sizeof(a),0);
     fillchar(b,sizeof(b),0);
     while not eof(f) do
     begin
          inc(n);
          j:=0;
          while not eoln(f) do
          begin
               inc(j);
               read(f,a[n,j]);
          end;
          readln(f);
     end;
     close(f);
     assign(f,fi2);
     reset(f);
     for i:=1 to n-1  do
     for j:=1 to n do
     read(f,b[i,j]);
     close(f);
     writeln(n);
end;
function bao(i,t,j:integer):boolean;
var  i1,t1:integer;
begin
     bao:=false;
     for t1:=t to j do
     begin
          if a[i,t1]=0 then exit;
          if a[i+j-t+1,t1]=0 then exit;
     end;
     for i1:=i to i+j-t  do
     begin
          if b[i1,t]=0 then exit;
          if b[i1,j+1]=0 then exit;
     end;
     bao:=true;
end;
function max(a,b:integer):integer;
begin
     if a>b then max:=a else max:=b;
end;

procedure init ;
begin
     dem:=0;
     for i:=1 to n-1 do
     for j:=1 to n-1 do
          for t:=max(1,i+j-n) to j do
               if bao(i,t,j) then inc(dem);
end;
procedure writefile;
var f:text;
begin
     assign(f,fo);
     rewrite(f);
     writeln(f,dem);
     close(f);
end;
begin
     readfile;
     init;
     writefile;
     writeln((timesave-time)/18.21);
end.

1 1 0
1 1 0
1 1 1
0 0 1

1 1 1 0
1 1 1 0
0 0 1 1

0 1 1 0 1
1 1 1 1 0
1 0 1 1 0
1 1 1 1 0
1 1 1 1 1
1 0 0 1 1

0 1 1 1 1 1
1 1 0 1 1 0
1 1 1 1 1 0
0 1 1 1 1 1
1 1 0 1 1 1

