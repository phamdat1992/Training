{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}

(* Thang Bom va con Muc *)

uses  crt;
const inp = 'DOG.INP';
      out = 'DOG.OUT';
      mn  = 100;
      esl = 1.e-9; { Hang so epsilon giup tranh sai so }
type  point = record
                x, y : real;
                { Chu y : !!! }
                { Input : x, y : integer }
                { Khai bao : x, y : real moi chinh xac }
              end;
      arr1point= array [ 1..mn ] of point;
      arr1byte = array [ 1..mn ] of byte;
      arr2byte = array [ 1..mn ] of arr1byte;
var   f : text;
      A, B : arr1point;
      { A : Duong di cua Bom }
      { B : Diem hap dan cua con Muc }
      Q, trc, ske, job, worker : arr1byte;
      ke : arr2byte;
      n, m, i, j, i1, j1, dau, cuoi, shd : integer;
      pf : boolean;
      tbegin, time : longint;
      tnow : longint absolute 0:1132;

procedure input;
begin
  assign(f,inp);
    reset(f);
    readln(f,n,m);
    for i := 1 to n do read(f,A[i].x,A[i].y);
    for i := 1 to m do read(f,B[i].x,B[i].y);
  close(f);
end;

procedure init;
begin
  shd := 0;
  fillchar(ske, sizeof(ske), 0);
  fillchar(job, sizeof(job), 0);
  fillchar(worker, sizeof(worker), 0);
end;

function  kc(P, Q : point) : real;
begin
  kc := sqrt((P.x-Q.x)*(P.x-Q.x) + (P.y-Q.y)*(P.y-Q.y));
  { khong nen dung ham sqr(), vi no tra lai gia tri co kieu bien trung voi
    kieu bien cho vao }
end;

procedure lapke;
begin
  for i := 1 to n-1 do
    for j := 1 to m do
      if kc(A[i],B[j]) + kc(B[j],A[i+1]) < 2*kc(A[i],A[i+1]) + esl
      then begin
             inc(ske[i]);
             ke[i,ske[i]] := j;
           end;
end;

procedure init_bfs;
begin
  dau := 1;
  cuoi:= 1;
  Q[1] := i;
  fillchar(trc, sizeof(trc), 0);
end;

procedure bfs;
begin
  init_bfs;
  while dau <= cuoi do
    begin
      i1 := Q[dau];
      inc(dau);
      for j := 1 to ske[i1] do
        begin
          j1 := ke[i,j];
          if trc[j1] = 0
          then begin
                 trc[j1] := i1;
                 if worker[j1] = 0
                 then begin
                        pf := true;
                        exit;
                      end;
                 inc(cuoi);
                 Q[cuoi] := worker[j1];
               end;
        end;
    end;
end;

procedure find_path;
begin
  pf := false;
  for i := 1 to n-1 do
    if job[i] = 0
    then begin
           bfs;
           if pf then exit;
         end;
end;

procedure up;
var fu : integer;
begin
  repeat
    fu := job[trc[j1]];
    job[trc[j1]] := j1;
    worker[j1] := trc[j1];
    if trc[j1] = i then exit else j1 := fu;
  until false;
end;

procedure max_matching;
begin
  repeat
    find_path;
    if pf then up else exit;
  until false;
end;

procedure make_res;
begin
  for i := 1 to n do
    if job[i] > 0 then inc(shd);
end;

procedure test;
begin
  lapke;
  max_matching;
  make_res;
end;

procedure result;
begin
  assign(f,out);
    rewrite(f);
    writeln(f,n+shd);
    for i := 1 to n do
      begin
        write(f,A[i].x:0:0,' ',A[i].y:0:0,' ');
        if job[i] > 0 then write(f,B[job[i]].x:0:0,' ',B[job[i]].y:0:0,' ');
      end;
  close(f);
end;

BEGIN
  clrscr;
  input;
  init;
  test;
  result;
END.

2 1
0 0 2 2
3 3