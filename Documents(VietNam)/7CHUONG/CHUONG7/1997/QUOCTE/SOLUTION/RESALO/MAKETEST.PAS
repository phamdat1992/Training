type
  nh = record
           n , k : byte;
           person : array [0..21] of byte;
           money : array [0..21] of longint;
           hs : array [0..21,0..21] of longint;
         end;
const
  b = 20;
  p = 10;
  d = 1000;
var
  a : array [1..20] of nh;
  f : text;
  i , j , q : byte;

procedure writeout;
  var
    i , j , q : byte;
  begin
    for q := 1 to b do
      begin
        with a[q] do
          begin
            {}
            writeln(f,n);
            for i := 1 to n do
              write(f,person[i],' ');
            writeln(f);
            {}
            writeln(f,k);
            for i := 1 to k do
              write(f,money[i]:7);
            writeln(f);
            {}
            for i := 1 to n do
              begin
                for j := 1 to k do
                  write(f,hs[i,j]:7);
                writeln(f);
              end;
          end;
      end;
  end;
BEGIN
  assign(f,'resalo1.inp');
  rewrite(f);
  writeln(f,b,' ',p,' ',d);
  randomize;
  for q := 1 to b do
    begin
      a[q].n := random(10)+1;
      a[q].k := random(10)+1;
      for i := 1 to a[q].n do
        a[q].person[i] := random(10);
      for j := 1 to a[q].k do
        a[q].money[j] := (random(10)+1)*100;
      for i := 1 to a[q].n do
        for j := 1 to a[q].k do
          a[q].hs[i,j] := (random(10)+1)*100;
      a[q].hs[1,1] := 0;
      a[q].person[1] := 0;
      a[q].money[1] := 0;
    end;
  writeout;
  close(f);
END.