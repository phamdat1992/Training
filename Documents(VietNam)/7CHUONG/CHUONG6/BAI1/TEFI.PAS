program tefi;

{ dem so chu cai T, E, F, I ve bang dau '*' trong mot file }

uses  crt;
const inp = 'tefi.inp';
      mn  = 1024;
type  arr1byte = array [ 1..mn ] of byte;
      arr1char = array [ 0..mn ] of char;
var   f : text;
      nn : arr1byte;
      dt, dn, ds : arr1char;
      m, i, j, demT, demE, demF, demI : integer;

procedure init;
begin
  dt[0] := ' ';
  dn[0] := ' ';
  ds[0] := ' ';
  dn[succ(m)] := ' ';
  ds[succ(m)] := ' ';
  for i := 0 to m do dn[i] := ' ';
end;

procedure readF(var dong : arr1char);
var d1, d2 : integer;
begin
  d1 := 0;
  while not eoln(f) do
    begin
      inc(d1);
      read(f,dong[d1]);
    end;
  for d2 := succ(d1) to m do dong[d2] := ' ';
  readln(f);
end;


function  dau_chu(i : integer) : boolean;
begin
  dau_chu := ( dn[pred(i)] = ' ' )
             and ( dn[i] = '*' )
             and ( dt[i] = ' ' );
end;

function  cuoi_chu(i : integer) : boolean;
begin
  cuoi_chu := ( dn[pred(i)] = ' ' )
              and ( dn[i] = '*' )
              and ( ds[i] = ' ' )
              and ( nn[i] > 0 );
end;

procedure gap_dau_chu;
begin
  if dn[succ(i)] = ' '
  then nn[i] := 4 { gap chu I }
  else if ds[i] = ' '
       then begin { gap chu T }
              j := succ(i);
              while ds[j] = ' ' do inc(j);
              nn[j]  := 1;
            end
       else nn[i] := 23; { gap E hoac F }
end;

procedure gap_cuoi_chu;
begin
  case nn[i] of
    4 : begin
          inc(demI);
          nn[i] := 0;
        end;
    23: begin
          if dn[succ(i)] = ' ' then inc(demF)
                               else inc(demE);
          nn[i] := 0;
        end;
    1 : begin
          inc(demT);
          nn[i] := 0;
        end;
  end; { of case }
end;

procedure test;
begin
  readF(ds);
  repeat
    dt := dn;
    dn := ds;
    readF(ds);
    if eof(f) then
      for i := 1 to m do ds[i] := ' ';
    for i := 1 to m do
      if dau_chu(i)
      then gap_dau_chu
      else if cuoi_chu(i)
           then gap_cuoi_chu;


  until eof(f);
end;

procedure result;
begin
  writeln('Ket qua :');
  writeln('T = ',demT);
  writeln('E = ',demE);
  writeln('F = ',demF);
  writeln('I = ',demI);
end;

BEGIN
  clrscr;
  assign(f,inp);
    reset(f);
    readln(f,m);
    init;
    test;
  close(f);
  result;
END.

45
    ***********   *********   ***********   *
         *        *           *             *
         *        *           *             *
         *        *******     *********     *
         *        *           *             *
         *        *           *             *
         *        *********   *             *


32
*******************************
    *
    *    ******************
    *    *
    *    *                  *
    *    **************     *
    *    *                  *
    *    *
    *    ******************

77

****************************************************************************
                *
                *
                *        ***************************************************
                *        *
*               *        *      *                *             *
*               *        *      *                *             *
*               *        *      *                *             *
*               *        *      *                *             *
*               *        *
*               *        ***************************************************
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
*               *        *
                *        *
                *        ***************************************************

