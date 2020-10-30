{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}
uses crt;
const
     fi='light.inp';
     fo='light.out';
var
   c:array[1..100,1..100]of 0..1;
   f1:array[0..100,0..100]of integer;
   a,b:array[0..100]of integer;
   m,k,n,i,j:integer;
   f:text;
procedure readfile;
var f:text;i,j,x,y:integer;
begin
     assign(f,fi);
     reset(f);
     fillchar(a,sizeof(a),0);
     b:=a;

     readln(f,m,n,k);
     for i:=1 to m do
     read(f,a[i]);
     readln(f);
     for i:=1 to n do
     read(f,b[i]);
     readln(f);
     fillchar(c,sizeof(c),0);
     for i:=1 to k do
     begin
          readln(f,x,y);
          c[x,y]:=1;
     end;
     close(f);

end;
function min(a,b:integer):integer;
begin
     if a>b then min:=b else min:=a;
end;
function kt1(i,j:integer):boolean;
var t:integer;
begin
     kt1:=true;
     for t:=1 to j do
     if c[i,t] >0 then exit;
     kt1:=false;

end;
function kt2(i,j:integer):boolean;
var t:integer;
begin
     kt2:=true;
     for t:=1 to i do
     if c[t,j]>0 then exit;
     kt2:=false;
end;
procedure init ;
begin
     fillchar(f1,sizeof(f1),0);
     for i:=1 to m do
     for j:=1 to n do
     begin
          if c[i,j]=0 then
          begin
               if (not kt1(i,j))and(not kt2(i,j)) then
                    f1[i,j]:=f1[i-1,j-1];

               if (not kt1(i,j))and(kt2(i,j)) then f1[i,j]:=f1[i-1,j];
               if kt1(i,j) and(not kt2(i,j))  then f1[i,j]:=f1[i,j-1];
               if kt1(i,j)and(kt2(i,j)) then f1[i,j]:=min(f1[i,j-1]+b[j],f1[i-1,j]+a[i]);
          end;
          if c[i,j]=1  then
          begin
               if (not kt1(i,j))and(not kt2(i,j))then f1[i,j]:=f1[i-1,j-1]+min(a[i],b[j])
               else
               f1[i,j]:=min(f1[i-1,j]+a[i],f1[i,j-1]+b[j]);
          end;
     end;
end;
procedure done;
var t,t1:integer;
    thu1,thu2:array[1..100]of boolean;
    f:text;
begin
     i:=m;
     j:=n;
     fillchar(thu2,sizeof(thu2),true);
     thu1:=thu2;
     while ((i<>0)or(j<>0))or(f1[i,j]<>0)do
     begin
          if f1[i,j]=0 then break;
          if c[i,j]=0 then
          begin
               if f1[i,j]=f1[i,j-1]+b[j] then
               begin
                    thu2[j]:=false;
                    dec(j);
               end
               else
               if f1[i,j]=f1[i-1,j] +a[i] then
               begin
                    thu1[i]:=false;
                    dec(i);
               end
               else
               if f1[i,j]=f1[i-1,j-1]+a[i] then
               begin
                    thu1[i]:=false;
                    dec(i);
                    dec(j);
               end
               else
               if f1[i,j]=f1[i-1,j-1]+b[j] then
               begin
                    thu2[j]:=false;
                    dec(i);
                    dec(j);
               end;
          end
          else
          begin
               if f1[i,j]=f1[i-1,j]+a[i] then
               begin
                    thu1[i]:=false;
                    dec(i);
               end
               else
               if f1[i,j]=f1[i,j-1] +b[j] then
               begin
                    thu2[j]:=false;
                    dec(j);
               end

          end;


     end;
     t1:=0;
     t:=0;
     for i:=1 to m do
     if not thu1[i] then inc(t1);
     for j:=1 to n do
     if not thu2[j] then inc(t);
     assign(f,fo);
     rewrite(f);
     writeln(f,f1[m,n]);
     writeln(f,t1,' ',t);
     for i:=1 to m do
     if not thu1[i] then writeln(f,i,' ');
     for i:=1 to  n do
     if not thu2[i] then writeln(f,i);
     close(f);
end;
begin
     readfile;
     init;
     done;
end.
2 3 4
10 5
12 4 2
1 2
1 3
2 1
2 3


2 3 4
15 17
2 4 6
1 1
2 2
2 3
2 1
