{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65384,0,655360}
uses crt;
const
  fi = 'mess.inp';
  fo = 'mess.out';
  maxn = 100;

var
  a : array [1..maxn+1,1..maxn+1] of integer;
  p : array [1..maxn+1] of byte;
  dd : array [1..maxn+1] of integer;
  n , m , s , t , cp , q : integer;
  ok : boolean;

procedure init;
  var
    f : text;
    i , b , c , d : integer;
  begin
    assign(f,fi);
    reset(f);
    readln(f,n,m,s,t);
    for i := 1 to m do
      begin
        readln(f,b,c,d);
        a[b,c] := d;
        a[c,b] := d;
      end;
    close(f);
    cp := 0;
  end;

procedure timduong;
  var
    i , j : byte;
  begin
    fillchar(p,sizeof(p),0);
    for i := 1 to n do dd[i] := 10000;
    dd[s] := 0;
    p[s] := 0;
    repeat
      ok := true;
      for i := 1 to n do
        for j := 1 to n do if a[i,j] <> 0 then
          if dd[i] + a[i,j] < dd[j] then
            begin
              dd[j] := dd[i] + a[i,j];
              ok := false;
              p[j] := i;
            end;
    until ok;
  end;

procedure thaydoi;
  var
    i , j : byte;
  begin
    i := t;
    repeat
      j := p[i];
      if a[j,i] > 0 then
        begin
          a[i,j] := -a[j,i];
          a[j,i] := 0;
        end;
      if a[j,i] < 0 then
        begin
          a[j,i] := -a[j,i];
          a[i,j] := a[j,i];
        end;
      i := j;
    until i = s;
  end;

procedure writeout;
  var
    i , j : byte;
  begin
    i := s;
    write(i : 4);
    repeat
      for j := 1 to n do if a[j,i] < 0 then break;
      a[j,i] := -a[j,i];
      a[i,j] := a[j,i];
      write(j : 4);
      inc(cp,a[i,j]);
      i := j;
    until i = t;
    writeln;
  end;

procedure work;
  begin
    timduong;
    thaydoi;
  end;

BEGIN
  clrscr;
  init;
  q := 0;
  repeat
    inc(q);
    work;
  until q = 2;
  writeout;
  writeout;
  writeln(cp);
  readln;
END.
5 7 1 5
1 2 3
1 4 8
2 3 5
1 4 4
3 5 5
4 3 8
4 5 3

5 5 1 5
1 2 1
2 3 1
3 5 1
1 4 1
4 5 1