{* Cho do thi 2 chieu N dinh va 2 dinh S T. Tim so ctrinh nhieu nhat qua S den
   T roi tro lai S sao cho ko co duong di nao di lai 2 lan trong tat ca cac
   ctrinh
 * Du lieu :
   - N <= 200, M, S, T
   - M dong tiep, moi dong 2 so I J
 * Ket qua :
   - K - so ctrinh max
   - K dong tiep, moi dong 1 ctrinh}

{$R+}
Const
     fi = 'Tours.in0';
     fo = 'Tours.out';
     nmax = 201;
     vc = 255;

Type
    mang = array [1..nmax, 1..nmax] of byte;

Var
   f : text;
   ff, c : ^mang;
   queue, pred : array [1..nmax] of integer;
   n, m, s, t, maxflow, top, last : integer;

Procedure Enter;
Var
   i, j, ii : integer;

Begin
  assign(f, fi); reset(f);
  readln(f, n, m, s, t);

  new(c);
  fillchar(c^, sizeof(mang), 0);
  for ii := 1 to m do
      begin
           readln(f, i, j);
           c^[i, j] := 1;
           c^[j, i] := 1;
      end;

  Close(f);
End;

Procedure Init;
Var
   i : integer;

Begin
  maxflow := 0;
  new(ff);
  fillchar(ff^, sizeof(mang), 0);

  for i := 1 to n do
      begin
        c^[i, s] := 0;
        c^[t, i] := 0;
      end;
End;

Procedure Pre;
Begin
  fillchar(queue, sizeof(queue), 0);
  queue[1] := s;
  fillchar(pred, sizeof(pred), 0);
  pred[s] := vc;

  top := 1; last := 1;
End;

Procedure napxuoi(i, j : byte);
Begin
  inc(top);
  queue[top] := j;
  pred[j] := i;
End;

Procedure napnguoc(i, j : byte);
Begin
  inc(top);
  queue[top] := j;
  pred[j] := -i;
End;

Function Find_path : boolean;
Var
   p, i : byte;

Begin
  Find_path := true;
  Pre;

  while last <= top do
        begin
          p := queue[last]; inc(last);

          for i := 1 to n do
              if pred[i] = 0 then
                 if ff^[p, i] < c^[p, i] then napxuoi(p, i)
                    else if ff^[i, p] > 0 then napnguoc(p, i);

          if pred[t] <> 0 then exit;
        end;

  Find_path := false;
End;

Procedure inc_flow;
Var
   z : byte;

Begin
  z := t;
  while pred[z] <> vc do
        begin
          if pred[z] > 0 then inc(ff^[pred[z], z])
             else dec(ff^[z, abs(pred[z])]);

          z := abs(pred[z]);
        end;
End;

Procedure Mflow;
Begin
  while find_path do inc_flow;
End;

Procedure Pre_fnish;
Var
   i : integer;

Begin
  for i := 1 to n do
      maxflow := maxflow + ff^[i, t];

  c^ := ff^;
  fillchar(ff^, sizeof(mang), 0);
End;

Procedure return1(i : byte);
Begin
  if pred[i] <> vc then
     begin
       return1(pred[i]);
       write(f, i,' ');
     end
     else write(f, i,' ');
End;

Procedure return2(i : byte);
Begin
  if pred[i] <> vc then
     begin
       write(f, i,' ');
       return2(pred[i])
     end
     else write(f, i,' ');
End;

Procedure Print;
Var
   ii : integer;

Begin
  assign(f, fo); rewrite(f);
  writeln(f, maxflow div 2);

  for ii := 1 to maxflow div 2 do
      begin
        if Find_path then
           begin
             inc_flow;
             return1(t);
           end;

        if Find_path then
           begin
             inc_flow;
             return2(pred[t]);
           end;

        writeln(f);
      end;
  Close(f);
End;

Begin
  Enter;
  Init;
  Mflow;
  Pre_fnish;
  Print;
End.

