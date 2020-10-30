{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}

(* Dem so cac fan mat fang tao thanh khi ve cac duong thang trong 1 hinh vuong *)

uses  crt;
const inp = 'PART.INP';
      out = 'PART.OUT';
      mn  = 100;
type  arr1real = array [ 1..mn*(mn-1) div 2 ] of real;
      arr1lint = array [ 1..mn ] of longint;
var   f : text;
      X, Y : arr1real;
      A1, B1, A2, B2, A, B, C : arr1lint;
      n, i, j, Sfan, sgd : longint;
      D, Dx, Dy, x1, y1 : real;

procedure input;
begin
  assign(f,inp);
    reset(f);
    readln(f,n);
    for i := 1 to n do readln(f,A1[i],B1[i],A2[i],B2[i]);
  close(f);
end;

procedure init;
begin
  if n > 0 then Sfan := 2
           else Sfan := 1;
end;

procedure lap_PT;
begin
  for i := 1 to n do
    begin
      A[i] := B2[i]-B1[i];
      B[i] := A1[i]-A2[i];
      C[i] := -A1[i]*B2[i] + A2[i]*B1[i];
    end;
end;

function  ben_trong(s1, s2 : real) : boolean;
begin
  ben_trong := not ((s1 = 0) or (s1 = 1000) or (s2 = 0) or (s2 = 1000));
end;

function  cxet(s1, s2 : real) : boolean;
var d1 : integer;
begin
  for d1 := 1 to sgd do
    if (X[d1] = s1) and (Y[d1] = s2)
    then begin
           cxet := false;
           exit;
         end;
  cxet := true;
end;

procedure tinh_so_gd(i : integer);
begin
  sgd := 0;
  for j := 1 to i-1 do
    begin
      D :=  A[i]*B[j] - A[j]*B[i];
      Dx := B[i]*C[j] - C[i]*B[j];
      Dy := -A[i]*C[j]+ A[j]*C[i];
      if (D <> 0) and ben_trong(Dx/D,Dy/D) and cxet(Dx/D,Dy/D)
      then begin
             inc(sgd);
             X[sgd] := Dx/D;
             Y[sgd] := Dy/D;
           end;
    end;
end;

procedure xet_gd;
begin
  for i := 2 to n do
    begin
      tinh_so_gd(i);
      Sfan := Sfan + sgd + 1;
    end;
end;

procedure test;
begin
  lap_PT;
  xet_gd;
end;

procedure result;
begin
  assign(f,out);
    rewrite(f);
    writeln(f,Sfan);
  close(f);
end;

BEGIN
  clrscr;
  input;
  init;
  test;
  result;
END.

3
0 0 1000 1000
500 0 500 1000
0 500 1000 500