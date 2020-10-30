{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}

(* Tim so it nhat cac doan thang phu kin doan PQ *)
(* ( cac doan deu nam tren Ox )                  *)

uses  crt;
const inp = 'PHU.INP';
      out = 'PHU.OUT';
      mn  = 5000; { dk : Q-P <= 5000 }
type  arr1lint = array [ 0..mn ]  of longint;
var   f : text;
      chon, cuoi, cs : arr1lint;
      stop : boolean;
      m, n, i, j, k, P, Q, dem, schon, cso : longint;

function  max(so1, so2 : longint) : longint;
begin
  if so1 > so2 then max := so1
               else max := so2;
end;

function  min(so1, so2 : longint) : longint;
begin
  if so1 < so2 then min := so1
               else min := so2;
end;

procedure init;
begin
  stop := false;
  schon := -1;
  fillchar(cs, sizeof(cs), 0);
  for i := 0 to mn do cuoi[i] := -1;
end;

procedure input;
begin
  assign(f,inp);
    reset(f);
    readln(f,n,P,Q);
    for dem := 1 to n do
      begin
        readln(f,i,j);
        if (i < Q) and (j > P)
        then begin
               i := max(i,P);
               j := min(j,Q);
               if (i < j) and (j-i > cuoi[i-P])
               then begin
                      cuoi[i-P] := j-i;
                      cs[i-P] := dem;
                    end;
             end;
      end;
  close(f);
end;

procedure answer_no;
begin
  assign(f,out);
    rewrite(f);
    writeln(f,0);
  close(f);
end;

procedure tim_cuoi;
begin
  k := j;
  m := j-1;
  repeat
    dec(k);
    if (cuoi[k] > 0) and (m < k+cuoi[k])
    then begin
           m := k+cuoi[k];
           cso := k;
         end;
  until k = i+1;
  if m = j-1 then stop := true
             else i := cso;
end;

procedure test;
begin
  i := 0;
  repeat
    j := i + cuoi[i];
    inc(schon);
    chon[schon] := cs[i];
    if j >= Q-P then exit;
    if cuoi[j] = -1 then tim_cuoi
                    else i := j;
  until stop;
end;

procedure result;
begin
  assign(f,out);
    rewrite(f);
    writeln(f,schon+1);
    for i := 0 to schon do writeln(f,chon[i]);
  close(f);
end;

BEGIN
  clrscr;
  init;
  input;
  if cuoi[0] = -1 then answer_no
                  else test;
  if stop then answer_no
          else result;
END.