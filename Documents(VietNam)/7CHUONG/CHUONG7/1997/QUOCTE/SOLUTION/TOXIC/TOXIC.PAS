{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65084,0,655360}
uses crt;
const
  x : array [1..6] of shortint = (-1,0,1,0,0,0);
  y : array [1..6] of shortint = (0,1,0,-1,0,0);
  z : array [1..6] of shortint = (0,0,0,0,1,-1);
var
  l , h , w : byte;
  a : array [-1..34,-1..34,-1..34] of byte;
  time , tong , tongc : longint;
procedure init;
  begin
    write(' l : ');readln(l);
    write(' w : ');readln(w);
    write(' h : ');readln(h);
    fillchar(a,sizeof(a),0);
  end;

procedure anthem;
  begin

  end;

procedure hr;
  var
    i , j , k : byte;
  begin
    for i := 1 to l do
      for j := 1 to w do
        for k := 1 to h do
          a[i,j,k] := 1;
  end;

function cothe(i,j,k : byte):boolean;
  var
    p : byte;
  begin
    for p := 1 to 6 do
      if a[i+x[p],j+y[p],k+z[p]] = 3 then
        begin
          cothe := false;
          exit;
        end;
    cothe := true;
  end;

procedure toxic(i,j,k : byte);
  var
    p : byte;
  begin
    for p := 1 to 6 do
      if (a[i+x[p],j+y[p],k+z[p]] <> 3)
        and (i+x[p] <= l)and(i+x[p] > 0)
        and (j+y[p] <= w)and(j+y[p] > 0)
        and (k+z[p] <= h)and(k+z[p] > 0) then a[i+x[p],j+y[p],k+z[p]] := 2;
  end;

procedure try(i,j,k:byte);
  var
    p : byte;
  begin
    inc(tong);
    for p := 1 to 6 do
      begin
        if (a[i+x[p],j+y[p],k+z[p]] > 0) and (a[i+x[p],j+y[p],k+z[p]] < 3)
        and (i+x[p] <= l)and(i+x[p] > 0)
        and (j+y[p] <= w)and(j+y[p] > 0)
        and (k+z[p] <= h)and(k+z[p] > 0)then
          begin
            if cothe(i+x[p],j+y[p],k+z[p]) then
              begin
                toxic(i,j,k);
                a[i,j,k] := 3;
                try(i+x[p],j+y[p],k+z[p]);
              end
            else
              begin
                a[i+x[p],j+y[p],k+z[p]] := 0;
                if tong > tongc then
                  tongc := tong
                else
                  dec(tong);
              end;
          end;
      end;
  end;

BEGIN
  clrscr;
  tong := 0;
  tongc := 0;
  init;
  time := meml[0:$46c];
  hr;
  try(1,1,1);
  if tong > tongc then tongc := tong;
  writeln(tongc);
  writeln(meml[0:$46c] - time);
END.