{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}

(* Chia Kim cuong, Rubi *)

uses  crt;
const inp = 'GEMS.INP';
      out = 'GEMS.OUT';
      mn  = 100;
type  arr1inte1 = array [ 1..mn ] of integer;
      arr1inte2 = array [ 1..21000 ] of integer;
      arr1sint1 = array [ 1..mn ] of shortint;
      arr1sint2 = array [ 1..21000 ] of shortint;
      arr1char  = array [ 1..mn ] of char;
var   f : text;
      cs, loai : arr1sint1;
      A, B: arr1sint2;
      gia : arr1inte1;
      bd  : ^arr1inte2;
      res : arr1char;
      tong1, tong2, n, i, j, sR, chenh, c1, nua1, nua2,
      new1, new2, so1, so2, iC, jC : integer;
      tbegin, time : longint;
      tnow : longint absolute 0:1132;

procedure input;
begin
  new(bd);
  sR := 0;
  assign(f,inp);
    reset(f);
    readln(f,n);
    for i := 1 to n do
      begin
        readln(f,gia[i],loai[i]);
        if loai[i] = 0 then inc(sR);
      end;
  close(f);
end;

procedure init;
begin
  chenh := maxint;
  for i := 1 to n do
    begin
      cs[i] := i;
      res[i] := ' ';
    end;
end;

function  tim1(i : integer) : integer;
var d1 : integer;
begin
  for d1 := 1 to n do
    if loai[d1] = 1
    then begin
           tim1 := d1;
           exit;
         end;
  tim1 := 0;
end;

procedure swapS(var x, y : shortint);
var tg : shortint;
begin
  tg := x;
  x := y;
  y := tg;
end;

procedure swapI(var x, y : integer);
var tg : integer;
begin
  tg := x;
  x := y;
  y := tg;
end;

procedure theo_loai;
begin
  for i := 1 to n do
    if loai[i] = 0
    then begin
           j := tim1(i);
           if j = 0 then exit;
           swapS(cs[i],cs[j]);
           swapS(loai[i],loai[j]);
           swapI(gia[i],gia[j]);
         end;
end;

procedure qsort(d, c : integer);
var gt : integer;
begin
  gt := gia[(d+c) div 2];
  i := d;
  j := c;
  repeat
    while gia[i] < gt do inc(i);
    while gia[j] > gt do dec(j);
    if i <= j
    then begin
           swapS(cs[i],cs[j]);
           swapS(loai[i],loai[j]);
           swapI(gia[i],gia[j]);
           inc(i);
           dec(j);
         end;
  until i > j;
  if i < c then qsort(i,c);
  if j > d then qsort(d,j);
end;

procedure theo_gia;
begin
  if sR > 0 then qsort(1,sR);
  if sR+1 < n then qsort(sR+1,n);
end;

procedure sort;
begin
  theo_loai;
  theo_gia;
end;

procedure init_1;
begin
  tong1 := 0;
  fillchar(A, sizeof(A), 0);
  for i := 1 to sR do
    begin
      A[gia[i]] := i;
      tong1 := tong1 + gia[i];
      bd^[gia[i]] := gia[1];
    end;
end;

function  khongtrung1(i, j : integer) : boolean;
var d1 : integer;
begin
  d1 := j;
  repeat
    j := d1;
    repeat
      if A[i] = A[j]
      then begin
             khongtrung1 := false;
             exit;
           end;
      dec(j,gia[A[j]]);
    until j = 0;
    dec(i,gia[A[i]]);
  until i = 0;
  khongtrung1 := true;
end;

function  sotrc1(vt : integer) : integer;
var d1 : integer;
begin
  d1 := 0;
  repeat
    inc(d1);
    vt := vt - gia[A[vt]];
  until vt = 0;
  sotrc1 := d1;
end;

procedure chia1;
begin
  init_1;
  i := gia[1]-1;
  repeat
    inc(i);
    if i >= tong1 then exit;
    if A[i] > 0 then
      for j := bd^[i] to i-1 do
        if (A[j] > 0) and khongtrung1(i,j)
        then begin
               new1 := i+j;
               if A[new1] = 0
               then begin
                      A[new1] := A[j];
                      bd^[new1] := i+1;
                    end
               else begin
                      so1 := sotrc1(new1);
                      so2 := sotrc1(i);
                      if so2+1 > so1
                      then begin
                             A[new1] := A[j];
                             bd^[new1] := i+1;
                           end;
                    end;
               if new1 >= tong1 then exit;
             end;
  until false;
end;

procedure init_2;
begin
  tong2 := 0;
  fillchar(B, sizeof(B), 0);
  for i := sR+1 to n do
    begin
      B[gia[i]] := i;
      tong2 := tong2 + gia[i];
      bd^[gia[i]] := gia[sR+1];
    end;
end;

function  khongtrung2(i, j : integer) : boolean;
var d1 : integer;
begin
  d1 := j;
  repeat
    j := d1;
    repeat
      if B[i] = B[j]
      then begin
             khongtrung2 := false;
             exit;
           end;
      dec(j,gia[B[j]]);
    until j = 0;
    dec(i,gia[B[i]]);
  until i = 0;
  khongtrung2 := true;
end;

function  sotrc2(vt : integer) : integer;
var d1 : integer;
begin
  d1 := 0;
  repeat
    inc(d1);
    vt := vt - gia[B[vt]];
  until vt = 0;
  sotrc2 := d1;
end;

procedure chia2;
begin
  init_2;
  i := gia[sR+1]-1;
  repeat
    inc(i);
    if i >= tong2 then exit;
    if B[i] > 0 then
      for j := bd^[i] to i-1 do
        if (B[j] > 0) and khongtrung2(i,j)
        then begin
               new2 := i+j;
               if B[new2] = 0
               then begin
                      B[new2] := B[j];
                      bd^[new2] := i+1;
                    end
               else begin
                      so1 := sotrc2(new2);
                      so2 := sotrc2(i);
                      if so2+1 > so1
                      then begin
                             B[new2] := B[j];
                             bd^[new2] := i+1;
                           end;
                    end;
               if new2 >= tong2 then exit;
             end;
  until false;
end;

function  max(x, y : integer) : integer;
begin
  if x > y then max := x else max := y;
end;

procedure kt_soluong;
begin
  if sR > 0 then
    for i := new1 downto gia[1] do
      if A[i] > 0
      then begin
             so1 := sotrc1(i);
             if 2*so1 < sR then A[i] := -A[i];
           end;
  {-----------}
  if sR < n then
    for i := new2 downto gia[sR+1] do
      if B[i] > 0
      then begin
             so2 := sotrc2(i);
             if 2*so2 < n-sR then B[i] := -B[i];
           end;
end;

procedure chia_Rubi;
begin
  nua1 := tong1 div 2;
  for i := nua1 downto 1 do
    if A[i] > 0
    then begin
           nua1 := i;
           break;
         end;
  chenh := abs(tong1-2*nua1);
  repeat
    res[cs[abs(A[nua1])]] := 'P';
    nua1 := nua1 - gia[abs(A[nua1])];
  until nua1 = 0;
  for i := 1 to n do
    if res[cs[i]] = ' ' then res[cs[i]] := 'Q';
end;

procedure chia_KC;
begin
  nua2 := tong2 div 2;
  for i := nua2 downto 1 do
    if B[i] > 0
    then begin
           nua2 := i;
           break;
         end;
  chenh := abs(tong2-2*nua2);
  repeat
    res[cs[abs(B[nua2])]] := 'Q';
    nua2 := nua2 - gia[abs(B[nua2])];
  until nua2 = 0;
  for i := 1 to n do
    if res[cs[i]] = ' ' then res[cs[i]] := 'P';
end;

procedure chia_ca2;
begin
  for i := gia[1] to new1 do
    for j := gia[sR+1] to new2 do
      if (A[i] > 0) and (B[j] > 0)
      then begin
             c1 := abs(tong2-tong1 +2*i -2*j);
             if chenh > c1
             then begin
                    chenh := c1;
                    iC := i;
                    jC := j;
                  end;
           end;
end;

procedure make_res;
begin
  repeat { Rubi }
    res[cs[abs(A[iC])]] := 'P';
    iC := iC - gia[abs(A[iC])];
  until iC = 0;

  repeat
    res[cs[abs(B[jC])]] := 'Q';
    jC := jC - gia[abs(B[jC])];
  until jC = 0;

  for i := 1 to sR do
    if res[cs[i]] = ' ' then res[cs[i]] := 'Q';
  for i := sR+1 to n do
    if res[cs[i]] = ' ' then res[cs[i]] := 'P';
end;

procedure xet;
begin
  if tong2 = 0
  then begin
         chia_Rubi;
         exit;
       end;
  if tong1 = 0
  then begin
         chia_KC;
         exit;
       end;
  chia_ca2;
  make_res;
end;

procedure test;
begin
  sort;
  if sR > 0
  then begin
         chia1;
         new1 := max(new1,i);
       end;
  if sR+1 < n
  then begin
         chia2;
         new2 := max(new2,i);
       end;
  kt_soluong;
  xet;
end;

procedure result;
begin
  assign(f,out);
    rewrite(f);
    writeln(f,chenh);
    for i := 1 to n do writeln(f,res[i]);
  close(f);
end;

BEGIN
  tbegin := tnow;
  clrscr;
  input;
  init;
  test;
  result;
  dispose(bd);
  time := tnow - tbegin;
  writeln('Time = ',time,' ',time/18.2 :5:2);
END.

5
13 1
25 1
20 1
15 0
12 0

4
2 0
3 0
4 0
5 0

4
2 1
3 1
4 1
5 1

5
2 1
4 1
5 1
20 1
70 1