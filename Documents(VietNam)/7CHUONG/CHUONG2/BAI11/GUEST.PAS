{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}

(* Moi khack du tiec ( de quy co nho ) *)

uses  crt;
const inp = 'GUEST.IN1';
      out = 'GUEST.OUT';
      mn  = 1000;
type  arr1lint = array [ 1..mn ] of longint;
      arr1byte = array [ 1..mn ] of byte;
      arr1bool = array [ 1..mn ] of boolean;
      arr1inte1 = array [ 1..mn ] of integer;
      arr1inte2 = array [ 1..20 ] of integer;
      arr2inte2 = array [ 1..mn ] of arr1inte2;
var   f : text;
      kq : arr1lint;
      s_ong, dd : arr1byte;
      moi : arr1bool;
      sep, vuive : arr1inte1;
      con : arr2inte2;
      sng, smoi, i, j, goc, max : longint;

procedure input;
begin
  assign(f,inp);
    reset(f);
    readln(f,sng);
    for i := 1 to sng do
      begin
        readln(f,sep[i],vuive[i]);
        if sep[i] = 0 then goc := i;
      end;
  close(f);
end;

procedure init;
begin
  smoi := 0;
  for i := 1 to sng do kq[i] := -1;
  fillchar(s_ong, sizeof(s_ong), 0);
  fillchar(moi, sizeof(moi), false);
end;

procedure xd_con;
begin
  for i := 1 to sng do
    for j := 1 to sng do
      if sep[j] = i
      then begin
             inc(s_ong[i]);
             con[i,s_ong[i]] := j;
           end;
end;

function  vui(dinh : longint) : longint;
var gt1, gt2, d1, d2, c : longint;
begin
  gt1 := 0; { tong do vui ve cua cac con }
  for d1 := 1 to s_ong[dinh] do
    begin
      if kq[con[dinh,d1]] = -1 then kq[con[dinh,d1]] := vui(con[dinh,d1]);
      inc(gt1,kq[con[dinh,d1]]);
    end;
  {-------------------------------------------------------------------------}
  gt2 := vuive[dinh]; { tong do vui ve cua ban than va cac chau }
  for d1 := 1 to s_ong[dinh] do
    begin
      c := con[dinh,d1];
      for d2 := 1 to s_ong[c] do
        begin
          if kq[con[c,d2]] = -1 then kq[con[c,d2]] := vui(con[c,d2]);
          inc(gt2,kq[con[c,d2]]);
        end;
    end;
  {-------------------------------------------------------------------------}
  if gt1 < gt2
  then begin
         kq[dinh]  := gt2;
         moi[dinh] := true;
       end
  else kq[dinh] := gt1;
  vui := kq[dinh];
end;

procedure xet_moi(dinh : integer);
var d1, d2, c : longint;
begin
  if moi[dinh]
  then begin
         inc(smoi);
         dd[dinh] := 1;
         for d1 := 1 to s_ong[dinh] do
           begin
             c := con[dinh,d1];
             for d2 := 1 to s_ong[c] do xet_moi(con[c,d2]);
           end;
       end
  else for d1 := 1 to s_ong[dinh] do xet_moi(con[dinh,d1]);
end;

procedure test;
begin
  xd_con;
  max := vui(goc);
  xet_moi(goc);
end;

procedure result;
begin
  assign(f,out);
    rewrite(f);
    writeln(f,smoi,' ',max);
    for i := 1 to sng do
      if dd[i] = 1 then writeln(f,i);
  close(f);
end;

BEGIN
  clrscr;
  input;
  init;
  test;
  result;
END.

12
0 1
1 1
1 1
1 1
2 1
2 1
3 1
4 1
4 1
5 1
5 1
5 1

3
0 3
1 6
2 4

7
0 1
1 1
1 12
2 50
2 1
3 1
3 1
5 40
11 6
11 12
5 5
