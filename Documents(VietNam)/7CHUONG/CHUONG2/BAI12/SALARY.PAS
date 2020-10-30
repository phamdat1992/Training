{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}

(* Xac dinh muc luong hop ly *)

uses  crt;
const inp = 'SALARY.INP';
      out = 'SALARY.OUT';
      fu  = 'SALARY.BTE';
      mn  = 1000;
type  arr1inte1 = array [ -mn..mn ] of integer;
      arr1inte2 = array [ 1..mn ] of integer;
var   f1 : text;
      f2 : file of byte;
      tt : arr1inte1;
      luong1, luong2 : arr1inte2;
      n, i, j, dau, cuoi : integer;
      qhe, q1, q2 : byte;
      ok : boolean;
      Smin, Smax, chenh, tbegin, time : longint;
      tnow : longint absolute 0:1132;

procedure first;
begin
  assign(f1,inp); reset(f1);
  readln(f1,n);
  readln(f1,Smin,Smax,chenh);
  assign(f2,fu); rewrite(f2);
  qhe := 0;
    for i := 1 to n do
      for j := 1 to n do write(f2,qhe);
  close(f2);
end;

procedure second;
begin
  assign(f2,fu); reset(f2);
  while not seekeof(f1) do
    begin
      readln(f1,i,j,qhe);
      seek(f2,(i-1)*n+j - 1);
      write(f2,qhe);
      seek(f2,(j-1)*n+i - 1);
      qhe := 6-qhe;
      write(f2,qhe);
    end;
  time := tnow - tbegin;
  writeln('Thoi gian doc va ghi file = ',time,' ',time/18.2 :5:2);
end;

procedure ktra;
begin
  writeln('Ma tran quan he :');
  seek(f2,0);
  for i := 1 to n do
    begin
      for j := 1 to n do
        begin
          read(f2,qhe);
          write(qhe,' ');
        end;
      writeln;
    end;
end;

procedure init;
begin
  dau := -1;
  cuoi:= 0;
  ok := true;
end;

procedure chen(j : integer);
var d1 : integer;
begin
  inc(cuoi);
  for d1 := cuoi downto j+1 do tt[d1] := tt[d1-1];
  tt[j] := i;
end;

procedure sapxep;
begin
  seek(f2,1);
  read(f2,qhe);
  case qhe of
  1,2,3 : begin
            tt[dau] := 1;
            tt[cuoi]:= 2;
          end;
  4,5   : begin
            tt[dau] := 2;
            tt[cuoi]:= 1;
          end;
  end; { of case }
  {-------------------------------------------------------------------------}
  for i := 3 to n do
    begin
      {---------------------------------------------------------------------}
      seek(f2,(tt[dau]-1)*n+i-1);
      read(f2,qhe);
      if (qhe = 3) or (qhe = 4) or (qhe = 5)
      then begin
             dec(dau);
             tt[dau] := i;
           end
      {---------------------------------------------------------------------}
      else begin
             seek(f2,(tt[cuoi]-1)*n+i-1);
             read(f2,qhe);
             if (qhe = 1) or (qhe = 2) or (qhe = 3)
             then begin
                    inc(cuoi);
                    tt[cuoi] := i;
                  end
                  {---------------------------------------------------------}
             else for j := succ(dau) to cuoi do
                    begin
                      seek(f2,(tt[j-1]-1)*n+i-1);
                      read(f2,q1);
                      seek(f2,(tt[j]-1)*n+i-1);
                      read(f2,q2);
                      if ((q1 = 1) or (q1 = 2) or (q1 = 3))
                         and ((q2 = 3) or (q2 = 4) or (q2 = 5))
                      then chen(j);
                    end;
           end;
      {---------------------------------------------------------------------}
    end;
  writeln;
  for i := dau to cuoi do write(tt[i],' ');
  writeln;
end;

procedure tinhmin;
begin
  luong1[tt[dau]] := Smin;
  for i := dau+1 to cuoi do
    begin
      seek(f2,(tt[i-1]-1)*n+tt[i]-1);
      read(f2,qhe);
      if (qhe = 3) or (qhe = 4)
      then luong1[tt[i]] := luong1[tt[i-1]]
      else luong1[tt[i]] := luong1[tt[i-1]]+chenh;
      if luong1[tt[i]] > Smax
      then begin
             ok := false;
             exit;
           end;
    end;
end;

procedure tinhMax;
begin
  luong2[tt[cuoi]] := Smax;
  for i := cuoi-1 downto dau do
    begin
      seek(f2,(tt[i+1]-1)*n+tt[i]-1);
      read(f2,qhe);
      if (qhe = 3) or (qhe = 2)
      then luong2[tt[i]] := luong2[tt[i+1]]
      else luong2[tt[i]] := luong1[tt[i+1]]-chenh;
      if luong2[tt[i]] < Smin
      then begin
             ok := false;
             exit;
           end;
    end;
end;

procedure test;
begin
  sapxep;
  tinhmin;
  if ok then tinhMax;
end;

procedure result;
begin
  assign(f1,out);
    rewrite(f1);
    if not ok
    then writeln(f1,'KHONG')
    else begin
           writeln(f1,'CO');
           for i := 1 to n do writeln(f1,(luong1[i]+luong2[i])/2 :0:0);
         end;
  close(f1);
end;

BEGIN
  tbegin := tnow;
  clrscr;
  first;
  second;
  ktra;
  init;
  test;
  result;
  close(f2);
  time := tnow - tbegin;
  writeln('Time = ',time,' ',time/18.2 :5:2);
END.

5
1 10 1
1 2 1
1 3 1
1 4 1
1 5 1
2 3 5
2 4 1
2 5 1
3 4 5
3 5 5
4 3 2
4 5 3
5 3 2
