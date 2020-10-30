uses crt;
const fi='XDTV.INP';
      fo='XDTV.OUT';
var  n,n1,d1,d2,luu1,luu2,dtmax,n2:longint;
     x,d,t,v,bc1,bc2:INTEGER;
     f:text;
     t1:longint absolute  0:$46c;
     t2:longint;

procedure  doc_tep_du_lieu;
begin
  assign(f,fi);
  reset(F);
  readln(f,n,x,d,t,v);
  close(f);
end;

function  ucln(i,j:byte):INTEGER;
var  m,mn:INTEGER;
begin
   m:=i;mn:=j;
   while m<>mn do
    begin
     if m>mn then m:=m-mn
     else mn:=mn-m;
    end;
   ucln:=m;
end;

procedure  khoitao;
begin
   t2:=t1;
   bc1:=x*t div ucln(x,t);
   bc2:=d*v DIV UCLN(D,V);
   n1:=bc1 div x;
   d1:=bc1 div x+bc1 div t;
   n2:=bc2 div d;
   d2:=bc2 div d+bc2 div v;
   luu1:=1;luu2:=1;dtmax:=0;
end;

procedure  xuli;
var s,k1,k2:longint;
begin
  for k1:=1 to n div d1 do
   if n>=d1*k1+d2 then
     begin
        k2:=(n-d1*k1) div d2;
        s:=k1*bc1*k2*bc2;
        if s>dtmax then
         begin
           dtmax:=s;
           luu1:=k1;luu2:=k2;
         end;
     end;
end;

procedure  xuat;
begin
  assign(f,fo);
  rewrite(f);
  writeln(f,dtmax);
  writeln(f,n1*luu1,'  ',n2*luu2,'  ',luu1*(d1-n1),'  ',luu2*(d2-n2));
  close(f);
end;

begin  clrscr;
  doc_tep_du_lieu;
  khoitao;
  xuli;
  xuat;
end.

50000 13 25 26 17
2147347848
14332  11526  7166  16950

2000 5 1 3 7
1640625
375  875  625  125

5000 5 1 3 7
10253880
936  2191  1560  313

32000 20 20 20 20
2147258112
2860  13140  2860  13140


50000 20 20 20 20
2147440640
5904  19096  5904  19096

10 1 2 3 4
24
3  4  1  2










