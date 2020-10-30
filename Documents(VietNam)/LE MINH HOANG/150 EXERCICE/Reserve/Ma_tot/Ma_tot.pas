{* Tren ban co cho vi tri quan tot va 1 quan ma. quan tot chi di chuyen xuong
   duoi con quan ma di theo qui tac dich chuyen co vua. Quan tot di truoc roi
   den ma cu nhu the.
   - Ma thang neu nhu o nuoc di ke tiep no an duoc quan tot.
   - Ma hoa tot neu nuoc di ke tiep no chan dau con tot
   - Ma thua neu tot den duoc o o dong n.
 * Du lieu :
   - N - kich thuoc ban co (N <= 100).
   - toa do ma (cot truoc dong sau)
   - Toa do tot (cot truoc dong sau).
 * Ket qua :
   - thang ghi 1, hoa ghi 0, thua gi -1
   - Neu ko thua ghi hanh trinh quan ma (cot truoc dong sau). }

{$R+}

Const
     fi = 'm9.';
     fo = 'm9.out';
     ktmax = 100;
     vc = 30000;

     dx : array [1..8] of shortint = (-2, -2, -1, 1, 2, 2, 1, -1);
     dy : array [1..8] of shortint = (-1, 1, 2, 2, 1, -1, -2, -2);

Type
    cs = record
       d, c : integer;
    end;

Type
    mang = array [1..ktmax * ktmax] of cs;
Var
   pred, nuoc : array [-1..ktmax + 2, -1..ktmax + 2] of integer;
   q : ^mang;
   f : text;
   m, n, dma, cma, dtot, ctot, nuocdi : integer;

Procedure Init;
Begin
  assign(f, fi); reset(f);
  readln(f, n);
  readln(f, cma, dma);
  readln(f, ctot, dtot);
  close(f);

  assign(f, fo); rewrite(f);
  new(q);
End;

{******************************************}

Function tot(x, y, k : integer) : boolean;
Begin
  if pred[x + dx[k], y + dy[k]] = vc then tot := true
     else tot := false;
End;
{**************}
Function denduoc(d, c, ddai : integer) : boolean;
Var
   nho, dd, top, ii, last, i, j, x, y, k : integer;

Begin
  fillchar(q^, sizeof(q^), 0);
  fillchar(nuoc, sizeof(nuoc), 0);
  q^[1].d := dma; q^[1].c := cma;
  top := 1; last := 1;

  for i := -1 to ktmax + 2 do
      for j := -1 to ktmax + 2 do pred[i, j] := vc - 1;
  for i := 1 to n do
      for j := 1 to n do pred[i, j] := vc;
  pred[dma, cma] := vc - 1;
  nuoc[dma, cma] := 0;
  dd := 0;

  while (dd < ddai) and (last <= top) do
        begin
             inc(dd);
             nho := top;
             for ii := last to top do
                 begin
                      x := q^[ii].d; y := q^[ii].c;
                      inc(last);

                      for k := 1 to 8 do
                          if tot(x, y, k) then
                             begin
                                  inc(top);
                                  q^[top].d := x + dx[k];
                                  q^[top].c := y + dy[k];
                                  pred[x + dx[k], y + dy[k]] := k;
                                  nuoc[x + dx[k], y + dy[k]] := dd;
                             end;
                 end;
             last := nho + 1;
        end;

    if (pred[d, c] = vc) then denduoc := false
       else if ((nuoc[d, c] = ddai) or (nuoc[d, c] = ddai - 2)) then denduoc := true
            else denduoc := false;
End;
{***************}
Procedure khoiphuc(d, c : integer);
Begin
     if pred[d, c] <> vc - 1 then
        begin
             khoiphuc(d - dx[pred[d, c]], c - dy[pred[d, c]]);
             writeln(f, c, ' ',d);
        end
        else writeln(f, c,' ',d);
End;
{***************}
Function inside(i, j, k : integer) : boolean;
Begin
  inside := false;

  if i + dx[k] < 1 then exit;
  if j + dy[k] < 1 then exit;
  if i + dx[k] > n then exit;
  if j + dy[k] > n then exit;

  inside := true;
End;
{***************}
Function thang : boolean;
Var
   i, k : integer;

Begin
  for i := dtot + 1 to n - 1 do
      if denduoc(i, ctot, i - dtot) then
         begin
            nuocdi := i - dtot;
            writeln(f, 1);
            writeln(f, nuocdi);

            if nuoc[i, ctot] = nuocdi - 2 then {ma di cau gio 1 lan}
               begin
                    for k := 1 to 8 do
                        if inside(i, ctot, k) then
                           begin
                                writeln(f, i + dx[k],' ',ctot + dy[k]);
                                break;
                           end;
               end;
            khoiphuc(i, ctot);
            thang := true;
            exit;
         end;

  thang := false;
End;
{********************}
Function hoa : boolean;
Var
   i, k : integer;

Begin
  for i := dtot + 1 to n do
      if denduoc(i, ctot, i - dtot - 1) then
         begin
            nuocdi := i - dtot - 1;
            hoa := true;
            writeln(f, 0);
            writeln(f, nuocdi);
            if nuoc[i, ctot] = nuocdi - 2 then {ma di cau gio 1 lan}
               begin
                    for k := 1 to 8 do
                        if inside(i, ctot, k) then
                           begin
                                writeln(f, i + dx[k],' ',ctot + dy[k]);
                                break;
                           end;
               end;
            khoiphuc(i, ctot);
            exit;
         end;

  hoa := false;
End;
{******************}
Procedure thua;
Begin
  writeln(f, -1);
End;

Begin
  Init;
  if not thang then
     if not hoa then
        thua;
  close(f);
End.