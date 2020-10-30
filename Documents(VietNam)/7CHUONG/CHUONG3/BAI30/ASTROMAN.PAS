{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65521,0,655360}
program lac_vao_hanh_tinh_la;
uses  crt;
const inp = 'astroman.inp';
      out = 'astroman.out';
      mn = 8;
      pi : array [ 1..5 ] of shortint = (0,-1,0,1,0);
      pj : array [ 1..5 ] of shortint = (-1,0,1,0,0);

{ 2
1 * 3 (5 ð *)
  4         }
{ cac huong di cua nguoi ( co the dung yen ) }

      ri : array [ 1..8 ] of shortint = (-1,-1,-1,0,1,1,1,0);
      rj : array [ 1..8 ] of shortint = (-1,0,1,1,1,0,-1,-1);

{ 1 2 3
  8 * 4
  7 6 5 }
{ cac huong di cua robot }

type arr2char = array [ 0..mn+1, 0..mn+1 ] of char;
     arr3char = array [ 1..20 ] of arr2char;
     arr2bool = array [ 1..mn, 1..mn ] of boolean;
var  f : text;
     map : arr2char;
     resu, temp : arr3char;
     chuaqua : arr2bool;
     m, n, i, j, xpi, xpj, sobuoc, sb_max, huong, max_mn : integer;
     die : boolean;
     tbegin : longint;

procedure init;
begin
  sobuoc := 0;
  for i := 0 to succ(m) do
    for j := 0 to succ(n) do map[i,j] := '#';
  if m > n then max_mn := m else max_mn := n;
end;

procedure input;
begin
  assign(f,inp);
    reset(f);
    readln(f,m,n);
    init;
    for i := 1 to m do
      begin
        for j := 1 to n do
          begin
            read(f,map[i,j]);
            if map[i,j] = '2' then begin
                                     xpi := i;
                                     xpj := j;
                                   end;
          end;
        readln(f);
      end;
  close(f);
end;

function  kcach(rbi, rbj, peri, perj : integer) : real;
begin
  kcach := sqrt( sqr(rbi-peri) + sqr(rbj-perj) );
end;

procedure chon_huong(d1, d2, k, l : integer;var huong : integer);
var t1, k1, l1 : integer;
    kc : real;
begin
  kc := maxint;
  for t1 := 1 to 8 do
    begin
      k1 := d1 + ri[t1];
      l1 := d2 + rj[t1];
      if ( map[k1,l1] <> '#' ) and ( kc > kcach(k1,l1,k,l) )
      then begin
             kc := kcach(k1,l1,k,l);
             huong := t1;
           end;
    end;
end;

procedure robot_go(k, l : integer);
var d1, d2, k1, l1 : integer;
begin
  fillchar(chuaqua, sizeof(chuaqua), true);
  for d1 := 1 to m do
    for d2 := 1 to n do
      if chuaqua[d1,d2] and ( map[d1,d2] = '1' )
      then begin
             chon_huong(d1,d2,k,l,huong);
             k1 := d1 + ri[huong];
             l1 := d2 + rj[huong];
             chuaqua[k1,l1] := false;
             map[d1,d2] := '0';
             if map[k1,l1] = '0'
             then map[k1,l1] := '1'
             else if ( map[k1,l1] = '1' ) and ( not chuaqua[k1,l1] )
                  then map[k1,l1] := '*'
                  else if map[k1,l1] = '2'
                       then begin
                              map[d1,d2] := '1';
                              die := true;
                              exit;
                            end;
            end;
end;

procedure keep_resu;
begin
  resu := temp;
  sb_max := sobuoc;
  die := false;
end;

procedure writeF(rs : arr2char);
var d1, d2 : integer;
begin
  for d1 := 1 to m do
    begin
      for d2 := 1 to n do write(f,rs[d1,d2]);
      writeln(f);
    end;
  writeln(f);
end;

procedure result_N;
begin
  assign(f,out);
    rewrite(f);
    writeln(f,-1);
    for i := 1 to 20 do writeF(resu[i]);
  close(f);
  writeln('Time = ', (meml[0:1132]-tbegin)/18.2 :5:2,#7);
  halt;
end;

procedure try_N(i, j : integer);
var t, k, l : integer;
begin
  for t := 1 to 5 do
    begin
      k := i + pi[t];
      l := j + pj[t];
      if map[k,l] = '0'
      then begin
             map[i,j] := '0';
             map[k,l] := '2';
             robot_go(k,l);
             if sobuoc = 20 then result_N;
             inc(sobuoc);
             resu[sobuoc] := map;
             try_N(k,l);
           end;
    end;
end;

procedure never_die(k, l : integer);
begin
  resu := temp;
  try_N(k,l);
end;

procedure try(i, j : integer);
var luu : arr2char;
    t, k, l : integer;
begin
  luu := map;
  for t := 1 to 5 do
    begin
      k := i + pi[t];
      l := j + pj[t];
      if map[k,l] = '0'
      then begin
             map[i,j] := '0';
             map[k,l] := '2';
             robot_go(k,l);
             inc(sobuoc);
             temp[sobuoc] := map;
             if sobuoc = max_mn then never_die(k,l);
             if die then
               begin
                 if sobuoc > sb_max then keep_resu
               end
             else try(k,l);
             dec(sobuoc);
           end;
      map := luu;
    end;
end;

procedure result;
begin
  assign(f,out);
    rewrite(f);
    writeln(f,sb_max);
    for i := 1 to sb_max do writeF(resu[i]);
  close(f);
  writeln('Time = ', (meml[0:1132]-tbegin)/18.2 :5:2,#7);
end;

BEGIN
  tbegin := meml[0:1132];
  clrscr;
  input;
  try(xpi,xpj);
  result;
END.

7 8
00000000
01000000
00002000
01000010
10000000
01010100
00100000

3 8
00000000
20000000
00000000

{Sai test nay}
4 1
1
1
0
2