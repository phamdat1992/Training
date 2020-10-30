Uses crt;
const
  fi='mavach.inp';
  fo='maVach.out';
  maxN = 40;
  N = 33 ;
  M = 14;
  K = 20;
  SL = 99;
type
  Mavach = array[1..maxN]of byte;
var
  c : array[0..maxN , 0..MaxN ]of extended;
  a : MaVach;
  tt : extended;

procedure Sinh(var a : MaVach);
var
  i,j , kk , mm : integer;
begin
  fillchar(a,sizeof(a),0);
  j := 1;
  a[1] := j;
  mm := 1 ;
  kk := 1;
  for i:=2 to N do
    begin
      if (kk = K) or (N-i  < M - mm) then j := 1-j else
      if (N-i+1 > (M-mm)*K ) then         j := j else
                                          j := random(2);
      a[i] := j;
      if j<> a[i-1] then
        begin
          inc(mm);
          kk := 1;
        end else inc(kk);
    end;
end;

procedure VietTest;
var
  f : text;
  i , j : integer;
begin
  randomize;
  assign(f,fi);
  rewrite(f);
  writeln(f , N , ' ' , M , ' ' , K);
  for i:=1 to SL do
    begin
      Sinh(a);
      write(f , '1   ');
      for j:=1 to N do
        write(f , a[j] );
      writeln(f);
    end;
  close(f);
end;

begin
  vietTest;
end.