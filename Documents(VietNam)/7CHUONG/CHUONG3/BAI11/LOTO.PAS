{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}

(* Chon k trong so n nguoi cao diem nhat
   (n <= 1000000)
   (k <= 2000)
*)

uses  crt;
const inp = 'LOTO.INP';
      out = 'LOTO.OUT';
      mn  = 2000;
type  str10 = string[10];
      arr1st10 = array [ 1..mn ] of str10;
      arr1lint = array [ 0..mn+1 ] of longint;
var   f : text;
      name : arr1st10;
      mark : arr1lint;
      ten : str10;
      n, k, i, j, cs, diem : integer;
      tbegin, time : longint;
      tnow : longint absolute 0:1132;

procedure open_file;
begin
  assign(f,inp);
  reset(f);
  readln(f,n,k);
end;

procedure init;
begin
  for i := 1 to k do
    begin
      readln(f,name[i]);
      readln(f,mark[i]);
    end;
  n := n-k;
  mark[0] := 0;
end;

procedure swap1(var x, y : longint);
var tg : longint;
begin
  tg := x;
  x := y;
  y := tg;
end;

procedure swap2(var x, y : str10);
var tg : str10;
begin
  tg := x;
  x := y;
  y := tg;
end;

procedure qsort(d, c : integer);
var gt : longint;
begin
  gt := mark[(d+c) div 2];
  i := d;
  j := c;
  repeat
    while mark[i] > gt do inc(i);
    while mark[j] < gt do dec(j);
    if i <= j
    then begin
           swap1(mark[i],mark[j]);
           swap2(name[i],name[j]);
           inc(i);
           dec(j);
         end;
  until i > j;
  if i < c then qsort(i,c);
  if j > d then qsort(d,j);
end;

procedure tim_nhi_phan(d, c : integer);
var giua : integer;
begin
  if (d = c) or (diem > mark[d]) or (diem < mark[c]) then exit;
  giua := (d+c) div 2;
  if (mark[giua] > diem) and (diem > mark[giua+1])
  then begin
         cs := giua+1;
         exit;
       end;

  if (mark[giua-1] > diem) and (diem > mark[giua])
  then begin
         cs := giua;
         exit;
       end;
  if diem > mark[giua]
  then tim_nhi_phan(d,giua)
  else if diem <= mark[giua]
       then tim_nhi_phan(giua,c);
  if cs > 0 then exit;
end;

procedure chen(cs : integer);
begin
  for j := k downto cs+1 do
    begin
      name[j] := name[j-1];
      mark[j] := mark[j-1];
    end;
  name[cs] := ten;
  mark[cs] := diem;
end;

procedure test;
begin
  qsort(1,k);
  i := 0;
  repeat
    inc(i);
    readln(f,ten);
    readln(f,diem);
    cs := 0;
    tim_nhi_phan(1,k);
    if cs > 0 then chen(cs);
  until i = n;
  close(f);
end;

procedure result;
begin
  assign(f,out);
    rewrite(f);
    for i := 1 to k do
      begin
        writeln(f,name[i]);
        writeln(f,mark[i]);
      end;
  close(f);
end;
(***********************************************)
procedure taotext;
var       f:text;
          st:string[5];
          i,j,j1,doi:longint;
          x:array[1..2000]of integer;
begin     n:=100;k:=10;
          assign(f,inp);
          rewrite(f);
          writeln(f,n,k:4);
          for i:=1 to n do
          x[i]:=i;
          for i:=1 to n do
          begin
               repeat
              j:=random(n);
              until j<>0;
              repeat
              j1:=random(n);
              until (j1<>0) and (j1<>j);
              doi:=x[j];
              x[j]:=x[j1];
              x[j1]:=doi;
          end;
          for i:=1 to n do
          begin


              for j:=1 to 5 do
              begin
              repeat
              doi:=random(94);
              until doi>64;
              write(f,chr(doi));
              end;
              writeln(f);
              writeln(f,x[i]);
          end;
end;
(***********************************************)
BEGIN
  taotext;
  tbegin := tnow;
  clrscr;
  open_file;
  init;
  test;
  result;
  time := tnow-tbegin;
  writeln('Time = ',time,' ',time/18.2 :5:2);
END.

6 3
A
9
B
7
C
12
D
8
E
5
F
11