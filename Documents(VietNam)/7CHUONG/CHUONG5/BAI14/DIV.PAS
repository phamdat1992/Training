{ test 5 bi loi , chi co 3 cum dau la chay duoc }
{ chi co cac test : 1,2,3,4,5}

uses crt;
const
     fi='div4.in';
     fo='div.out';
var a             :array[1..10000]of longint;
    m,n,i,j,t     :longint;
    oclit         :longint ;
procedure oclit1(a,b:longint;var oclit:longint);
var m,n:longint;
begin
     if a mod b =0 then
     oclit:=b
     else
     begin
          m:=a;
          n:=b;
          while m<>n do
          begin
               if m>n then m:=m-n else n:=n-m;
          end;
     end;
     oclit:=m;
end;

procedure readfile;
var f,f1:text;
begin
     assign(f,fi);
     reset(f);
     assign(f1,fo);
     rewrite(f1);
     readln(f,n);
     for i:=1 to n do
     begin
          readln(f,m);
          fillchar(a,sizeof(a),0);
          for j:=1 to m do
               readln(f,a[j]);
          oclit1(a[1],a[2],oclit);
          t:=oclit;
          if m>=3 then
          for j:=3 to m do
          begin
               oclit1 ( a[ j ] ,a[2],oclit);
               t:=(T*oclit);
          end;
          T:=T MOD A[2];
          if t=0 then writeln(f1,'YES') else writeln(f1,'NO');
     end;

     close(f1);
     close(f);
end;

begin
     readfile;
end.
2
4
1
2
1
2
3
1
2
3

